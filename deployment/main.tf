terraform {
  backend "s3" {
    region = "us-east-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = " ~> 2.1"
    }
    auth0 = {
      source  = "alexkappa/auth0"
      version = " ~> 0.20"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.19"
    }
    heroku = {
      source  = "heroku/heroku"
      version = "~> 4.1"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 2.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1"
    }
  }
}

provider "archive" {}
provider "auth0" {
  domain        = var.auth0_account_name
  client_id     = var.auth0_client_id
  client_secret = var.auth0_client_secret
}
provider "aws" {
  region = "us-east-2"
}
provider "cloudflare" {
  api_token            = var.cloudflare_api_token
  api_user_service_key = var.cloudflare_origin_ca_key
}
provider "heroku" {
  email   = var.heroku_email
  api_key = var.heroku_api_key
}
provider "http" {}
provider "tls" {}

data "cloudflare_zones" "zone" {
  filter {
    name = var.domain
  }
}

resource "cloudflare_zone_settings_override" "settings" {
  zone_id = lookup(data.cloudflare_zones.zone.zones[0], "id")
  settings {
    brotli                   = "on"
    challenge_ttl            = 2700
    security_level           = "high"
    opportunistic_encryption = "on"
    automatic_https_rewrites = "on"
    http3                    = "on"
    minify {
      css  = "on"
      js   = "on"
      html = "off"
    }
    security_header {
      enabled = true
    }
  }
}

module "api_backend" {
  source = "./modules/api"

  domain             = var.domain
  environment        = "prod"
  auth0_account_name = var.auth0_account_name
  auth0_logo_url     = var.auth0_logo_url
  cloudflare_zone_id = cloudflare_zone_settings_override.settings.zone_id
}

module "front_end" {
  source = "./modules/front-end"

  domain             = var.domain
  app_name           = "templatize-app"
  api_domain         = module.api_backend.api_domain
  app_directory      = "${path.root}/../tmpltz-web"
  auth_callback_url  = module.api_backend.auth_callback_url
  auth0_client_id    = var.auth0_web_client_id
  auth0_domain       = var.auth0_account_name
  cloudflare_zone_id = cloudflare_zone_settings_override.settings.zone_id
}