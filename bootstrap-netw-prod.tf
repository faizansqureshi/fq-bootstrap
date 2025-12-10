module "oidc_provider-network-prod" {
  source = "./modules/oidc"
  providers = {
    aws = aws.fq-netw-prod
  }
}


module "policies-network-prod" {
  source        = "./modules/policies"
  s3_bucket_arn = module.terraform_state-network-prod.s3_bucket_name
  providers = {
    aws = aws.fq-netw-prod
  }
}


module "terraform_state-network-prod" {
  source        = "./modules/terraform_state"
  bucket_name   = "fq-netw-prod-terraform-state-bucket"
  dynom_db_name = "state_dynamo_db"
  tags = { "Name" : "terraform_state",
  "environment" : "prod" }
  providers = {
    aws = aws.fq-netw-prod
  }
}


# Module 2: IAM Role Creation for foundation role into the dev account
module "role_foundation-network-prod" {
  source              = "./modules/iam_role"
  role_name           = "foundation-role"
  assume_role_policy  = data.aws_iam_policy_document.github_assume_role_policy-network-prod.json
  managed_policy_arns = [module.policies-network-prod.fq_foundation_write, module.policies-network-prod.tfstate_write, "arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/IAMAccessAnalyzerFullAccess", "arn:aws:iam::aws:policy/ServiceQuotasFullAccess"]
  providers = {
    aws = aws.fq-netw-prod
  }
}