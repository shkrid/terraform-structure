variable "region" {}
variable "prefix" {}
variable "env" {}
variable "cidr" {}

variable "public_subnets" {
  type = "list"
}

variable "private_subnets" {
  type = "list"
}
