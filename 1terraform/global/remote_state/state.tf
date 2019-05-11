# Comment out on firts init
terraform {
  backend "s3" {
    bucket  = "1terraform-remote-state-global"
    key     = "global/rs/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true

    # dynamodb_table = "1terraform-remote-state-global"
  }
}
