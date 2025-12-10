data "aws_iam_policy_document" "github_assume_role_policy-dev" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.github_repos
    }

    principals {
      type        = "Federated"
      identifiers = [module.oidc_provider-dev.oidc_provider_arn]
    }
  }
  provider = aws.fq-dev

}


#trust policy this is just the read trust policy nothing created can attach it to any role
data "aws_iam_policy_document" "github_assume_role_policy-non-prod-network" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.github_repos
    }

    principals {
      type        = "Federated"
      identifiers = [module.oidc_provider-non-prod-network.oidc_provider_arn]
    }
  }
  provider = aws.fq-netw-non-prod

}


data "aws_iam_policy_document" "github_assume_role_policy-network-prod" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.github_repos
    }

    principals {
      type        = "Federated"
      identifiers = [module.oidc_provider-network-prod.oidc_provider_arn]
    }
  }
  provider = aws.fq-netw-prod

}


data "aws_iam_policy_document" "github_assume_role_policy-mgmt" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.github_repos
    }

    principals {
      type        = "Federated"
      identifiers = [module.oidc_provider-mgmt.oidc_provider_arn]
    }
  }
  provider = aws.AWSMGMT

}