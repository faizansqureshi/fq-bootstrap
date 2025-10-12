resource "aws_iam_openid_connect_provider" "github" {
  url = var.oidc_url
  client_id_list = var.client_id_list
}
