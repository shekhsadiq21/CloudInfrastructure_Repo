# access policy
output "virtualexpressiondeploymentverification_identity_id" {
  value = azurerm_function_app.function_app.identity.0.tenant_id
}

output "virtualexpressiondeploymentverification_principal_id" {
  value = azurerm_function_app.function_app.identity.0.principal_id
}
