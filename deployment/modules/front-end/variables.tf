variable "domain" {
  description = "The root domain, e.g. example.com."
  type        = string
}

variable "api_domain" {
  description = "The api domain, e.g. api.example.com"
  type        = string
}

variable "app_name" {
  description = "The name of the application."
  type        = string
}

variable "app_directory" {
  description = "The root of the application to be uploaded to Heroku."
  type        = string
}

variable "cloudflare_zone_id" {
  description = "The Zone ID of the target Cloudflare Zone."
  type        = string
}

variable "auth_callback_url" {
  description = "The callback URL used in the authentication process"
  type        = string
}

variable "auth0_client_id" {
  description = "The Auth0 Client ID for the Web App"
  type        = string
}

variable "auth0_domain" {
  description = "The Auth0 domain"
  type        = string
}
