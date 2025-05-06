terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"   # Tells Terraform to use the official AWS provider
      version = ">= 5.0"          # Ensures compatibility with recent AWS features
    }
  }
  required_version = ">= 1.0.0"   # Ensures you're using Terraform 1.0.0 or newer
}

provider "aws" {
  region = var.aws_region         # Uses a variable to set the AWS region (e.g., ap-southeast-2)
}

resource "aws_connect_instance" "basic" {
  identity_management_type = "SAML"    # How users are managed (SAML, CONNECT_MANAGED, or EXISTING_DIRECTORY)
  inbound_calls_enabled    = true      # Enable inbound calls
  outbound_calls_enabled   = false     # Disable outbound calls (can change to true if needed)
}
