resource "cloudflare_record" "prod_api" {
  zone_id = var.cloudflare_zone_id
  name    = "api"
  value   = aws_apigatewayv2_domain_name.prod_domain.domain_name_configuration[0].target_domain_name
  type    = "CNAME"
  ttl     = 3600
}