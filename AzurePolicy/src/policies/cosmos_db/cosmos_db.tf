# Importing built-in Policies
data "azurerm_policy_definition" "cosmos_firewall_policy" {
  display_name = "Azure Cosmos DB accounts should have firewall rules"
}
data "azurerm_policy_definition" "cosmos_allowed_locations_policy" {
  display_name = "Azure Cosmos DB allowed locations"
}
data "azurerm_policy_definition" "cosmos_disable_public_policy" {
  display_name = "Azure Cosmos DB should disable public network access"
}
data "azurerm_policy_definition" "cosmos_limit_throughput_policy" {
  display_name = "Azure Cosmos DB throughput should be limited"
}
data "azurerm_policy_definition" "cosmos_private_link_policy" {
  display_name = "CosmosDB accounts should use private link"
}
/*
data "azurerm_policy_definition" "cosmos_account_disable_public_policy" {
  name = "Configure CosmosDB accounts to disable public network access"
}
*/
# Definition of custom Policy
resource "azurerm_policy_definition" "cosmos_account_disable_public_policy" {
  name         = "CosmosDB accounts disable public network access"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "[COSMOS DB] Configure CosmosDB accounts to disable public network access for ${var.environment_name}"

  policy_rule = jsonencode({
    "if" : {
      "allOf" : [
        {
          "field" : "type",
          "equals" : "Microsoft.DocumentDB/databaseAccounts"
        },
        {
          "field" : "Microsoft.DocumentDB/databaseAccounts/publicNetworkAccess",
          "notEquals" : "Disabled"
        }
      ]
    },
    "then" : {
      "effect" : "[parameters('effect')]",
      "details" : {
        "roleDefinitionIds" : [
          "/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c",
          "/providers/Microsoft.Authorization/roleDefinitions/5bd9cd88-fe45-4216-938b-f97437e15450"
        ],
        "conflictEffect" : "audit",
        "operations" : [
          {
            "condition" : "[greaterOrEquals(requestContext().apiVersion, '2021-01-15')]",
            "operation" : "addOrReplace",
            "field" : "Microsoft.DocumentDB/databaseAccounts/publicNetworkAccess",
            "value" : "Disabled"
          }
        ]
      }
    }
  })
  parameters = <<PARAMETERS
    {
    "effect": {
      "type": "String",
      "metadata": {
        "displayName": "Effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "Modify",
        "Disabled"
      ],
      "defaultValue": "Modify"
    }
  }
    PARAMETERS
}
# Definition of custom Initiative
resource "azurerm_policy_set_definition" "cosmos_policy_set_definition" {
  name         = "[COSMOS DB] INITIATIVE"
  policy_type  = "Custom"
  display_name = "[COSMOS DB] INITIATIVE for ${var.environment_name}"

  parameters = <<PARAMETERS
  {
    "cosmos_firewall_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Cosmos Firewall Policy Effect",
        "description": "The desired effect of the policy."
      },
      "allowedValues": [
        "Audit",
        "Deny",
        "Disabled"
      ],
      "defaultValue": "Audit"
    },
    "cosmos_allowed_locations_list": {
      "type": "Array",
      "metadata": {
        "displayName": "Cosmos allowed locations list",
        "description": "The list of locations that can be specified when deploying Azure Cosmos DB resources.",
        "strongType": "location"
      }
    },
    "cosmos_allowed_locations_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Cosmos allowed locations policy effect",
        "description": "The desired effect of the policy."
      },
      "allowedValues": [
        "deny",
        "audit",
        "disabled"
      ],
      "defaultValue": "audit"
    },
    "cosmos_disable_public_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Cosmos disable public network access effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "Audit",
        "Deny",
        "Disabled"
      ],
      "defaultValue": "Audit"
    },
    "cosmos_limit_throughput_value": {
      "type": "Integer",
      "metadata": {
        "displayName": "Cosmos max throughput (RUs)",
        "description": "The maximum throughput (RU/s) that can be assigned to a container via the Resource Provider during create or update."
      }
    },
    "cosmos_limit_throughput_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Cosmos max throughput effect",
        "description": "The desired effect of the policy."
      },
      "allowedValues": [
        "audit",
        "deny",
        "disabled"
      ],
      "defaultValue": "audit"
    },
    "cosmos_private_link_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Cosmos private link effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "Audit",
        "Disabled"
      ],
      "defaultValue": "Audit"
    },
    "cosmos_account_disable_public_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Cosmos account disable public network access effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "Modify",
        "Disabled"
      ],
      "defaultValue": "Disabled"
    }
  }
  PARAMETERS

  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.cosmos_firewall_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('cosmos_firewall_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.cosmos_allowed_locations_policy.id
    parameter_values     = <<VALUE
    {
      "listOfAllowedLocations": {"value": "[parameters('cosmos_allowed_locations_list')]"},
      "policyEffect": {"value": "[parameters('cosmos_allowed_locations_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.cosmos_disable_public_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('cosmos_disable_public_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.cosmos_limit_throughput_policy.id
    parameter_values     = <<VALUE
    {
      "throughputMax": {"value": "[parameters('cosmos_limit_throughput_value')]"},
      "effect": {"value": "[parameters('cosmos_limit_throughput_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.cosmos_private_link_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('cosmos_private_link_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.cosmos_account_disable_public_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('cosmos_account_disable_public_effect')]"}
    }
    VALUE
  }
}

# Assignment of custom Initiative
resource "azurerm_subscription_policy_assignment" "cosmos_policy_set_assignment" {
  name                 = "[COSMOS DB] INITIATIVE for ${var.environment_name}"
  display_name         = "Cosmos Policy Assignment for ${var.environment_name}"
  policy_definition_id = azurerm_policy_set_definition.cosmos_policy_set_definition.id
  subscription_id      = "/subscriptions/${var.subscription_id}"
  location             = var.location

  parameters = jsonencode({
    "cosmos_firewall_effect" : {
      "value" : var.cosmos_firewall_effect
    },
    "cosmos_allowed_locations_list" : {
      "value" : var.cosmos_allowed_locations_list
    },
    "cosmos_allowed_locations_effect" : {
      "value" : var.cosmos_allowed_locations_effect
    },
    "cosmos_disable_public_effect" : {
      "value" : var.cosmos_disable_public_effect
    },
    "cosmos_limit_throughput_value" : {
      "value" : var.cosmos_limit_throughput_value
    },
    "cosmos_limit_throughput_effect" : {
      "value" : var.cosmos_limit_throughput_effect
    },
    "cosmos_private_link_effect" : {
      "value" : var.cosmos_private_link_effect
    },
    "cosmos_account_disable_public_effect" : {
      "value" : var.cosmos_account_disable_public_effect
    }
  })

  identity {
    type = "SystemAssigned"
  }
}
