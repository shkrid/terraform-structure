provider "aws" {
  region = "${var.region}"
}

data "aws_availability_zones" "all" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "${var.prefix}-${var.env}"

  azs             = "${data.aws_availability_zones.all.names}"
  cidr            = "${var.cidr}"
  public_subnets  = "${var.public_subnets}"
  private_subnets = "${var.private_subnets}"

  public_subnet_tags = {
    Name = "${var.prefix}-public-sub-${var.env}"
  }

  private_subnet_tags = {
    Name = "${var.prefix}-private-sub-${var.env}"
  }

  public_route_table_tags = {
    Name = "${var.prefix}-public-rt-${var.env}"
  }

  private_route_table_tags = {
    Name = "${var.prefix}-private-rt-${var.env}"
  }

  igw_tags = {
    Name = "${var.prefix}-igw-${var.env}"
  }

  tags = {
    Name = "${var.prefix}-tag-${var.env}"
  }

  vpc_tags = {
    Name = "${var.prefix}-vpc-${var.env}"
  }
}
