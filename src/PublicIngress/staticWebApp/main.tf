locals {
  environmentPrefix   = var.environmentPrefix
  static_web_app_name = "wcp-${local.environmentPrefix}-${var.location_environmentPrefix}-static-frontend-app"
}

resource "azurerm_static_site" "static_web_app" {
  name                = local.static_web_app_name
  resource_group_name = var.public_ingress_resource_group_name
  location            = var.environmentLocation
  tags = {
    Environment = var.environmentPrefix
    Created-by  = "Terraform"
    Owner       = "Guillermo Sanchez"
    Requester   = "Alan Richards"
    CostCenter  = "HCM-ReadyLine-${local.environmentPrefix}"
    Approver    = "Harshith Pingili"
  }
}

resource "azurerm_resource_group_template_deployment" "frontend_appsettings" {
  deployment_mode     = "Incremental"
  name                = "${local.environmentPrefix}-static-frontend-appsettings"
  resource_group_name = var.public_ingress_resource_group_name
  template_content = jsonencode({
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
      "staticSiteName": {
        "type": "string"
      },
      "reactAppEnv": {
        "type": "string"
      },
      "reactAppApiVersion": {
        "type": "string"
      },
      "reactAppAppInsightInstrumentationKey": {
        "type": "string"
      },
      "reactAppAdminBaseUrl": {
        "type": "string"
      },
      "reactAppSettingsBaseUrl": {
        "type": "string"
      },
      "reactAppUserManagementBaseUrl": {
        "type": "string"
      },
      "reactAppEventServiceBaseUrl": {
        "type": "string"
      },
      "reactAppAzureMapSubscriptionKey": {
        "type": "string"
      },
      "reactAppOnlineHelpDarkTheme": {
        "type": "string"
      },
      "reactAppOnlineHelpLightTheme": {
        "type": "string"
      },
      "reactAppGoogleRecaptchaKey": {
        "type": "string"
      }
    },
    "variables": {},
    "outputs": {},
    "resources": [
      {
        "type": "Microsoft.Web/staticSites/config",
        "apiVersion": "2021-03-01",
        "name": "[concat(parameters('staticSiteName'), '/appsettings')]",
        "kind": "string",
        "properties": {
          "REACT_APP_ENV": "[parameters('reactAppEnv')]",
          "REACT_APP_API_VERSION": "[parameters('reactAppApiVersion')]",
          "REACT_APP_APP_INSIGHT_INSTRUMENTATION_KEY": "[parameters('reactAppAppInsightInstrumentationKey')]",
          "REACT_APP_ADMIN_BASE_URL": "[parameters('reactAppAdminBaseUrl')]",
          "REACT_APP_SETTINGS_BASE_URL": "[parameters('reactAppSettingsBaseUrl')]",
          "REACT_APP_USER_MANAGEMENT_BASE_URL": "[parameters('reactAppUserManagementBaseUrl')]",
          "REACT_APP_EVENT_SERVICE_BASE_URL": "[parameters('reactAppEventServiceBaseUrl')]",
          "REACT_APP_AZURE_MAP_SUBSCRIPTION_KEY": "[parameters('reactAppAzureMapSubscriptionKey')]",
          "REACT_APP_ONLINE_HELP_DARK_THEME": "[parameters('reactAppOnlineHelpDarkTheme')]",
          "REACT_APP_ONLINE_HELP_LIGHT_THEME": "[parameters('reactAppOnlineHelpLightTheme')]",
          "REACT_APP_GOOGLE_RECAPTCHA_KEY": "[parameters('reactAppGoogleRecaptchaKey')]"
        }
      }
    ]
  })
  parameters_content = jsonencode({
    staticSiteName = {
      value = azurerm_static_site.static_web_app.name
    },
    reactAppEnv = {
      value = var.react_app_env
    },
    reactAppApiVersion = {
      value = "v1/"
    },
    reactAppAppInsightInstrumentationKey = {
      value = var.appinsights_instrumentation_key
    },
    reactAppAdminBaseUrl = {
      value = var.admin_base_url
    },
    reactAppSettingsBaseUrl = {
      value = var.settings_persistence_base_url
    },
    reactAppUserManagementBaseUrl = {
      value = var.user_management_base_url
    },
    reactAppEventServiceBaseUrl = {
      value = var.event_service_base_url
    },
    reactAppAzureMapSubscriptionKey = {
      value = var.react_azure_map_subscription_key
    },
    reactAppOnlineHelpDarkTheme = {
      value = "https://online-documentation-dark-theme-testing.azureedge.net"
    },
    reactAppOnlineHelpLightTheme = {
      value = "https://online-documentation-light-theme-testing.azureedge.net"
    },
    reactAppGoogleRecaptchaKey = {
      value = "6Le7v9EZAAAAAA-qR_7ug7WChCw1Rvqw307azFBp"
    }
  })
}