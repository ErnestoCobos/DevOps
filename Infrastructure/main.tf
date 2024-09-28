locals {
  tags = {
    terraform   = "true"
    project     = "cobos.io"
    type        = "core"
    environment = "production"
  }
  vultr_tags = ["terraform", "cobos.io", "cobosio-core", "production"]
}

resource "aws_s3_bucket" "redirect" {
  bucket = "cobos.io"
}

resource "aws_s3_bucket_website_configuration" "redirect_website" {
  bucket = aws_s3_bucket.redirect.bucket

  index_document {
    suffix = "index.html"
  }

  routing_rules = <<EOF
[
  {
    "Condition": {
      "HttpErrorCodeReturnedEquals": "404"
    },
    "Redirect": {
      "HostName": "www.cobos.io",
      "ReplaceKeyPrefixWith": ""
    }
  }
]
EOF
depends_on = [ aws_s3_bucket.redirect ]

}

module "dns_zone" {
  source               = "./route53"
  route53_zone         = "cobos.io"
  default_alias_zone_id = "Z3AQBSTGFYJSTF"  # Hosted Zone ID for S3 website endpoints
  records = [
    {
      name = ""
      type = "MX"
      ttl  = 3600
      records = [
        "1 ASPMX.L.GOOGLE.COM",
        "5 ALT1.ASPMX.L.GOOGLE.COM",
        "5 ALT2.ASPMX.L.GOOGLE.COM",
        "10 ALT3.ASPMX.L.GOOGLE.COM",
        "10 ALT4.ASPMX.L.GOOGLE.COM"
      ]
    },
    {
      name = ""
      type = "TXT"
      ttl  = 3600
      records = [
        "google-site-verification=bUUhpg9pov_cfk3P6yX8nVd2wBCvS6IVs5rGEF_H3Is",
        "openai-domain-verification=dv-J5bQpGTn3ZfrErpgxoAxpHJK"
      ]
    },
    {
      name    = "_amazonses.cobos.io"
      type    = "CNAME"
      ttl     = 300
      records = ["RCG6uJM1HbgxcYjKBNuIAPcALNQBiFXylaL9ah/L0QA="]
    },
    {
      name    = "4qtcyw57owrhim3r4itztcc737vu6fal._domainkey.cobos.io"
      type    = "CNAME"
      ttl     = 300
      records = ["4qtcyw57owrhim3r4itztcc737vu6fal.dkim.amazonses.com"]
    },
    {
      name    = "dvby2dfj3mxprv6qbeu3mhwylz53s7l4._domainkey.cobos.io"
      type    = "CNAME"
      ttl     = 300
      records = ["dvby2dfj3mxprv6qbeu3mhwylz53s7l4.dkim.amazonses.com"]
    },
    {
      name    = "i7pfsb3mgh6idqhlestl3f5i2e5w72sg._domainkey.cobos.io"
      type    = "CNAME"
      ttl     = 300
      records = ["i7pfsb3mgh6idqhlestl3f5i2e5w72sg.dkim.amazonses.com"]
    },
    {
      name    = "janus.cobos.io"
      type    = "CNAME"
      ttl     = 300
      records = ["janusio.synology.me"]
    },
    {
      name    = "no-replay.cobos.io"
      type    = "MX"
      ttl     = 300
      records = ["10 feedback-smtp.us-east-1.amazonses.com"]
    },
    {
      name    = "no-replay.cobos.io"
      type    = "TXT"
      ttl     = 300
      records = ["v=spf1 include:amazonses.com ~all"]
    },
    {
      name    = "blog.cobos.io"
      type    = "A"
      ttl     = 300
      records = ["162.159.153.4", "162.159.152.4"]
    },
    {
      name    = "ve.cobos.io"
      type    = "A"
      ttl     = 300
      records = ["192.168.245.8"]
    },
    {
      name    = "poe.cobos.io"
      type    = "A"
      ttl     = 300
      records = ["192.227.177.13"]
    },
    {
      name    = "docker.cobos.io"
      type    = "A"
      ttl     = 300
      records = ["192.168.245.14"]
    },
    {
      name    = "code.cobos.io"
      type    = "A"
      ttl     = 300
      records = ["192.227.177.13"]
    },
    {
      name    = "vm.cobos.io"
      type    = "A"
      ttl     = 300
      records = ["192.168.245.15"]
    },
    {
      name = "_notion-dcv.www"
      type = "TXT"
      ttl  = 3600
      records = [
        "9c373976-a120-480e-9730-bf69f7462b67"
      ]
    },
    {
      name                   = "www.cobos.io"
      type                   = "CNAME"
      ttl                    = 3600
      records                = ["external.notion.site"]
    }
  ]
  alias_records = [
    {
      name                   = "cobos.io"
      type                   = "A"
      alias_name             = aws_s3_bucket.redirect.website_endpoint
      alias_zone_id          = "Z3AQBSTGFYJSTF"
      evaluate_target_health = false
    },
  ]
  depends_on = [ aws_s3_bucket.redirect ]
}
