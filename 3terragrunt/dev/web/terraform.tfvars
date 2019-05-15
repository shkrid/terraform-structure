terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }
  dependencies {
    paths = ["../vpc"]
  }
}
region = "us-east-1"
prefix = "3terragrunt"
env = "dev"
instance_count = 1
ami = "ami-0565af6e282977273"
instance_type = "t2.micro"
key_name = "shkrid"