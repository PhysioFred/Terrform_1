terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.11.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

###########################
# 1) Amazon Connect Instance
###########################
# Reference the existing Amazon Connect instance

data "aws_connect_instance" "existing" {
  instance_id = "1ccaafe5-b69b-474e-b523-c22de9d7f0a4"
}


# Claim a DID phone number in Australia for this Connect instance
resource "aws_connect_phone_number" "main" {
  target_arn    = data.aws_connect_instance.existing.arn
  type          = "DID"           # DID = Direct Inward Dialing (local number)
  country_code  = "AU"            # AU = Australia
  # target_phone_number = "+61872010033" # Uncomment and set if you want a specific number
}

# Reference existing hours of operation
data "aws_connect_hours_of_operation" "basic" {
  instance_id = data.aws_connect_instance.existing.id
  name        = "Basic Hours"
}

# Create the sales queue
resource "aws_connect_queue" "sales" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "sales queue"
  hours_of_operation_id = "d70aeaa0-2fcb-4bc2-bbc9-a7a6b1cabe0f" # Just the ID part, not the full ARN
  description           = "Sales call queue"
}

resource "aws_connect_queue" "support" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "support queue"
  hours_of_operation_id = data.aws_connect_hours_of_operation.basic.id
  description           = "Support call queue"
}