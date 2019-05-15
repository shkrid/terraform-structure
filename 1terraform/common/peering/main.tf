# At this time it is required to write an explicit proxy configuration block even for default (un-aliased) provider 
# configurations when they will be passed via an explicit providers block:
# provider "aws" {
# }
# If such a block is not present, the child module will behave as if it has no configurations of this type at all, 
# which may cause input prompts to supply any required provider configuration arguments. 
# This limitation will be addressed in a future version of Terraform.
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "source"
  region = "us-east-1"
}

provider "aws" {
  alias  = "destination"
  region = "us-east-1"
}

data "terraform_remote_state" "vpc_src" {
  backend = "s3"

  config {
    bucket = "1terraform-remote-state-dev"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "vpc_dst" {
  backend = "s3"

  config {
    bucket = "1terraform-remote-state-prod"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

module "peering_dev_to_prod" {
  source = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//peering"

  providers = {
    aws.src = "aws.source"
    aws.dst = "aws.destination"
  }

  peer_vpc_id = "${data.terraform_remote_state.vpc_dst.vpc_id}"
  vpc_id      = "${data.terraform_remote_state.vpc_src.vpc_id}"
}
