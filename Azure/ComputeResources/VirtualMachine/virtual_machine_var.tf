variable "virtual_machine_name" {
  description = "Please provide Virtual Machine Name (Required)"
  type = "string"
  default = ""
}

variable "virtual_machine_resource_group_name" {
  description = "Please provide Virtual Machine Resource Group Name (Required)"
  type = "string"
  default = ""
}

variable "virtual_machine_location" {
  description = "Please provide Virtual Machine Location (Required)"
  type = "string"
  default = ""
}

variable "virtual_machine_network_interface_ids" {
  description = "Please provide Virtual Machine Network Interface Id's (Required)"
  type = list
  default = []
}

variable "virtual_machine_os_profile_linux_config" {
  description = "Please provide Virtual Machine's Linux Config (Required, when a Linux machine)"
  type = list(map(string))
  default = []
}

variable "virtual_machine_os_profile_windows_config" {
  description = "Please provide Virtual Machine's Windows Config (Required, when a Windows machine)"
  type = list(map(string))
  default = []
}

variable "virtual_machine_vm_size" {
  description = "Please provide Virtual Machine's VM size (Required)"
  type = "string"
  default = ""
}

variable "virtual_machine_availability_set_id" {
  description = "Please provide Virtual Machine's Availability Set Id"
  type = "string"
  default = null
}

variable "virtual_machine_boot_diagnostics" {
  description = "Please provide Virtual Machine's Boot Diagnostics"
  type = list(map(string))
  default = []
}

variable "virtual_machine_additional_capabilities" {
  description = "Please provide Virtual Machine Additional Capabilities"
  type = list(map(string))
  default = []
}

variable "virtual_machine_delete_os_disk_on_termination" {
  description = "Please provide Virtual Machine's Delete os disk on termination"
  type = bool
  default = false
}

variable "virtual_machine_delete_data_disks_on_termination" {
  description = "Please provide Virtual Machine's Delete data disk on termination"
  type = bool
  default = false
}

variable "virtual_machine_identity" {
  description = "Please provide Virtual Machine's Identity"
  type = list(map(string))
  default = []
}

variable "virtual_machine_license_type" {
  description = "Please provide Virtual Machine's License Type"
  type = "string"
  default = null
}

variable "virtual_machine_os_profile" {
  description = "Please provide Virtual Machine's Os Profile"
  type = list(map(string))
  default = []
}

variable "virtaul_machine_os_profile_secrets" {
  description = "Please provide Virtual Machine's Os Profile Secrets"
  type = list(map(string))
  default = []
}

variable "virtual_machine_plan" {
  description = "Please provide Virtual Machine's Plan"
  type = list(map(string))
  default = []
}

variable "virtual_machine_primary_network_interface_id" {
  description = "Please provide Virtual Machine's Primary Network Interface id"
  type = "string"
  default = null
}

variable "virtual_machine_proximity_placement_group_id" {
  description = "Please provide Virtual Machine's Proximity Placement Group id"
  type = "string"
  default = null
}

variable "virtual_machine_storage_data_disk" {
  description = "Please provide Virtual Machine's Storage Data Disk"
  type = list(map(string))
  default = []
}

variable "virtual_machine_storage_image_reference" {
  description = "Please provide Virtual Machine's Storage Image Reference"
  type = list(map(string))
  default = []
}

variable "virtual_machine_storage_os_disk" {
  description = "Please provide Virtual Machine's Storage Os Disk"
  type = list(map(string))
  default = []
}

variable "virtual_machine_tags" {
  description = "Please provide Virtual Machine's Tags"
  type = map
  default = {}
}

variable "virtual_machine_zones" {
  description = "Please provide Virtual Machine's Zones"
  type = list
  default = []
}
