resource "aws_route53_zone" "primary" {
  name = var.route53_zone
}

resource "aws_route53_record" "name" {
  count = length(var.records)
  zone_id = aws_route53_zone.primary.zone_id
  name = var.records[count.index].name
  type = var.records[count.index].type
  ttl = var.records[count.index].ttl
  records = var.records[count.index].records
}