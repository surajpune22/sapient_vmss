application         = "tfworkspaces"
environment         = "dev"
location            = "westeurope"
capacity            = 2

default_tags = {
   environment     = "dev"
   developed_by    = "Codification"
}

address_space = "10.135.0.0/16"
subnet        = "10.135.20.0/24"