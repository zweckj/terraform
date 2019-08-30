provider "azurerm" {
    version = "1.28.0"
}

resource "azurerm_resource_group" "rg" {
  name     = "terraform_test"
  location = "West Europe"
}

resource "azurerm_container_registry" "acr" {
  name                     = "jzacrterraform"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  location                 = "${azurerm_resource_group.rg.location}"
  sku                      = "Basic"
  admin_enabled            = false
}

resource "azurerm_kubernetes_cluster" "test" {
  name                = "jzaksterra"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  dns_prefix          = "jzaks"

  agent_pool_profile {
    name            = "default"
    count           = 1
    vm_size         = "Standard_B2ms"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "9093216a-9d5c-4221-9cd2-d5f426788fda"
    client_secret = "zI+ihiH6/D06g5CRajuSz]_n4tu9W8wC"
  }

}