provider "aws" {
  region = "us-east-1"
}

module "rs_commonl" {
  #source = "../../../modules/remote_state"
  #source = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//remote_state?ref=v0.0.2"
  #source = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//remote_state?ref=master"
  source = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//remote_state"

  prefix = "1terraform"
  env    = "common"
}

module "rs_dev" {
  source = "git@github.com:shkrid/terraform-structure-modules.git//remote_state"
  prefix = "1terraform"
  env    = "dev"
}

module "rs_prod" {
  source  = "github.com/shkrid/terraform-structure-modules.git//remote_state"
  prefix  = "1terraform"
  env     = "prod"
  locking = true
}
