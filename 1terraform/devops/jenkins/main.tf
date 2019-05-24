provider "aws" {
  region = "${var.region}"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "${var.prefix}-remote-state-${var.env}"
    key    = "vpc/terraform.tfstate"
    region = "${var.region}"
  }
}

#
# EFS
#
resource "aws_efs_file_system" "jenkins" {
  tags = {
    Name = "${var.prefix}-jenkins-${var.env}"
  }
}

resource "aws_efs_mount_target" "jenkins" {
  count           = "${length(data.terraform_remote_state.vpc.private_subnets)}"
  file_system_id  = "${aws_efs_file_system.jenkins.id}"
  subnet_id       = "${data.terraform_remote_state.vpc.private_subnets[count.index]}"
  security_groups = ["${module.nfs_all_sg.this_security_group_id}"]
}

module "nfs_all_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "${var.prefix}-nfs-sg-${var.env}"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["nfs-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

#
# Jenkins
#
data "template_file" "user_data" {
  template = "${file("files/userdata.sh")}"

  vars {
    efs_dnsname = "${aws_efs_file_system.jenkins.dns_name}"
  }
}

resource "aws_instance" "jenkins" {
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  monitoring                  = true
  vpc_security_group_ids      = ["${module.jenkins_sg.this_security_group_id}"]
  subnet_id                   = "${data.terraform_remote_state.vpc.public_subnets[0]}"
  associate_public_ip_address = true

  user_data = "${data.template_file.user_data.rendered}"

  tags = {
    Name = "${var.prefix}-jenkins-${var.env}"
  }

  depends_on = ["aws_efs_mount_target.jenkins"]
}

resource "aws_eip" "jenkins" {
  vpc      = true
  instance = "${aws_instance.jenkins.id}"
}

module "jenkins_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "${var.prefix}-jenkins-sg-${var.env}"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-8080-tcp", "all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}
