terraform {
  backend "s3" {
    bucket   = "2terraform-multi-remote-state-dev"
    key      = "dev/vpc/terraform.tfstate"
    region   = "us-east-1"
    encrypt  = true
    role_arn = "arn:aws:iam::341835858366:role/admin"

    # dynamodb_table = "2terraform-multi-remote-state-dev"
  }
}
