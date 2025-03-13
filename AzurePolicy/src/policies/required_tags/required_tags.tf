# Definition of custom Policy
resource "azurerm_policy_definition" "required_tags_policy" {
  name         = "[TAGS] Require a tag on resource groups"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "[TAGS] Requires a tag on resource groups for ${var.environment_name}"

  policy_rule = jsonencode({
    "if" : {
      "allOf" : [
        {
          "field" : "type",
          "equals" : "Microsoft.Resources/subscriptions/resourceGroups"
        },
        {
          "field" : "[concat('tags[', parameters('tagName'), ']')]",
          "exists" : "false"
        }
      ]
    },
    "then" : {
      "effect" : "[parameters('effect')]"
    }
  })
  parameters = <<PARAMETERS
    {
      "tagName": {
          "type": "String",
          "metadata": {
            "displayName": "Tag Name",
            "description": "Name of the tag, such as 'environment'"
          }
      },
      "effect": {
          "type": "String",
          "metadata": {
            "displayName": "Effect",
            "description": "Audit or Deny the execution of the policy"
          },
          "allowedValues": ["Audit","Deny"],
          "defaultValue": "Audit"
      }
    }
    PARAMETERS
}

# Definition of custom Initiative
resource "azurerm_policy_set_definition" "required_tags_policy_set_definition" {
  name         = "[TAGS] Required tags on resource groups"
  policy_type  = "Custom"
  display_name = "[TAGS] Required tags on resource groups for ${var.environment_name}"

  parameters = <<PARAMETERS
  {
    "tag1Name": {
      "type": "String",
      "metadata": {
        "displayName": "Tag 1 Name",
        "description": "Name of the tag, such as 'environment'"
      }
    },
    "tag1effect": {
      "type": "String",
      "metadata": {
        "displayName": "Effect",
        "description": "Audit or Deny the execution of the policy for Tag 1"
      },
      "allowedValues": ["Audit","Deny"],
      "defaultValue": "Audit"
    },
    "tag2Name": {
      "type": "String",
      "metadata": {
        "displayName": "Tag 2 Name",
        "description": "Name of the tag, such as 'environment'"
      }
    },
    "tag2effect": {
      "type": "String",
      "metadata": {
        "displayName": "Effect",
        "description": "Audit or Deny the execution of the policy for Tag 2"
      },
      "allowedValues": ["Audit","Deny"],
      "defaultValue": "Audit"
    },
    "tag3Name": {
        "type": "String",
        "metadata": {
            "displayName": "Tag 3 Name",
            "description": "Name of the tag, such as 'environment'"
            }
    },
    "tag3effect": {
        "type": "String",
        "metadata": {
        "displayName": "Effect",
        "description": "Audit or Deny the execution of the policy for Tag 3"
        },
        "allowedValues": [
        "Audit",
        "Deny"
        ],
        "defaultValue": "Audit"
    },
    "tag4Name": {
        "type": "String",
        "metadata": {
            "displayName": "Tag 4 Name",
            "description": "Name of the tag, such as 'environment'"
            }
    },
    "tag4effect": {
        "type": "String",
        "metadata": {
        "displayName": "Effect",
        "description": "Audit or Deny the execution of the policy for Tag 4"
        },
        "allowedValues": [
        "Audit",
        "Deny"
        ],
        "defaultValue": "Audit"
    },
    "tag5Name": {
        "type": "String",
        "metadata": {
            "displayName": "Tag 5 Name",
            "description": "Name of the tag, such as 'environment'"
            }
    },
    "tag5effect": {
        "type": "String",
        "metadata": {
        "displayName": "Effect",
        "description": "Audit or Deny the execution of the policy for Tag 5"
        },
        "allowedValues": [
        "Audit",
        "Deny"
        ],
        "defaultValue": "Audit"
    },
    "tag6Name": {
        "type": "String",
        "metadata": {
            "displayName": "Tag 6 Name",
            "description": "Name of the tag, such as 'environment'"
            }
    },
    "tag6effect": {
        "type": "String",
        "metadata": {
        "displayName": "Effect",
        "description": "Audit or Deny the execution of the policy for Tag 6"
        },
        "allowedValues": [
        "Audit",
        "Deny"
        ],
        "defaultValue": "Audit"
    },
    "tag7Name": {
        "type": "String",
        "metadata": {
            "displayName": "Tag 7 Name",
            "description": "Name of the tag, such as 'environment'"
            }
    },
    "tag7effect": {
        "type": "String",
        "metadata": {
        "displayName": "Effect",
        "description": "Audit or Deny the execution of the policy for Tag 7"
        },
        "allowedValues": [
        "Audit",
        "Deny"
        ],
        "defaultValue": "Audit"
    },
    "tag8Name": {
        "type": "String",
        "metadata": {
            "displayName": "Tag 8 Name",
            "description": "Name of the tag, such as 'environment'"
            }
    },
    "tag8effect": {
        "type": "String",
        "metadata": {
        "displayName": "Effect",
        "description": "Audit or Deny the execution of the policy for Tag 8"
        },
        "allowedValues": [
        "Audit",
        "Deny"
        ],
        "defaultValue": "Audit"
    },
    "tag9Name": {
        "type": "String",
        "metadata": {
            "displayName": "Tag 9 Name",
            "description": "Name of the tag, such as 'environment'"
            }
    },
    "tag9effect": {
        "type": "String",
        "metadata": {
        "displayName": "Effect",
        "description": "Audit or Deny the execution of the policy for Tag 9"
        },
        "allowedValues": [
        "Audit",
        "Deny"
        ],
        "defaultValue": "Audit"
    }
  }
  PARAMETERS

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.required_tags_policy.id
    parameter_values     = <<VALUE
    {
      "tagName": {"value": "[parameters('tag1Name')]"},
      "effect": {"value": "[parameters('tag1effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.required_tags_policy.id
    parameter_values     = <<VALUE
    {
      "tagName": {"value": "[parameters('tag2Name')]"},
      "effect": {"value": "[parameters('tag2effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.required_tags_policy.id
    parameter_values     = <<VALUE
    {
      "tagName": {"value": "[parameters('tag3Name')]"},
      "effect": {"value": "[parameters('tag3effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.required_tags_policy.id
    parameter_values     = <<VALUE
    {
      "tagName": {"value": "[parameters('tag4Name')]"},
      "effect": {"value": "[parameters('tag4effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.required_tags_policy.id
    parameter_values     = <<VALUE
    {
      "tagName": {"value": "[parameters('tag5Name')]"},
      "effect": {"value": "[parameters('tag5effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.required_tags_policy.id
    parameter_values     = <<VALUE
    {
      "tagName": {"value": "[parameters('tag6Name')]"},
      "effect": {"value": "[parameters('tag6effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.required_tags_policy.id
    parameter_values     = <<VALUE
    {
      "tagName": {"value": "[parameters('tag7Name')]"},
      "effect": {"value": "[parameters('tag7effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.required_tags_policy.id
    parameter_values     = <<VALUE
    {
      "tagName": {"value": "[parameters('tag8Name')]"},
      "effect": {"value": "[parameters('tag8effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.required_tags_policy.id
    parameter_values     = <<VALUE
    {
      "tagName": {"value": "[parameters('tag9Name')]"},
      "effect": {"value": "[parameters('tag9effect')]"}
    }
    VALUE
  }
}

# Assignment of custom Initiative
resource "azurerm_subscription_policy_assignment" "required_tags_policy_set_assignment" {
  name                 = "[Tags] INITIATIVE for ${var.environment_name}"
  display_name         = "Required Tags Policy Assignment for ${var.environment_name}"
  policy_definition_id = azurerm_policy_set_definition.required_tags_policy_set_definition.id
  subscription_id      = "/subscriptions/${var.subscription_id}"

  parameters = jsonencode({
    "tag1Name" : {
      "value" : "Owner"
    },
    "tag1Effect" : {
      "value" : var.ownerTagEffect
    },
    "tag2Name" : {
      "value" : "Created-by"
    },
    "tag2Effect" : {
      "value" : var.createdByTagEffect
    },
    "tag3Name" : {
      "value" : "Approver"
    },
    "tag3Effect" : {
      "value" : var.approverTagEffect
    },
    "tag4Name" : {
      "value" : "Requester"
    },
    "tag4Effect" : {
      "value" : var.requesterTagEffect
    },
    "tag5Name" : {
      "value" : "CostCenter"
    },
    "tag5Effect" : {
      "value" : var.costCenterTagEffect
    },
    "tag6Name" : {
      "value" : "Environment"
    },
    "tag6Effect" : {
      "value" : var.environmentTagEffect
    },
    "tag7Name" : {
      "value" : "Purpose"
    },
    "tag7Effect" : {
      "value" : var.purposeTagEffect
    },
    "tag8Name" : {
      "value" : "EstimatedTimeFrame"
    },
    "tag8Effect" : {
      "value" : var.estimatedTimeFrameTagEffect
    },
    "tag9Name" : {
      "value" : "Created-date"
    },
    "tag9Effect" : {
      "value" : var.createdDateTagEffect
    }
  })
}
