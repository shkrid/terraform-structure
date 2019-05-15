terraform {
  backend "s3" {
    bucket  = "1terraform-remote-state-dev"
    key     = "vpc/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true

    # dynamodb_table = "1terraform-remote-state-dev"
  }
}
