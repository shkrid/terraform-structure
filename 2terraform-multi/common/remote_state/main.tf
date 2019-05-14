#devops account
provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::341835858366:role/shkrid"
  }

  alias = "dev"
}

provider "aws" {
  region = "eu-central-1"

  assume_role {
    role_arn = "arn:aws:iam::870665420981:role/shkrid"
  }

  alias = "prod"
}

module "rs_common" {
  #source = "../../../modules/remote_state"
  #source = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//remote_state?ref=v0.0.2"
  #source = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//remote_state?ref=master"
  source = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//remote_state"

  prefix = "2terraform-multi"
  env    = "common"
}

module "rs_dev" {
  providers = {
    aws = "aws.dev"
  }

  source = "github.com/shkrid/terraform-structure-modules.git//remote_state"
  prefix = "2terraform-multi"
  env    = "dev"
}

module "rs_prod" {
  providers = {
    aws = "aws.prod"
  }

  source  = "github.com/shkrid/terraform-structure-modules.git//remote_state"
  prefix  = "2terraform-multi"
  env     = "prod"
  locking = true
}
