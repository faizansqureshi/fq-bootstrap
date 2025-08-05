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
data "aws_iam_policy_document" "github_assume_role_policy-network" {
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
      identifiers = [module.oidc_provider-network.oidc_provider_arn]
    }
  }
  provider = aws.fq-personal-network

}
