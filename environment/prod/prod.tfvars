application         = "tfworkspaces"
environment         = "prod"
location            = "westeurope"
capacity            = 5

default_tags = {
   environment = "prod"
   developed_by = "Codification"
}

address_space = "10.134.0.0/16"
subnet = "10.134.20.0/24"