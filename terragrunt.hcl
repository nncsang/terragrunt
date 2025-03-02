remote_state {
  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "spldterraformstate"
    container_name      = "tfstate"
    key                = "${path_relative_to_include()}/terraform.tfstate"
    
    # Optional but recommended settings
    use_azuread_auth    = true      # Use Azure AD authentication
    subscription_id     = get_env("ARM_SUBSCRIPTION_ID")
    tenant_id          = get_env("ARM_TENANT_ID")
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
    virtual_machine {
      delete_os_disk_on_deletion = true # Optional, but helps prevent orphaned disks
    }
    cognitive_account {
      purge_soft_delete_on_destroy = true
    }
  }

  # The Azure provider will automatically use these environment variables:
  # ARM_CLIENT_ID
  # ARM_CLIENT_SECRET
  # ARM_SUBSCRIPTION_ID
  # ARM_TENANT_ID
}
EOF
}

# Retry configuration for transient Azure API errors
retryable_errors = [
  ".*Failed to load state.*",
  ".*Failed to download module.*",
  ".*Failed to query available provider packages.*",
  ".*Error: retrieving account keys for storage account.*",
  ".*Error: getting Storage Account Properties.*",
  ".*could not obtain lease.*",
  ".*socket: connection reset by peer.*",
  ".*HTTP status 429.*",  # Too Many Requests
  ".*network connection reset by peer.*",
  ".*connection refused.*",
  ".*TLS handshake timeout.*",
  ".*ServiceUnavailable.*",
  ".*InternalServerError.*",
  ".*was not found in Active Directory.*"
]

retry_max_attempts       = 3
retry_sleep_interval_sec = 5