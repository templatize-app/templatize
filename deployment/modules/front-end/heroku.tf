resource "heroku_app" "front_end" {
  name   = var.app_name
  region = "us"

  buildpacks = [
    "heroku/nodejs",
    "heroku-community/static"
  ]

  config_vars = {
    "TMPLTZ_DOMAIN"       = var.domain
    "TMPLTZ_CALLBACK"     = var.auth_callback_url
    "TMPLTZ_API_DOMAIN"   = var.api_domain
    "AUTH0_WEB_CLIENT_ID" = var.auth0_client_id
    "AUTH0_DOMAIN"        = var.auth0_domain
  }
}

resource "heroku_domain" "domain" {
  app      = heroku_app.front_end.name
  hostname = var.domain
}

resource "heroku_build" "front_end_build" {
  app = heroku_app.front_end.id
  source {
    path = var.app_directory
  }
}

resource "heroku_formation" "front_end_formation" {
  app        = heroku_app.front_end.id
  type       = "web"
  quantity   = 1
  size       = "hobby"
  depends_on = [heroku_build.front_end_build]
}
