#Terraform
terraform {
    required_version = ">= 1.0"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 5.0"
        }
    }
}

#Provider AWS and region
provider "aws" {
    region = "us-east-1"
}

#Resource AWS instance
resource "aws_connect_instance" "amazon_connect" {
    instance_alias = "fred-amazon-connect"
    identity_management_type = "SAML"
    inbound_calls_enabled = true
    outbound_calls_enabled = false 
    auto_resolve_best_voices_enabled = true

    tags = {
        Environment = "test"
    }
}

#Data security profile agent
data "aws_connect_security_profile" "agent" {
    instance_id = aws_connect_instance.amazon_connect.id
    name = "Agent"
}

#Data security profile manager
data "aws_connect_security_profile" "manager" {
    instance_id = aws_connect_instance.amazon_connect.id
    name = "CallCenterManager"
}

#Data security profile admin
data "aws_connect_security_profile" "admin" {
    instance_id = aws_connect_instance.amazon_connect.id
    name = "Admin"
}

#Data routing profile "default" 
data "aws_connect_routing_profile" "default" {
    instance_id = aws_connect_instance.amazon_connect.id
    name = "Basic Routing Profile"
}

#Resource User agent
resource "aws_connect_user" "agent" {
    instance_id = aws_connect_instance.amazon_connect.id
    name = "agentuser"
    password = "SpaceCode3122!"
    routing_profile_id = data.aws_connect_routing_profile.default.id
    security_profile_ids = [data.aws_connect_security_profile.agent.id]
    identity_info {
        first_name = "Agent"
        last_name = "User"
    }
    phone_config {
        phone_type = "SOFT_PHONE"
        auto_accept = false
        after_contact_work_time_limit = 60
    }
}

#Resource User manager
resource "aws_connect_user" "manager" {
    instance_id = aws_connect_instance.amazon_connect.id
    name = "manageruser"
    password = "SpaceCode3122!"
    routing_profile_id = data.aws_connect_routing_profile.default.id
    security_profile_ids = [data.aws_connect_security_profile.manager.id]
    identity_info {
        first_name = "Manager"
        last_name = "User"
    }
    phone_config {
        phone_type = "SOFT_PHONE"
        auto_accept = false
        after_contact_work_time_limit = 60
    }
}

#Resource User admin
resource "aws_connect_user" "admin" {
    instance_id = aws_connect_instance.amazon_connect.id
    name = "adminuser"
    password = "SpaceCode3122!"
    routing_profile_id = data.aws_connect_routing_profile.default.id
    security_profile_ids = [data.aws_connect_security_profile.admin.id]
    identity_info {
        first_name = "Admin"
        last_name = "User"
    }
    phone_config {
        phone_type = "SOFT_PHONE"
        auto_accept = false
        after_contact_work_time_limit = 60
    }
}
