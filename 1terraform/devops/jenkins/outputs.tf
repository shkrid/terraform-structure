output "public_ip" {
  value = ["${aws_eip.jenkins.public_ip}"]
}

output "public_dns" {
  value = ["${aws_eip.jenkins.public_dns}"]
}
