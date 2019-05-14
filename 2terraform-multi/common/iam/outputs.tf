output "prod.readonly_iam_role_arn" {
  value = "${module.iam_assumable_roles_in_prod.readonly_iam_role_arn}"
}

output "prod.admin_iam_role_arn" {
  value = "${module.iam_assumable_roles_in_prod.admin_iam_role_arn}"
}

output "dev.readonly_iam_role_arn" {
  value = "${module.iam_assumable_roles_in_dev.readonly_iam_role_arn}"
}

output "dev.admin_iam_role_arn" {
  value = "${module.iam_assumable_roles_in_dev.admin_iam_role_arn}"
}
