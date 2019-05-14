#devops account
provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::341835858366:role/shkrid"
  }

  alias = "dev"
}

provider "aws" {
  region = "eu-central-1"

  assume_role {
    role_arn = "arn:aws:iam::870665420981:role/shkrid"
  }

  alias = "prod"
}

data "aws_caller_identity" "devops" {}

data "aws_caller_identity" "dev" {
  provider = "aws.dev"
}

data "aws_caller_identity" "prod" {
  provider = "aws.prod"
}

############
# IAM users
############
module "play" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name = "play"

  create_iam_user_login_profile = false
}

module "joule" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name = "joule"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

#####################################################################################
# Several IAM assumable roles (admin, poweruser, readonly) in production AWS account
# Note: Anyone from IAM account can assume them.
#####################################################################################
module "iam_assumable_roles_in_dev" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::${data.aws_caller_identity.devops.account_id}:root",
  ]

  create_admin_role       = true
  admin_role_requires_mfa = false

  create_readonly_role       = true
  readonly_role_requires_mfa = false

  create_poweruser_role = false

  providers = {
    aws = "aws.dev"
  }
}

module "iam_assumable_roles_in_prod" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::${data.aws_caller_identity.devops.account_id}:root",
  ]

  create_admin_role       = true
  admin_role_requires_mfa = false

  create_readonly_role       = true
  readonly_role_requires_mfa = false

  create_poweruser_role = false

  providers = {
    aws = "aws.prod"
  }
}

# module "iam_assumable_role_custom" {
#   source = "../../modules/iam-assumable-role"

#   trusted_role_arns = [
#     "arn:aws:iam::${data.aws_caller_identity.iam.account_id}:root",
#   ]

#   create_role = true

#   role_name         = "custom"
#   role_requires_mfa = true

#   custom_role_policy_arns = [
#     "arn:aws:iam::aws:policy/AmazonCognitoReadOnly",
#     "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess",
#   ]

#   providers = {
#     aws = "aws.production"
#   }
# }

# ################################################################################################
# # IAM group where user1 and user2 are allowed to assume readonly role in production AWS account
# # Note: IAM AWS account is default, so there is no need to specify it here.
# ################################################################################################
## Prod ##
module "iam_group_with_assumable_roles_policy_prod_readonly" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"

  name = "prod-readonly"

  assumable_roles = ["${module.iam_assumable_roles_in_prod.readonly_iam_role_arn}"]

  group_users = [
    "${module.play.this_iam_user_name}",
    "${module.joule.this_iam_user_name}",
    "shkrid",
  ]
}

module "iam_group_with_assumable_roles_policy_prod_admin" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"

  name = "prod-admin"

  assumable_roles = ["${module.iam_assumable_roles_in_prod.admin_iam_role_arn}"]

  group_users = [
    "${module.play.this_iam_user_name}",
    "shkrid",
  ]
}

## DEV ##
module "iam_group_with_assumable_roles_policy_dev_readonly" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"

  name = "dev-readonly"

  assumable_roles = ["${module.iam_assumable_roles_in_prod.readonly_iam_role_arn}"]

  group_users = [
    "${module.play.this_iam_user_name}",
    "${module.joule.this_iam_user_name}",
    "shkrid",
  ]
}

module "iam_group_with_assumable_roles_policy_dev_admin" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"

  name = "dev-admin"

  assumable_roles = ["${module.iam_assumable_roles_in_dev.admin_iam_role_arn}"]

  group_users = [
    "${module.play.this_iam_user_name}",
    "shkrid",
  ]
}

# ################################################################################################
# # IAM group where user1 is allowed to assume admin role in production AWS account
# # Note: IAM AWS account is default, so there is no need to specify it here.
# ################################################################################################
# module "iam_group_with_assumable_roles_policy_production_admin" {
#   source = "../../modules/iam-group-with-assumable-roles-policy"


#   name = "production-admin"


#   assumable_roles = ["${module.iam_assumable_roles_in_prod.admin_iam_role_arn}"]


#   group_users = [
#     "${module.iam_user1.this_iam_user_name}",
#   ]
# }


# ################################################################################################
# # IAM group where user2 is allowed to assume custom role in production AWS account
# # Note: IAM AWS account is default, so there is no need to specify it here.
# ################################################################################################
# module "iam_group_with_assumable_roles_policy_production_custom" {
#   source = "../../modules/iam-group-with-assumable-roles-policy"


#   name = "production-custom"


#   assumable_roles = ["${module.iam_assumable_role_custom.this_iam_role_arn}"]


#   group_users = [
#     "${module.iam_user2.this_iam_user_name}",
#   ]
# }

