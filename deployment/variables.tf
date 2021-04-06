# General
variable "environment" {
  description = "The environment name, e.g. prod."
  type        = string
  default     = "dev"
}

# Auth0
variable "auth0_account_name" {
  description = "The Auth0 account name, e.g. {THIS}.auth0.com."
  type        = string
}

variable "auth0_client_id" {
  description = "The Auth0 Client ID"
  type        = string
}

variable "auth0_client_secret" {
  description = "The Auth0 Client Secret"
  type        = string
  sensitive   = true
}

variable "auth0_web_client_id" {
  description = "The Auth0 Client ID for the web authentication portal."
  type        = string
}

variable "auth0_logo_url" {
  description = "URL to 150px by 150px png of logo"
  type        = string
  default     = null
}

# Cloudflare
variable "cloudflare_api_token" {
  description = "API Token to authenticate to CloudFlare"
  type        = string
  sensitive   = true
}

variable "cloudflare_origin_ca_key" {
  description = "Origin CA Key for Cloudflare"
  type        = string
  sensitive   = true
}

variable "domain" {
  description = "The base domain name, e.g. example.com. This value should be sourced from the Cloudflare Zone."
  type        = string
}

# Heroku
variable "heroku_email" {
  description = "The email address used to authenticate to Heroku."
  type        = string
}

variable "heroku_api_key" {
  description = "The API key used to authenticate to Heroku."
  type        = string
  sensitive   = true
}