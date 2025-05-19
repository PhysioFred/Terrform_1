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

# Reference the existing Amazon Connect instance

data "aws_connect_instance" "existing" {
  instance_id = "1ccaafe5-b69b-474e-b523-c22de9d7f0a4"
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
  default = "2920a445-e488-4a20-ab3d-b2d7a2d60671"
} 

variable "routing_profile_option3" {
  type = string
  default = "96c78d3f-b552-4582-871b-7e5e92e4117b"
}

variable "routing_profile_option4" {
  type = string
  default = "c6809aa6-1456-43ea-a4b6-5113fec37014" 
}

variable "routing_profile_option5" {
  type = string
  default = "b8b5b4ac-e15f-4818-bee9-6fd28ca9f210"
}

resource "aws_connect_routing_profile" "Option2" {
  instance_id               = data.aws_connect_instance.existing.id
  name                      = "Option 2: Existing user or Self Service"
  description               = "Option 2 for call flow"
  default_outbound_queue_id = aws_connect_queue.Option2.queue_id
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
    queue_id = aws_connect_queue.Option2.queue_id
  }
  queue_configs {
    channel  = "CHAT"
    delay    = 0
    priority = 1
    queue_id = aws_connect_queue.Option2.queue_id
  }
  queue_configs {
    channel  = "TASK"
    delay    = 0
    priority = 1
    queue_id = aws_connect_queue.Option2.queue_id
  }
}

resource "aws_connect_routing_profile" "Option3" {
  instance_id               = data.aws_connect_instance.existing.id
  name                      = "Option 3: House Modifications"
  description               = "Option 3 for call flow"
  default_outbound_queue_id = aws_connect_queue.Option3.queue_id
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
    queue_id = aws_connect_queue.Option3.queue_id
  }
  queue_configs {
    channel  = "CHAT"
    delay    = 0
    priority = 1
    queue_id = aws_connect_queue.Option3.queue_id
  }
  queue_configs {
    channel  = "TASK"
    delay    = 0
    priority = 1
    queue_id = aws_connect_queue.Option3.queue_id
  }
}

resource "aws_connect_routing_profile" "Option4" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Option 4: Reassess Plan"
  description           = "Option 4 for call flow"
  default_outbound_queue_id = aws_connect_queue.Option4.queue_id
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
    queue_id = aws_connect_queue.Option4.queue_id
  }
  queue_configs {
    channel  = "CHAT"
    delay    = 0
    priority = 1
    queue_id = aws_connect_queue.Option4.queue_id
  }
  queue_configs {
    channel  = "TASK"
    delay    = 0
    priority = 1
    queue_id = aws_connect_queue.Option4.queue_id
  }
}

resource "aws_connect_routing_profile" "Option5" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Option 5: NDIS Providers"
  description           = "Option 5 for call flow"
  default_outbound_queue_id = aws_connect_queue.Option5.queue_id
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
    queue_id = aws_connect_queue.Option5.queue_id
  }
  queue_configs {
    channel  = "CHAT"
    delay    = 0
    priority = 1
    queue_id = aws_connect_queue.Option5.queue_id
  }
  queue_configs {
    channel  = "TASK"
    delay    = 0
    priority = 1
    queue_id = aws_connect_queue.Option5.queue_id
  }
}


# Create the users ------------------

locals {
  routing_profile_manager = "32a4dfa9-bdaf-4ed2-8abf-744cbdeef361"
}

resource "aws_connect_user" "agent" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Agent"
  password              = "SpaceCode3122!"
  routing_profile_id    = "d3b3152c-ad44-46f0-b194-51aaf80f5b33"
  security_profile_ids  = ["fc3b7c27-a40a-4845-8fde-e1ada8ea05ed"]

  phone_config {
    phone_type          = "SOFT_PHONE"
  }

  identity_info {
    first_name          = "Agent"
    last_name           = "User"
  }
}

resource "aws_connect_user" "agent2" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Agent2"
  password              = "SpaceCode3122!"
  routing_profile_id    = "2920a445-e488-4a20-ab3d-b2d7a2d60671"
  security_profile_ids  = ["fc3b7c27-a40a-4845-8fde-e1ada8ea05ed"]

  phone_config {
    phone_type          = "SOFT_PHONE"
  }

  identity_info {
    first_name          = "Agent2"
    last_name           = "User"
  }
}

resource "aws_connect_user" "agent3" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Agent3"
  password              = "SpaceCode3122!"
  routing_profile_id    = "96c78d3f-b552-4582-871b-7e5e92e4117b"
  security_profile_ids  = ["fc3b7c27-a40a-4845-8fde-e1ada8ea05ed"]

  phone_config {
    phone_type          = "SOFT_PHONE"
  }

  identity_info {
    first_name          = "Agent3"
    last_name           = "User"
  }
}

resource "aws_connect_user" "agent4" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Agent4"
  password              = "SpaceCode3122!"
  routing_profile_id    = "c6809aa6-1456-43ea-a4b6-5113fec37014"
  security_profile_ids  = ["fc3b7c27-a40a-4845-8fde-e1ada8ea05ed"]

  phone_config {
    phone_type          = "SOFT_PHONE"
  }

  identity_info {
    first_name          = "Agent4"
    last_name           = "User"
  }
}

resource "aws_connect_user" "agent5" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Agent5"
  password              = "SpaceCode3122!"
  routing_profile_id    = "b8b5b4ac-e15f-4818-bee9-6fd28ca9f210"
  security_profile_ids  = ["fc3b7c27-a40a-4845-8fde-e1ada8ea05ed"]

  phone_config {
    phone_type          = "SOFT_PHONE"
  }

  identity_info {
    first_name          = "Agent5"
    last_name           = "User"
  }
}

resource "aws_connect_user" "manager" {
  instance_id           = data.aws_connect_instance.existing.id
  name                  = "Manager"
  password              = "SpaceCode3122!"
  routing_profile_id    = "3bd3e53e-59fc-4689-b996-6bbdaf7a8074" # Basic routing Profile
  security_profile_ids  = [local.routing_profile_manager]

  phone_config {
    phone_type          = "SOFT_PHONE"
  }

  identity_info {
    first_name          = "Manager"
    last_name           = "User"
  }
}
  