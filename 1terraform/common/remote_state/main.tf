provider "aws" {
  region = "us-east-1"
}

module "rs_common" {
  #source = "../../../modules/remote_state"
  #source = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//remote_state?ref=v0.0.2"
  #source = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//remote_state?ref=master"
  source = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//remote_state"

  prefix = "1terraformj"
  env    = "common"
}

module "rs_dev" {
  source = "git@github.com:shkrid/terraform-structure-modules.git//remote_state"
  prefix = "1terraformj"
  env    = "dev"
}

module "rs_prod" {
  source  = "github.com/shkrid/terraform-structure-modules.git//remote_state"
  prefix  = "1terraformj"
  env     = "prod"
  locking = true
}

module "rs_devops" {
  source  = "github.com/shkrid/terraform-structure-modules.git//remote_state"
  prefix  = "1terraformj"
  env     = "devops"
  locking = true
}
