resource "auth0_client" "my_client" {
  name                                = "Templatize"
  description                         = "templatize.app Application Authentication"
  app_type                            = "spa"
  custom_login_page_on                = true
  is_first_party                      = true
  is_token_endpoint_ip_header_trusted = true
  token_endpoint_auth_method          = "client_secret_post"
  oidc_conformant                     = false
  callbacks                           = ["https://${var.domain}/callback"]
  allowed_origins                     = ["https://${var.domain}"]
  grant_types                         = ["authorization_code", "http://auth0.com/oauth/grant-type/password-realm", "implicit", "password", "refresh_token"]
  allowed_logout_urls                 = ["https://${var.domain}"]
  web_origins                         = ["https://${var.domain}"]

  jwt_configuration {
    lifetime_in_seconds = 300
    secret_encoded      = true
    alg                 = "RS256"
    scopes = {
      foo = "bar"
    }
  }
}

resource "auth0_resource_server" "auth0_api" {
  name        = "Templatize API"
  identifier  = var.domain
  signing_alg = "RS256"

  allow_offline_access                            = false
  token_lifetime                                  = 8600
  skip_consent_for_verifiable_first_party_clients = true
} 