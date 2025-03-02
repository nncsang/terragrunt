include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_repo_root()}/modules//resource-group"
}

inputs = {
  name     = "gha-oidc-terragrunt"
  location = "eastasia"
  tags = {
    environment = "dev"
  }
}