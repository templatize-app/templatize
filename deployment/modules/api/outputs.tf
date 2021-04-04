output "auth_callback_url" {
    value = auth0_client.my_client.callbacks[0]
}