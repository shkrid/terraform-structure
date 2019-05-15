terraform {
  backend "s3" {
    bucket  = "2terraform-multi-remote-state-common"
    key     = "peering/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}
