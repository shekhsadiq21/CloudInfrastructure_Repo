# create a Log analytics workspace
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = local.log_analytics_workspace_name
  location            = azurerm_resource_group.rg_monitoring.location
  resource_group_name = azurerm_resource_group.rg_monitoring.name
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Cloud Leads"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}

# Manages an Application Insights component.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights
resource "azurerm_application_insights" "application_insights" {
  name                = local.application_insights_name
  location            = azurerm_resource_group.rg_monitoring.location
  resource_group_name = azurerm_resource_group.rg_monitoring.name
  workspace_id        = azurerm_log_analytics_workspace.log_analytics_workspace.id
  application_type    = "web"
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Cloud Leads"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}
# To run the Azure CLI step that updates the above App Insights resource to be 
# workspace-based, we need to run a script using the local-exec provisioner.
# Provisioners need to be defined within a resource, so, following the example linked at
# the top of this file, we create a "null_resource" to wrap this.
# For more on the "null_resource" type, see https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource

resource "null_resource" "monitoring_configure_application_insights" {

  # This triggers block allows specifying an arbitrary set of values that, when changed,
  # will cause the resource to be replaced. In this case, we link this App Insights resource
  # configuration to the App Insights resource itself, the resource group, as well as the
  # Log Analytics workspace.
  triggers = {
    ai_name         = azurerm_application_insights.application_insights.name
    rg_name         = azurerm_resource_group.rg_monitoring.name
    la_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  }


  provisioner "local-exec" {
    # Azure CLI documentation for managing App Insights resources:
    # https://docs.microsoft.com/en-us/cli/azure/monitor/app-insights/component?view=azure-cli-latest#az_monitor_app_insights_component_update
    command = "az extension add -n application-insights && az monitor app-insights component update --app ${self.triggers.ai_name} -g ${self.triggers.rg_name} --workspace ${self.triggers.la_workspace_id}"
  }
} 