terraform {
  required_providers {
    cryptvault = {
      source  = "cryptvault-cloud/cryptvault"
      version = ">= 0.1.4"
    }
  }
}

provider "cryptvault" {}
