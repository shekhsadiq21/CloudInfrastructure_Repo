data "azurerm_policy_definition" "storage_disallow_public_policy" {
  display_name = "[Preview]: Storage account public access should be disallowed"
}
data "azurerm_policy_definition" "storage_private_link_policy" {
  display_name = "Storage accounts should use private link"
}
data "azurerm_policy_definition" "storage_vnet_rules_policy" {
  display_name = "Storage accounts should restrict network access using virtual network rules"
}

# Definition of custom Initiative
resource "azurerm_policy_set_definition" "storage_policy_set_definition" {
  name         = "[STORAGE] ${var.environment_name} INITIATIVE"
  policy_type  = "Custom"
  display_name = "[STORAGE] INITIATIVE for ${var.environment_name}"

  parameters = <<PARAMETERS
  {
    "storage_disallow_public_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Disallow storage account public access effect",
        "description": "The effect determines what happens when the policy rule is evaluated to match"
      },
      "allowedValues": [
        "audit",
        "deny",
        "disabled"
      ],
      "defaultValue": "audit"
    },
    "storage_private_link_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Storage account private link effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "storage_vnet_rules_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Storage accounts restrict network virtual network rules effect",
        "description": "Enable or disable the execution of the audit policy"
      },
      "allowedValues": [
        "Audit",
        "Deny",
        "Disabled"
      ],
      "defaultValue": "Audit"
    }
  }
  PARAMETERS

  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.storage_disallow_public_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('storage_disallow_public_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.storage_private_link_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('storage_private_link_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.storage_vnet_rules_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('storage_vnet_rules_effect')]"}
    }
    VALUE
  }
}

# Assignment of custom Initiative
resource "azurerm_subscription_policy_assignment" "storage_policy_set_assignment" {
  name                 = "[STORAGE] INITIATIVE for ${var.environment_name}"
  display_name         = "Security Center Policy Assignment for ${var.environment_name}"
  policy_definition_id = azurerm_policy_set_definition.storage_policy_set_definition.id
  subscription_id      = "/subscriptions/${var.subscription_id}"

  parameters = jsonencode({
    "storage_disallow_public_effect" : {
      "value" : var.storage_disallow_public_effect
    },
    "storage_private_link_effect" : {
      "value" : var.storage_private_link_effect
    },
    "storage_vnet_rules_effect" : {
      "value" : var.storage_vnet_rules_effect
    }
  })
}
