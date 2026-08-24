
# Module 1: OIDC Identity Provider for dev account 
module "oidc_provider-uat" {
  source = "./modules/oidc"
  providers = {
    aws = aws.fq-uat
  }
}

#create s3 bucket for terraform state file
module "terraform_state-uat" {
  source        = "./modules/terraform_state"
  bucket_name   = "fq-uat-terraform-state-bucket"
  dynom_db_name = "state_dynamo_db"
  tags = { "Name" : "terraform_state",
  "environment" : "uat" }
  providers = {
    aws = aws.fq-uat
  }
}


# creating all the policies in to the dev account 
module "policies-uat" {
  source        = "./modules/policies"
  s3_bucket_arn = module.terraform_state-uat.s3_bucket_name
  providers = {
    aws = aws.fq-uat
  }
}


# Module 2: IAM Role Creation for foundation role into the dev account
module "role_foundation-uat" {
  source              = "./modules/iam_role"
  role_name           = "foundation-role"
  assume_role_policy  = data.aws_iam_policy_document.github_assume_role_policy-uat.json
  managed_policy_arns = [module.policies-uat.fq_foundation_write, module.policies-uat.tfstate_write, "arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/IAMAccessAnalyzerFullAccess", "arn:aws:iam::aws:policy/ServiceQuotasFullAccess"]
  providers = {
    aws = aws.fq-uat
  }
}
