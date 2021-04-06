resource "cloudflare_record" "prod_www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  value   = heroku_domain.domain.cname
  type    = "CNAME"
  ttl     = 3600
}

resource "cloudflare_record" "prod_root" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  value   = heroku_domain.domain.cname
  type    = "CNAME" // note: this uses Cloudflare's CNAME flattening
  ttl     = 3600
}