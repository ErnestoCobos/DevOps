module "dns_zone" {
  source       = "./route53"
  route53_zone = "cobos.io"
  records = [
    {
      name    = ""
      type    = "A"
      ttl     = 300
      records = ["162.159.137.9"]
    },
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
        "google-site-verification=bUUhpg9pov_cfk3P6yX8nVd2wBCvS6IVs5rGEF_H3Is"
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
      }, {
      name    = "www.cobos.io"
      type    = "CNAME"
      ttl     = 300
      records = ["ernestocobos.elementor.cloud"]
    },
  ]
}

