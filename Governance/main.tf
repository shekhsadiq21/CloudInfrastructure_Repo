terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.67.0"
    }
  }
}

provider "azurerm" {
  subscription_id   = var.subscription_id
  features {}
}

# DNS module
module "dns" {
  source                     = "./DNS"
  location                   = var.location
  environmentPrefix          = var.environmentPrefix
  location_environmentPrefix = var.location_environmentPrefix
  shared_subnet_id           = module.Networking.shared_subnet_id
}

module "container_registry" {
  source              = "./ACR"
  location            = var.location
  environmentPrefix   = var.environmentPrefix
}

# Networking module
module "Networking" {
  source                     = "./Networking"
  EnvironmentNet             = var.EnvironmentNet
  EnvironmentNetClass        = var.EnvironmentNetClass
  environmentPrefix          = var.environmentPrefix
  location_environmentPrefix = var.location_environmentPrefix
}