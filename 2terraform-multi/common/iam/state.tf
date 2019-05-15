terraform {
  backend "s3" {
    bucket  = "2terraform-multi-remote-state-common"
    key     = "iam/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}
