variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}

#variable "location" {
#  description = "The Azure Region in which all resources in this example should be created."
#
#}


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
variable "subnet_id" {
  type = string
  description = "The subnet ID"
  default = ""
}
variable "saname" {
  type = string
  description = ""
  default = ""
}
variable "capacity" {
  type = string
  description = ""
  default = ""
}