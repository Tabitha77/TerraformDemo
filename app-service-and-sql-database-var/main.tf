provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "RG-Terraform" {
  name     = "rg_eastus_89125_1_1672239737332"
  location = "East US 2"
}

resource "azurerm_service_plan" "ASP-TerraForm" {
  name                = "terraform-appserviceplan"
  location            = azurerm_resource_group.RG-Terraform.location
  resource_group_name = azurerm_resource_group.RG-Terraform.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

 
resource "azurerm_linux_web_app" "AS-Terraform" {
  name                = "app-service-terraform"
  resource_group_name = azurerm_resource_group.RG-Terraform.name
  location            = azurerm_resource_group.RG-Terraform.locatio
  service_plan_id     = azurerm_app_service_plan.ASP-TerraForm.id

  site_config {}
}

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_sql_server.test.fully_qualified_domain_name} Database=${azurerm_sql_database.test.name};User ID=${azurerm_sql_server.test.administrator_login};Password=${azurerm_sql_server.test.administrator_login_password};Trusted_Connection=False;Encrypt=True;"
  }
}

resource "azurerm_sql_server" "test" {
  name                         = "terraform-sqlserver"
  resource_group_name          = azurerm_resource_group.RG-Terraform.name
  location                     = azurerm_resource_group.RG-Terraform.location
  version                      = "12.0"
  administrator_login          = "azureadmin"
  administrator_login_password = "Accenture@123"
}

resource "azurerm_sql_database" "test" {
  name                = "terraform-sqldatabase"
  resource_group_name = azurerm_resource_group.RG-Terraform.name
  location            = azurerm_resource_group.RG-Terraform.location
  server_name         = azurerm_sql_server.test.name

  tags = {
    environment = "production"
  }
}
