terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }
}
region = "us-east-1"
prefix = "3terragrunt"
env = "prod"
cidr = "10.1.0.0/16"
public_subnets = ["10.1.1.0/24","10.1.2.0/24"]
private_subnets = ["10.1.101.0/24","10.1.102.0/24"]