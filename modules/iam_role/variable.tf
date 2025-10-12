variable "role_name" {
  description = "Name of the IAM role to create"
  type        = string
}

variable "assume_role_policy" {
  type = string
  description = "Assume role policy"
}

variable "managed_policy_arns" {
  type = list(string)
}

# variable "github_repo" {
#   description = "GitHub repository details (e.g., repo:org/repo)"
#   type        = string
# }

