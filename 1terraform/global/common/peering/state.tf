terraform {
  backend "s3" {
    bucket  = "1terraform-remote-state-global"
    key     = "global/common/peering/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
