locals {
  environmentPrefix                = var.environmentPrefix
  rg_networking_name               = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-networking-rg"
  vnet_name                        = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-vnet"
  nsg_name                         = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-nsg"
  end_user_subnet_name             = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-enduser-snet"
  iot_subnet_name                  = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-iotcomponents-snet"
  shared_subnet_name               = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-sharedresources-snet"
  customer_data_subnet_name        = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-customerdata-snet"
  monitoring_subnet_name           = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-monitoring-snet"
  backend_webapps_asp_subnet_name  = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-backend-webapps-asp-snet"
  frontend_asp_subnet_name         = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-frontend-asp-snet"
  backend_function_asp_subnet_name = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-backend-functions-asp-snet"
  backend_shared_asp_subnet_name   = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-backend-shared-asp-snet"
  container_instance_subnet_name   = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-container-instance-snet"
  network_profile_cis_name         = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-container-instance-np"
}

# Deploy resource group
resource "azurerm_resource_group" "rg_networking" {
  name     = local.rg_networking_name
  location = var.environmentLocation
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Infrastructure"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Martin Politick"
  }
}

# create network security group 
resource "azurerm_network_security_group" "nsg" {
  name                = local.nsg_name
  location            = azurerm_resource_group.rg_networking.location
  resource_group_name = azurerm_resource_group.rg_networking.name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Infrastructure"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Martin Politick"
  }
}

# create Vnet
resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = azurerm_resource_group.rg_networking.location
  resource_group_name = azurerm_resource_group.rg_networking.name
  address_space       = ["${var.EnvironmentNetClass}.${var.EnvironmentNet}.0.0/16"]
  #dns_servers         = ["10.0.0.4", "10.0.0.5"]
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Infrastructure"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Martin Politick"
  }
}

# subnet for endUsers
resource "azurerm_subnet" "end_user_subnet_name" {
  name                 = local.end_user_subnet_name
  resource_group_name  = azurerm_resource_group.rg_networking.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.EnvironmentNetClass}.${var.EnvironmentNet}.0.0/24"]
}

# subnet for iot resources
resource "azurerm_subnet" "iot_subnet_name" {
  name                 = local.iot_subnet_name
  resource_group_name  = azurerm_resource_group.rg_networking.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.EnvironmentNetClass}.${var.EnvironmentNet}.1.0/24"]
  service_endpoints    = ["Microsoft.EventHub"]
  depends_on           = [azurerm_subnet.end_user_subnet_name]
}


# subnet for shared resources
resource "azurerm_subnet" "shared_subnet_name" {
  name                 = local.shared_subnet_name
  resource_group_name  = azurerm_resource_group.rg_networking.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.EnvironmentNetClass}.${var.EnvironmentNet}.3.0/24"]
  service_endpoints    = ["Microsoft.AzureCosmosDB", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.EventHub"]
  depends_on           = [azurerm_subnet.iot_subnet_name]
}

# subnet for monitoring resources
resource "azurerm_subnet" "monitoring_subnet_name" {
  name                 = local.monitoring_subnet_name
  resource_group_name  = azurerm_resource_group.rg_networking.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.EnvironmentNetClass}.${var.EnvironmentNet}.4.0/24"]
}

# subnet for customer data [Tsi]
resource "azurerm_subnet" "customer_data_subnet_name" {
  name                 = local.customer_data_subnet_name
  resource_group_name  = azurerm_resource_group.rg_networking.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.EnvironmentNetClass}.${var.EnvironmentNet}.5.0/24"]
  service_endpoints    = ["Microsoft.EventHub", "Microsoft.Storage"]
  depends_on           = [azurerm_subnet.shared_subnet_name]
  enforce_private_link_endpoint_network_policies = true 
}

# dedicated subnet for container_instance groups
resource "azurerm_subnet" "container_instance_subnet_name" {
  name                 = local.container_instance_subnet_name
  resource_group_name  = azurerm_resource_group.rg_networking.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.EnvironmentNetClass}.${var.EnvironmentNet}.6.0/24"]
  delegation {
    name = "Microsoft.ContainerInstance.containerGroups"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_profile" "network_profile_cis" {
  name                = local.network_profile_cis_name
  location            = azurerm_resource_group.rg_networking.location
  resource_group_name = azurerm_resource_group.rg_networking.name
  depends_on           = [azurerm_subnet.container_instance_subnet_name]

  container_network_interface {
    name = "containerinstancecnic"

    ip_configuration {
      name      = "containerinstanceipconfig"
      subnet_id = azurerm_subnet.container_instance_subnet_name.id
    }
  }
}

# subnet for asp backend webapps
resource "azurerm_subnet" "backend_webapps_asp_subnet_name" {
  name                 = local.backend_webapps_asp_subnet_name
  resource_group_name  = azurerm_resource_group.rg_networking.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.EnvironmentNetClass}.${var.EnvironmentNet}.101.0/24"]
  service_endpoints    = ["Microsoft.AzureCosmosDB", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.EventHub", "Microsoft.Web"]
  depends_on           = [azurerm_subnet.customer_data_subnet_name]
  delegation {
    name = "Microsoft.Web.serverFarms"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# subnet for asp backend webapps
resource "azurerm_subnet" "frontend_asp_subnet_name" {
  name                 = local.frontend_asp_subnet_name
  resource_group_name  = azurerm_resource_group.rg_networking.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.EnvironmentNetClass}.${var.EnvironmentNet}.102.0/24"]
  service_endpoints    = ["Microsoft.AzureCosmosDB", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.EventHub", "Microsoft.Web"]
  depends_on           = [azurerm_subnet.backend_webapps_asp_subnet_name]
  delegation {
    name = "Microsoft.Web.serverFarms"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]

    }
  }
}

# subnet for asp backend webapps
resource "azurerm_subnet" "backend_function_asp_subnet_name" {
  name                 = local.backend_function_asp_subnet_name
  resource_group_name  = azurerm_resource_group.rg_networking.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.EnvironmentNetClass}.${var.EnvironmentNet}.103.0/24"]
  service_endpoints    = ["Microsoft.AzureCosmosDB", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.EventHub", "Microsoft.Web"]
  depends_on           = [azurerm_subnet.frontend_asp_subnet_name]
  delegation {
    name = "Microsoft.Web.serverFarms"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]

    }
  }
}

# subnet for asp backend webapps
resource "azurerm_subnet" "backend_shared_asp_subnet_name" {
  name                 = local.backend_shared_asp_subnet_name
  resource_group_name  = azurerm_resource_group.rg_networking.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.EnvironmentNetClass}.${var.EnvironmentNet}.104.0/24"]
  service_endpoints    = ["Microsoft.AzureCosmosDB", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.EventHub", "Microsoft.Web"]
  depends_on           = [azurerm_subnet.backend_function_asp_subnet_name]
  delegation {
    name = "Microsoft.Web.serverFarms"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]

    }
  }
}