

module "oidc_provider-mgmt" {
  source = "./modules/oidc"
  providers = {
    aws = aws.AWSMGMT
}
}


module "policies-mgmt" {
  source        = "./modules/policies"
  s3_bucket_arn = module.terraform_state-mgmt.s3_bucket_name
  providers = {
    aws = aws.AWSMGMT
  }
}

# Module 2: IAM Role Creation for foundation role into the dev account
module "role_foundation-mgmt" {
  source              = "./modules/iam_role"
  role_name           = "foundation-role"
  assume_role_policy  = data.aws_iam_policy_document.github_assume_role_policy-mgmt.json
  managed_policy_arns = [module.policies-mgmt.fq_foundation_write, module.policies-mgmt.tfstate_write, "arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/IAMAccessAnalyzerFullAccess", "arn:aws:iam::aws:policy/ServiceQuotasFullAccess","arn:aws:iam::aws:policy/AdministratorAccess"]
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