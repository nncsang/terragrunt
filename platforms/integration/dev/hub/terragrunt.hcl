include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_repo_root()}/modules//virtual-network"
}

dependency "rg" {
  config_path = "../resource-group"

  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  
  mock_outputs = {
    name     = "gha-oidc-terragrunt"
    location = "eastasia"
  }
}

inputs = {
  vnet_name           = "vnet-hub"
  location            = "eastasia"
  resource_group_name = dependency.rg.outputs.name
  address_space       = ["10.0.0.0/16"]
}