resource "aws_apigatewayv2_api" "tmpltz_api" {
  name          = "templatize_http_api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["https://${var.domain}:443"]
  }

  disable_execute_api_endpoint = true
}

resource "aws_apigatewayv2_domain_name" "prod_domain" {
  domain_name = "api.${var.domain}"

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.prod_cert.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_authorizer" "auth" {
  api_id           = aws_apigatewayv2_api.tmpltz_api.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "templatize-authorizer"

  jwt_configuration {
    audience = [auth0_resource_server.auth0_api.identifier]
    issuer   = "https://${var.auth0_account_name}/"
  }
}

resource "aws_apigatewayv2_integration" "template" {
  api_id           = aws_apigatewayv2_api.tmpltz_api.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  description               = "Template Lambda Integration"
  integration_method        = "POST"
  integration_uri           = aws_lambda_function.template_lambda_router.invoke_arn
  passthrough_behavior      = "WHEN_NO_MATCH"
  payload_format_version    = "2.0"
}

resource "aws_apigatewayv2_route" "template" {
  for_each = toset(["PUT", "POST"])

  api_id             = aws_apigatewayv2_api.tmpltz_api.id
  route_key          = "${each.key} /template"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.auth.id
  target             = "integrations/${aws_apigatewayv2_integration.template.id}"
}

resource "aws_apigatewayv2_route" "templates" {
  for_each = toset(["GET"])

  api_id             = aws_apigatewayv2_api.tmpltz_api.id
  route_key          = "${each.key} /templates"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.auth.id
  target             = "integrations/${aws_apigatewayv2_integration.template.id}"
}

resource "aws_apigatewayv2_route" "template_with_id" {
  for_each = toset(["PUT", "POST"])

  api_id             = aws_apigatewayv2_api.tmpltz_api.id
  route_key          = "${each.key} /template/{template_id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.auth.id
  target             = "integrations/${aws_apigatewayv2_integration.template.id}"
}

resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.tmpltz_api.id
  route_key = "$default"
}

resource "aws_apigatewayv2_deployment" "production" {
  api_id      = aws_apigatewayv2_route.default_route.api_id // creates implicit dependency on the route.
  description = "Production deployment"

  triggers = {
    redeployment = sha1(join(",", list(
      jsonencode(aws_apigatewayv2_integration.template),
      jsonencode(aws_apigatewayv2_route.default_route),
      jsonencode(aws_apigatewayv2_route.template),
      jsonencode(aws_apigatewayv2_route.templates),
      jsonencode(aws_apigatewayv2_route.template_with_id),
    )))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_apigatewayv2_stage" "default" {
  api_id        = aws_apigatewayv2_api.tmpltz_api.id
  name          = "$default"
  deployment_id = aws_apigatewayv2_deployment.production.id
}

resource "aws_apigatewayv2_api_mapping" "production_map" {
  api_id      = aws_apigatewayv2_api.tmpltz_api.id
  domain_name = aws_apigatewayv2_domain_name.prod_domain.id
  stage       = aws_apigatewayv2_stage.default.id
}