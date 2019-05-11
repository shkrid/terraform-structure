variable "region" {
  default     = "us-east-1"
  description = "The name of the AWS region"
}

variable "prefix" {
  default     = "prefix"
  description = "The name of our org, i.e. examplecom."
}

variable "env" {
  default     = "env"
  description = "The name of our environment, i.e. development."
}

variable "cidr" {}

variable "public_subnets" {
  type = "list"
}

variable "private_subnets" {
  type = "list"
}
