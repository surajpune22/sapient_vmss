variable "resource_group_name" {
  type = string
  description = "Name of the resource group"
  default = ""
}
variable "location" {
  type = string
  description = "The location/region of the resources"
  default = ""
}
variable "tags" {
  type = map(any)
  description = "The tags to associate with resources"
}
variable "vnet_name" {
  type = string
  description = "Name of VNET to create"
}
variable "subnets" {
  type = list(any)
  description = "The address prefix to use for the subnet."
  default = ["10.135.20.0/24"]
}
variable "add_endpoint" {
  type = bool
  description = "Should you be adding an endpoint, leave this as is"
  default = false
}