provider "aws" {
  region = "us-east-1"
}

module "rs_global" {
  #source = "../../../modules/remote_state"
  source = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//remote_state?ref=v0.0.2"
  prefix = "1terraform"
  env    = "global"
}

module "rs_dev" {
  source = "git@github.com:shkrid/terraform-structure-modules.git//remote_state?ref=v0.0.2"
  prefix = "1terraform"
  env    = "dev"
}

module "rs_prod" {
  #source = "../../../modules/remote_state"
  source  = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//remote_state?ref=v0.0.2"
  prefix  = "1terraform"
  env     = "prod"
  locking = true
}
