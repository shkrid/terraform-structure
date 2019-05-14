terraform {
  backend "s3" {
    bucket  = "1terraform-remote-state-common"
    key     = "common/peering/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
