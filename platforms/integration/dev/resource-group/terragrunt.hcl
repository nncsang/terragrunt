include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_repo_root()}/modules//resource-group"
}

inputs = {
  name     = "lz"
  location = "eastasia"
  tags = {
    environment = "dev"
  }
}