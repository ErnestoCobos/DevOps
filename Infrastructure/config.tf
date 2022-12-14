terraform {
  cloud {
    organization = "cobosio"

    workspaces {
      name = "core-services"
    }
  }

  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.12.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "vultr" {
  api_key    = var.vultr_api_key
  rate_limit = 100
}