# Importing built-in Policies
data "azurerm_policy_definition" "api_app_https_policy" {
  display_name = "API App should only be accessible over HTTPS"
}
data "azurerm_policy_definition" "function_app_https_policy" {
  display_name = "Function App should only be accessible over HTTPS"
}
data "azurerm_policy_definition" "web_app_https_policy" {
  display_name = "Web Application should only be accessible over HTTPS"
}
data "azurerm_policy_definition" "app_services_disable_public_policy" {
  display_name = "App Services should disable public network access"
}
data "azurerm_policy_definition" "api_app_require_auth_policy" {
  display_name = "Authentication should be enabled on your API app"
}
data "azurerm_policy_definition" "function_app_require_auth_policy" {
  display_name = "Authentication should be enabled on your Function app"
}
data "azurerm_policy_definition" "web_app_require_auth_policy" {
  display_name = "Authentication should be enabled on your web app"
}
data "azurerm_policy_definition" "api_app_configure_cors_policy" {
  display_name = "CORS should not allow every resource to access your API App"
}
data "azurerm_policy_definition" "function_app_configure_cors_policy" {
  display_name = "CORS should not allow every resource to access your Function Apps"
}
data "azurerm_policy_definition" "web_app_configure_cors_policy" {
  display_name = "CORS should not allow every resource to access your Web Applications"
}

# Definition of custom Initiative
resource "azurerm_policy_set_definition" "app_service_policy_set_definition" {
  name         = "[APP SERVICE] Non-Prod INITIATIVE"
  policy_type  = "Custom"
  display_name = "[APP SERVICE] Non-Prod INITIATIVE for ${var.environment_name}"

  parameters = <<PARAMETERS
  {
    "api_app_https_effect": {
      "type": "String",
      "metadata": {
        "displayName": "API App HTTPS-only effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "Audit",
        "Disabled"
      ],
      "defaultValue": "Audit"
	  },
    "function_app_https_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Function App HTTPS-only effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "Audit",
        "Disabled"
      ],
      "defaultValue": "Audit"
    },
    "web_app_https_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Web App HTTPS-only effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "Audit",
        "Disabled"
      ],
      "defaultValue": "Audit"
    },
    "app_services_disable_public_effect": {
      "type": "String",
      "metadata": {
        "displayName": "App Services disable public network access effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "api_app_require_auth_effect": {
      "type": "String",
      "metadata": {
        "displayName": "API App require authentication effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    }
    ,
    "function_app_require_auth_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Function App require authentication effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "web_app_require_auth_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Web App require authentication effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "api_app_configure_cors_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Require API App to configure CORS effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "function_app_configure_cors_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Require Function App to configure CORS effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "web_app_configure_cors_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Require Web App to configure CORS effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    }
  }
  PARAMETERS

  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.api_app_https_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('api_app_https_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.function_app_https_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('function_app_https_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.web_app_https_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('web_app_https_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.app_services_disable_public_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('app_services_disable_public_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.api_app_require_auth_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('api_app_require_auth_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.function_app_require_auth_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('function_app_require_auth_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.web_app_require_auth_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('web_app_require_auth_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.api_app_configure_cors_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('api_app_configure_cors_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.function_app_configure_cors_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('function_app_configure_cors_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.web_app_configure_cors_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('web_app_configure_cors_effect')]"}
    }
    VALUE
  }
}

# Assignment of custom Initiative
resource "azurerm_subscription_policy_assignment" "app_service_policy_set_assignment" {
  name                 = "[APP SERVICE] INITIATIVE for ${var.environment_name}"
  policy_definition_id = azurerm_policy_set_definition.app_service_policy_set_definition.id
  subscription_id      = "/subscriptions/${var.subscription_id}"
  display_name         = "App Service Policy Assignment for ${var.environment_name}"

  parameters = jsonencode({
    "api_app_https_effect" : {
      "value" : var.api_app_https_effect
    },
    "function_app_https_effect" : {
      "value" : var.function_app_https_effect
    },
    "web_app_https_effect" : {
      "value" : var.web_app_https_effect
    },
    "app_services_disable_public_effect" : {
      "value" : var.app_services_disable_public_effect
    },
    "api_app_require_auth_effect" : {
      "value" : var.api_app_require_auth_effect
    },
    "function_app_require_auth_effect" : {
      "value" : var.function_app_require_auth_effect
    },
    "web_app_require_auth_effect" : {
      "value" : var.web_app_require_auth_effect
    },
    "api_app_configure_cors_effect" : {
      "value" : var.api_app_configure_cors_effect
    },
    "function_app_configure_cors_effect" : {
      "value" : var.function_app_configure_cors_effect
    },
    "web_app_configure_cors_effect" : {
      "value" : var.web_app_configure_cors_effect
    }
  })
}
