
locals {
  environmentPrefix = var.environmentPrefix
  authorization_db  = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-authorizationdb-app"
}


# create a web app 
resource "azurerm_container_group" "authorization_db" {
  name                    = local.authorization_db
  location                = var.environmentLocation
  resource_group_name     = var.backendservices_resource_group_name
  ip_address_type         = "Private"
  network_profile_id      = var.network_profile_cis_id
  os_type                 = "Linux"

  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Revengers"
    Requester   = "Anthony Hsu"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Alan"
  }

  image_registry_credential {
    server = var.acr_login_server
    username = var.acr_username
    password = var.acr_password
  }

  container {
    name   = "spicedb"
    image  = "${var.acr_login_server}/spicedb:latest"
    cpu    = var.cpu
    memory = var.memory

    ports {
        port = 50051
        protocol = "TCP"
      }
      # {
      #   port = 8080
      #   protocol = "TCP"
      # },
      # {
      #   port = 9090
      #   protocol = "TCP"
      # }  
    environment_variables = {
      SPICEDB_DATASTORE_ENGINE = "postgres"
      # C# library will fail due to cert name mismatch, disabling TLS for now
      # SPICEDB_GRPC_TLS_CERT_PATH = "/app/localhost.cert"
      # SPICEDB_GRPC_TLS_KEY_PATH = "/app/localhost.key"
    }
    secure_environment_variables = {
      SPICEDB_GRPC_PRESHARED_KEY = var.spicedb_preshared_key
      SPICEDB_DATASTORE_CONN_URI = var.postgresql_authorization_db_cs
    } 
  } 
}