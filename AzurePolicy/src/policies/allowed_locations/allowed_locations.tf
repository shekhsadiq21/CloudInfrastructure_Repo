resource "azurerm_policy_definition" "allowed_locations_policy" {
  name         = "Allow custom locations to create resources"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "[GOV] Allow custom locations to create resources for ${var.environment_name}"

  policy_rule = jsonencode({
    "if" : {
      "not" : {
        "field" : "location",
        "in" : "[parameters('allowedLocations')]"
      }
    },
    "then" : {
      "effect" : var.policy_effect
    }
  })

  parameters = <<PARAMETERS
    {
    "allowedLocations": {
      "type": "Array",
      "metadata": {
        "description": "The list of allowed locations for resources.",
        "displayName": "Allowed locations",
        "strongType": "location"
      }
    }
  }
PARAMETERS

}


resource "azurerm_policy_assignment" "policy_assignment" {
  name                 = "Allow custom locations to create resources"
  scope                = "/subscriptions/${var.subscription_id}"
  policy_definition_id = azurerm_policy_definition.allowed_locations_policy.id
  description          = "Policy Assignment created via an Acceptance Test"
  display_name         = "Allow custom locations for ${var.environment_name}"

  metadata = <<METADATA
    {
    "category": "General"
    }
METADATA

  parameters = jsonencode({
    "allowedLocations" : {
      "value" : var.allowed_locations_list,
    }
  })
}