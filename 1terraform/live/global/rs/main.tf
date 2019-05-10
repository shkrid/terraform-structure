provider "aws" {
  region = "us-east-1"
}

module "rs_global" {
  source = "../../../modules/remote_state"
  prefix = "1terraform"
  env    = "global"
  locking = true
}

module "rs_dev" {
  source          = "../../../modules/remote_state"
  prefix          = "1terraform"
  env             = "dev"
  prevent_destroy = false
}

module "rs_prod" {
  source = "../../../modules/remote_state"
  prefix = "1terraform"
  env    = "prod"
  locking = true
}
