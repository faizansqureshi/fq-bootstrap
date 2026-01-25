variable "github_repos" {
  type        = list(string)
  description = "Allowed GitHub OIDC sub values"
  default = [
    "repo:faizansqureshi/fq-foundation-repo:pull_request",
    "repo:faizansqureshi/fq-foundation-repo:ref:refs/heads/main"
  ]
}

