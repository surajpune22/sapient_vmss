variable "rgname" {
  type = string
}

#variable "location" {
#  type = string
#  default = "westeurope"
#}

variable "tags" {
   description = "Map of the tags to use for the resources that are deployed"
   type        = map(string)
   default = {
      environment = "integration"
   }
}

variable "admin_password" {
   type = string 
   description = "Default password for admin account"
}

variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}



variable "subscription_id" {
 type        = string
 description = "Azure subscription"
 # default = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}

variable "client_id" {
 type        = string
 description = "Azure Client ID"
 # default = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}

variable "client_secret" {
 type        = string
 description = "Azure Client Secret"
 # default = "XXXXXXXXXXXXXXXXXX"
}

variable "tenant_id" {
 type        = string
 description = "Azure Tenant ID"
 # default = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}

variable "resource_group_name" {
 type        = string
 description = ""
 default     = ""
}

variable "location" {
 type        = string
 description = ""
 default     = ""
}

variable "default_tags" {
 description = ""
 type        = map(any)
 default     = {}
}

variable "address_space" {
 type        = string
 description = ""
 default     = ""
}

variable "subnet" {
 type        = string
 description = ""
 default     = ""
}

variable "subnets" {
 type        = list(any)
 description = ""
 default     = []
}

variable "application" {
 type        = string
 description = ""
 default     = ""
}

variable "environment" {
 type        = string
 description = ""
 default     = ""
}

variable "capacity" {
 type        = string
 description = ""
 default     = ""
}