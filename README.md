# Introduction 
Provides the code for creating re-usable WencoCloud environments

# Components:

| Component Name | Purpose |
|----------|-------------|
| .azdo | Terraform definitions for Policies |
| AzurePolicy | Pipeline definitions and templates |
| Environments | Terraform definitions for provisioning Environments |
| Governance/ACR | Terraform definitions for provisioning ACR |
| Governance/DNS | Terraform definitions for provisioning DNS |
| src/CustomerData | Terraform definitions for provisioning Azure Time Series Insights |
| src/FrontEnd | Terraform definitions for provisioning Azure frontend webapp |
| src/FunctionApps | Terraform definitions for provisioning Backend Azure Functionapps |
| src/IotComponents    | Terraform definitions for provisioning Iothub, Device Provisioning Service, Event Hubs Namespaces |
| src/Monitoring | Terraform definitions for provisioning Application Insights, Log Analytics workspace |
| src/PublicIngress | Terraform definitions for provisioning Apim, frontend app, Cname updates |
| src/Networking | Terraform definitions for provisioning Network security group, Virtual network, Subnets  |
| src/SharedResources | Terraform definitions for provisioning KeyVault, Service Bus Namespace, Cosmos DB account, App Service plans, Azure Maps Account |
| src/SQL | Terraform definitions for provisioning Azure SQL Databases |
| src/Webapps | Terraform definitions for provisioning Backend Azure Webapps |

# Infrastructure phase1

![Event Diagram](img/image.png)

Please/Add update components when a new environment is created.

| EnvironmentPrefix | EnvironmentOwner | EnvironmentNetClass | EnvironmentNet | EnvironmentLocation |
|----------|-------------|----------|-------------|-------------|
| dev | Dev teams | 10 | 1 | West us2 |
| qa | qa teams | 10 | 2 | Central US |
| uat | Alan | 10 | 3 | Central US |
| prod |  |  |  |  |


Note: When creating infrastrucutre for the first time it might take 60-120 minutes.
      Creation of APIM only takes about 45-60 mins. 


Manual creation of resources
- Creation of Send grid account: https://docs.sendgrid.com/for-developers/partners/microsoft-azure-2021#create-a-twilio-sendgrid-account
- Once the TSI account is created by terraform we need to manaully create Event-source eventually it will be automated.
- User Defined Functions for Event Constainer (Cosmodb)

KeyVault secrets to add manually 
- ApiKeys-administrationService-Key1
- ApiKeys-administrationService-Key2
- ApiKeys-assetService-Key1
- ApiKeys-assetService-Key2
- ApiKeys-eventmanagementService-Key1
- ApiKeys-eventmanagementService-Key2
- CertificateServiceAppId
- CertificateServiceAppSecret
- EmailConfiguration-FromEmailAddress
- EmailConfiguration-SendGridAPIKey
- iothub-deviceConnectionString
- TSIApplicationConfiguration-ApplicationClientId
- TSIApplicationConfiguration-ApplicationClientSecret

Secrets related to App registrations (client-id & secret-value) are stored in the "wcp-sh-wus2-appreg-kv" Keyvault.