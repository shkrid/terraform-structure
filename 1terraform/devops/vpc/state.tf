terraform {
  backend "s3" {
    bucket         = "1terraformj-remote-state-devops"
    key            = "vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "1terraformj-remote-state-devops	"
  }
}
