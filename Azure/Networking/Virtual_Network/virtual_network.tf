provider "azurerm" {
  client_id = ""  # In Azure = Application ID
  client_secret = "" # In Azure = Service Principal Key
  subscription_id = "" # In Azure = subscription ID
  tenant_id = "" # In Azure = Tenant ID
}

resource "azurerm_resource_group" "resource_group" {
  name = "${var.resource_group_name}"
  location = "${var.resource_group_location}"
}

resource "azurerm_virtual_network" "virtual_network" {
  name = "${var.virtual_network_name}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  address_space = "${var.virtual_network_address_space}"
  location = "${azurerm_resource_group.resource_group.location}"

  dynamic "ddos_protection_plan" {
    for_each = "${var.virtual_network_ddos_protection_plan}"

    content {
      id = "${lookup(ddos_protection_plan.value, "id", null)}"
      enable = "${lookup(ddos_protection_plan.value, "enable", null)}"
    }
  }

  dns_servers = "${var.virtual_network_dns_servers}"

  dynamic "subnet" {
    for_each = "${var.virtual_network_subnet}"

    content {
      name = "${lookup(subnet.value, "name", null)}"
      address_prefix = "${lookup(subnet.value, "address_prefix", null)}"
      security_group = "${lookup(subnet.value, "security_group", null)}"
    }
  }

  tags = "${merge(map(
    "Name", "${var.virtual_network_name}",
    "resource_group_name", "${azurerm_resource_group.resource_group.name}"
    ), var.virtual_network_tags)}"
}
