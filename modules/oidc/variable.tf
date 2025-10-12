variable "oidc_url" {
  description = "The URL for the OIDC identity provider"
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}

variable "client_id_list" {
  description = "Client ID list for OIDC"
  type        = list(string)
  default     = ["sts.amazonaws.com"]
}
