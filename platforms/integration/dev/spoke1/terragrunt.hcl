include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_repo_root()}/modules//virtual-network"
}

dependency "rg" {
  config_path = "../resource-group"
}

inputs = {
  vnet_name           = "vnet-spoke1"
  location            = "eastasia"
  resource_group_name = dependency.rg.outputs.name
  address_space       = ["10.1.0.0/16"]
}