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

  lifecycle {
    ignore_changes = [ttl, records]  # Ignorar cambios en estos atributos si ya existen
  }
}

resource "aws_route53_record" "alias" {
  count = length(var.alias_records)
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.alias_records[count.index].name
  type    = var.alias_records[count.index].type

  alias {
    name                   = var.alias_records[count.index].alias_name
    zone_id                = coalesce(var.alias_records[count.index].alias_zone_id, var.default_alias_zone_id)
    evaluate_target_health = var.alias_records[count.index].evaluate_target_health
  }
}
