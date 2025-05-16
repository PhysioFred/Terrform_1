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

# Reference existing hours of operation
data "aws_connect_hours_of_operation" "basic" {
  instance_id = data.aws_connect_instance.existing.id
  name        = "Basic Hours"
}
# Create the phone queue options for flow ------------------

variable "twelve_hour_operation" {
  type = string
  default = "febbb1fd-8cee-4072-ba22-23a77f6aaad0"
}

resource "aws_connect_queue" "Option2" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Option 2: Existing user or Self Service"
  hours_of_operation_id = var.twelve_hour_operation
  description           = "Option 2 for call flow"
}

resource "aws_connect_queue" "Option3" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Option 3: House Modifications" 
  hours_of_operation_id = var.twelve_hour_operation
  description           = "Option 3 for call flow"
}

resource "aws_connect_queue" "Option4" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Option 4: Reassess Plan" 
  hours_of_operation_id = var.twelve_hour_operation 
  description           = "Option 4 for call flow"
}

resource "aws_connect_queue" "Option5" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Option 5: NDIS Providers"
  hours_of_operation_id = var.twelve_hour_operation
  description           = "Option 5 for call flow"
} 

# Create the routing profiles ------------------

variable "routing_profile_option2" {
  type = string
  default = "22740f26-f987-4b83-bb56-dd853f29d62e"
}

variable "routing_profile_option3" {
  type = string
  default = "8eddcdcd-c48f-40f6-a864-b3e049464180"
}

variable "routing_profile_option4" {
  type = string
  default = "3a5a38a7-ad9a-4c7c-bb80-64ca015b0e14"
}

variable "routing_profile_option5" {
  type = string
  default = "e874ce87-9eac-4228-8bae-f242c86a7337"
}

resource "aws_connect_routing_profile" "Option2" {
  instance_id               = data.aws_connect_instance.existing.id
  name                      = "Option 2: Existing user or Self Service"
  description               = "Option 2 for call flow"
  default_outbound_queue_id = var.routing_profile_option2
  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1
  }
  media_concurrencies {
    channel     = "CHAT"
    concurrency = 1
  }
  media_concurrencies {
    channel     = "TASK"
    concurrency = 1
  }
  queue_configs {
    channel  = "VOICE"
    delay    = 0
    priority = 1
    queue_id = var.routing_profile_option2
  }
  queue_configs {
    channel  = "CHAT"
    delay    = 0
    priority = 1
    queue_id = var.routing_profile_option2
  }
  queue_configs {
    channel  = "TASK"
    delay    = 0
    priority = 1
    queue_id = var.routing_profile_option2
  }
}

resource "aws_connect_routing_profile" "Option3" {
  instance_id               = data.aws_connect_instance.existing.id
  name                      = "Option 3: House Modifications"
  description               = "Option 3 for call flow"
  default_outbound_queue_id = var.routing_profile_option3
  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1
  }
  media_concurrencies {
    channel     = "CHAT"
    concurrency = 1
  }
  media_concurrencies {
    channel     = "TASK"
    concurrency = 1
  }
  queue_configs {
    channel  = "VOICE"
    delay    = 0
    priority = 1
    queue_id = var.routing_profile_option3
  }
  queue_configs {
    channel  = "CHAT"
    delay    = 0
    priority = 1
    queue_id = var.routing_profile_option3
  }
  queue_configs {
    channel  = "TASK"
    delay    = 0
    priority = 1
    queue_id = var.routing_profile_option3
  }
}

resource "aws_connect_routing_profile" "Option4" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Option 4: Reassess Plan"
  description           = "Option 4 for call flow"
  default_outbound_queue_id = var.routing_profile_option4
  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1
  }
  media_concurrencies {
    channel     = "CHAT"
    concurrency = 1
  }
  media_concurrencies {
    channel     = "TASK"
    concurrency = 1
  }
  queue_configs {
    channel  = "VOICE"
    delay    = 0
    priority = 1
    queue_id = var.routing_profile_option4
  }
  queue_configs {
    channel  = "CHAT"
    delay    = 0
    priority = 1
    queue_id = var.routing_profile_option4
  }
  queue_configs {
    channel  = "TASK"
    delay    = 0
    priority = 1
    queue_id = var.routing_profile_option4
  }
}

resource "aws_connect_routing_profile" "Option5" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Option 5: NDIS Providers"
  description           = "Option 5 for call flow"
  default_outbound_queue_id = var.routing_profile_option5
  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1
  }
  media_concurrencies {
    channel     = "CHAT"
    concurrency = 1
  }
  media_concurrencies {
    channel     = "TASK"
    concurrency = 1
  }
  queue_configs {
    channel  = "VOICE"
    delay    = 0
    priority = 1
    queue_id = var.routing_profile_option5
  }
  queue_configs {
    channel  = "CHAT"
    delay    = 0
    priority = 1
    queue_id = var.routing_profile_option5
  }
  queue_configs {
    channel  = "TASK"
    delay    = 0
    priority = 1
    queue_id = var.routing_profile_option5
  }
}


# Create the users ------------------
resource "aws_connect_user" "agent" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Agent"
  password              = "SpaceCode3122!"
  routing_profile_id    = "3bd3e53e-59fc-4689-b996-6bbdaf7a8074"
  security_profile_ids  = ["fc3b7c27-a40a-4845-8fde-e1ada8ea05ed"]

  phone_config {
    phone_type          = "SOFT_PHONE"
  }

  identity_info {
    first_name          = "Agent"
    last_name           = "User"
  }
}
