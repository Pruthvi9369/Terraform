output "virtual_machine_id" {
  description = "Virtual Machine id"
  value = azurerm_virtual_machine.virtual_machine.id
}

output "virtual_machine_identity" {
  description = "Virtual Machine's Identity"
  value = azurerm_virtual_machine.virtual_machine.identity
}

#output "virtual_machine_principal_id" {
#  description = "Virtual Machine's principal_id"
#  value = azurerm_virtual_machine.virtual_machine.identity[0]
#}
