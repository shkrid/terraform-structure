provider "aws" {
  region = "${var.region}"

  assume_role {
    role_arn = "arn:aws:iam::870665420981:role/admin"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket   = "${var.prefix}-remote-state-${var.env}"
    key      = "${var.env}/vpc/terraform.tfstate"
    region   = "eu-central-1"
    role_arn = "arn:aws:iam::870665420981:role/admin"
  }
}

module "web" {
  source         = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//web"
  prefix         = "${var.prefix}"
  env            = "${var.env}"
  instance_count = "${var.instance_count}"
  ami            = "${var.ami}"
  instance_type  = "${var.instance_type}"
  key_name       = "${var.key_name}"
  subnet_ids     = ["${data.terraform_remote_state.vpc.public_subnets}"]
  vpc_id         = "${data.terraform_remote_state.vpc.vpc_id}"
}
