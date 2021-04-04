variable "environment" {
  description = "The environment name, e.g. prod."
  type        = string
  default     = "dev"
}

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

variable "auth0_logo_url" {
  description = "URL to 150px by 150px png of logo"
  type        = string
  default     = null
}

variable "cloudflare_api_token" {
  description = "API Token to authenticate to CloudFlare"
  type        = string
  sensitive   = true
}

variable "cloudflare_origin_ca_key"{
  description = "Origin CA Key for Cloudflare"
  type        = string
  sensitive   = true
}

variable "domain" {
  description = "The base domain name, e.g. example.com. This value should be sourced from the Cloudflare Zone."
  type        = string
}