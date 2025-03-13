# Importing built-in Policies
data "azurerm_policy_definition" "external_accounts_write_policy" {
  display_name = "External accounts with write permissions should be removed from your subscription"
}
data "azurerm_policy_definition" "external_accounts_read_policy" {
  display_name = "External accounts with read permissions should be removed from your subscription"
}
data "azurerm_policy_definition" "subscription_owners_policy" {
  display_name = "There should be more than one owner assigned to your subscription"
}
data "azurerm_policy_definition" "subscription_email_policy" {
  display_name = "Subscriptions should have a contact email address for security issues"
}
data "azurerm_policy_definition" "subscription_law_agent_policy" {
  display_name = "Auto provisioning of the Log Analytics agent should be enabled on your subscription"
}
data "azurerm_policy_definition" "vm_vuln_assessment_policy" {
  display_name = "A vulnerability assessment solution should be enabled on your virtual machines"
}
data "azurerm_policy_definition" "vm_law_agent_policy" {
  display_name = "Log Analytics agent should be installed on your virtual machine for Azure Security Center monitoring"
}
data "azurerm_policy_definition" "vm_encryption_policy" {
  display_name = "Virtual machines should encrypt temp disks, caches, and data flows between Compute and Storage resources"
}
data "azurerm_policy_definition" "guest_configuration_policy" {
  display_name = "Guest Configuration extension should be installed on your machines"
}
data "azurerm_policy_definition" "endpoint_protection_policy" {
  display_name = "Endpoint protection should be installed on your machines"
}

# Definition of custom Initiative
resource "azurerm_policy_set_definition" "security_center_policy_set_definition" {
  name         = "[SECURITY CENTER] ${var.environment_name} INITIATIVE"
  policy_type  = "Custom"
  display_name = "[SECURITY CENTER] INITIATIVE for ${var.environment_name}"

  parameters = <<PARAMETERS
  {
    "external_accounts_write_effect": {
      "type": "String",
      "metadata": {
        "displayName": "External accounts write permissions effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "external_accounts_read_effect": {
      "type": "String",
      "metadata": {
        "displayName": "External accounts read permissions effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "subscription_owners_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Multiple subscription owners effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "subscription_email_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Subscription owner e-mail effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "subscription_law_agent_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Auto provisioning of the Log Analytics agent effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "vm_vuln_assessment_effect": {
      "type": "String",
      "metadata": {
        "displayName": "VM Vulnerability assessment solution effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "vm_law_agent_effect": {
      "type": "String",
      "metadata": {
        "displayName": "VM Log Analytics agent should be installed effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "vm_encryption_effect": {
      "type": "String",
      "metadata": {
        "displayName": "VM encrypt temp disks, caches, and data flows effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "guest_configuration_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Guest Configuration extension effect",
        "description": "Enable or disable the execution of the policy"
      },
      "allowedValues": [
        "AuditIfNotExists",
        "Disabled"
      ],
      "defaultValue": "AuditIfNotExists"
    },
    "endpoint_protection_effect": {
      "type": "String",
      "metadata": {
        "displayName": "Endpoint protection effect",
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
    policy_definition_id = data.azurerm_policy_definition.external_accounts_write_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('external_accounts_write_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.external_accounts_read_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('external_accounts_read_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.subscription_owners_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('subscription_owners_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.subscription_email_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('subscription_email_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.subscription_law_agent_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('subscription_law_agent_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.vm_vuln_assessment_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('vm_vuln_assessment_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.vm_law_agent_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('vm_law_agent_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.vm_encryption_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('vm_encryption_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.guest_configuration_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('guest_configuration_effect')]"}
    }
    VALUE
  }
  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.endpoint_protection_policy.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "[parameters('endpoint_protection_effect')]"}
    }
    VALUE
  }
}

# Assignment of custom Initiative
resource "azurerm_subscription_policy_assignment" "security_center_policy_set_assignment" {
  name                 = "[SECURITY CENTER] INITIATIVE for ${var.environment_name}"
  policy_definition_id = azurerm_policy_set_definition.security_center_policy_set_definition.id
  display_name         = "Security Center Policy Assignment for ${var.environment_name}"
  subscription_id      = "/subscriptions/${var.subscription_id}"

  parameters = jsonencode({
    "external_accounts_write_effect" : {
      "value" : var.external_accounts_write_effect
    },
    "external_accounts_read_effect" : {
      "value" : var.external_accounts_read_effect
    },
    "subscription_owners_effect" : {
      "value" : var.subscription_owners_effect
    },
    "subscription_email_effect" : {
      "value" : var.subscription_email_effect
    },
    "subscription_law_agent_effect" : {
      "value" : var.subscription_law_agent_effect
    },
    "vm_vuln_assessment_effect" : {
      "value" : var.vm_vuln_assessment_effect
    },
    "vm_law_agent_effect" : {
      "value" : var.vm_law_agent_effect
    },
    "vm_encryption_effect" : {
      "value" : var.vm_encryption_effect
    },
    "guest_configuration_effect" : {
      "value" : var.guest_configuration_effect
    },
    "endpoint_protection_effect" : {
      "value" : var.endpoint_protection_effect
    }
  })
}
