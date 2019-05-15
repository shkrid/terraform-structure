terragrunt = {
  remote_state {
    backend = "s3"
    config {
      bucket         = "3terragrunt-remote-state-dev"
      key            = "${path_relative_to_include()}/terraform.tfstate"
      region         = "us-east-1"
      encrypt        = true
      #dynamodb_table = "3terragrunt-remote-state-dev"
    }
  }
}