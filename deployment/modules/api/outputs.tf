output "auth_callback_url" {
  value = auth0_client.my_client.callbacks[0]
}

output "api_domain" {
  value = aws_apigatewayv2_domain_name.prod_domain.id
}