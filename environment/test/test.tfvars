application         = "tfworkspaces"
environment         = "test"
location            = "westeurope"
capacity            = 3

default_tags = {
   environment = "test"
   developed_by = "Codification"
}

address_space = "10.136.0.0/16"
subnet = "10.136.20.0/24"