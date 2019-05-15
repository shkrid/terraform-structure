terraform {
  backend "s3" {
    bucket         = "2terraform-multi-remote-state-prod"
    key            = "web/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    role_arn       = "arn:aws:iam::870665420981:role/admin"
    dynamodb_table = "2terraform-multi-remote-state-prod"
  }
}
