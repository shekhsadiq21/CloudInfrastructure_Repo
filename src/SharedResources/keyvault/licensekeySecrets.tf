resource "azurerm_key_vault_secret" "HiQPDFLicenseKey" {
  name         = "HiQPDFLicenseKey"
  value        = "WxMyCgs/-PRcyOSk6-KSJqaXVr-e2p7b3ti-Ympse2hq-dWppdWJi-YmI="
  content_type = "HiQPDFLicenseKey"
  key_vault_id = azurerm_key_vault.keyvault.id
}
