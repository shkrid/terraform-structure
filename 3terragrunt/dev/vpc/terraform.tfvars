terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }
}
region = "us-east-1"
prefix = "3terragrunt"
env = "prod"
cidr = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24","10.0.2.0/24"]
private_subnets = ["10.0.101.0/24","10.0.102.0/24"]