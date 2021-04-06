terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 4.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.19"
    }
  }
}