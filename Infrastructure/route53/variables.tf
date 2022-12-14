variable "route53_zone" {
  type = string
  description = "The name of the Route53 zone to create"
}

variable "records" {
  type = list(object({
    name = string
    type = string
    ttl = number
    records = list(string)
  }))
  description = "The records to create in the zone"
  default = []
}