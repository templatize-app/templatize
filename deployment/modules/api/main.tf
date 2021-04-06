terraform {
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
      version = "~> 2.0"
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

locals {
  tags = {
    "app"         = "templatize"
    "environment" = var.environment
    "terraform"   = "true"
  }
}

