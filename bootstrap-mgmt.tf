

module "oidc_provider-mgmt" {
  source = "./modules/oidc"
  providers = {
    aws = aws.AWSMGMT
}
}

module "terraform_state-mgmt" {
  source        = "./modules/terraform_state"
  bucket_name   = "fq-mgmt-terraform-state-bucket"
  dynom_db_name = "state_dynamo_db"
  tags = { "Name" : "terraform_state",
  "environment" : "mgmt" }
  providers = {
    aws = aws.AWSMGMT
  }
}