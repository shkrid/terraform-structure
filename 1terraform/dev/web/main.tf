provider "aws" {
  region = "${var.region}"
}

module "web" {
  #source = "../../../modules/web"
  source         = "git::ssh://git@github.com/shkrid/terraform-structure-modules.git//web?ref=v0.0.3"
  region         = "${var.region}"
  prefix         = "${var.prefix}"
  env            = "${var.env}"
  instance_count = "${var.instance_count}"
  ami            = "${var.ami}"
  instance_type  = "${var.instance_type}"
  key_name       = "${var.key_name}"
}
