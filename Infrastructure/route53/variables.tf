variable "route53_zone" {
  type = string
  description = "The name of the Route53 zone to create"
}

variable "records" {
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
  description = "The records to create in the zone"
  default = []
}

variable "alias_records" {
  type = list(object({
    name                    = string
    type                    = string
    alias_name              = string
    alias_zone_id           = string
    evaluate_target_health  = bool
  }))
  description = "The alias records to create in the zone"
  default = []
}

variable "default_alias_zone_id" {
  type        = string
  description = "The default alias zone ID to use if none is provided in the alias record"
}
