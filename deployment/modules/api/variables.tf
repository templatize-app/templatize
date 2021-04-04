variable "environment" {
  description = "The environment name, e.g. prod."
  type        = string
  default     = "dev"
}

variable "auth0_account_name" {
  description = "The Auth0 account name, e.g. something.us.auth0.com."
  type        = string
}

variable "auth0_logo_url" {
  description = "URL to 150px by 150px png of logo"
  type        = string
  default     = null
}

variable "domain" {
  description = "The base domain name, e.g. example.com. This value should be sourced from the Cloudflare Zone."
  type        = string
}

variable "cloudflare_zone_id" {
  description = "The Zone ID of the target Cloudflare Zone."
  type        = string
}