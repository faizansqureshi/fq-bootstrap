# using 2 providers ? and understanding the policies ? and service quota and terraform state, review the provider terraform details 


# Module 1: OIDC Identity Provider for dev account 
module "oidc_provider-dev" {
  source = "../modules/oidc"
  providers = {
    aws = aws.fq-dev
  }
}

#trust policy this is just the read trust policy nothing created can attach it to any role


# creating all the policies in to the dev account 
module "policies-dev" {
  source        = "../modules/policies"
  s3_bucket_arn = module.terraform_state.s3_bucket_name
  providers = {
    aws = aws.fq-dev
  }
}

# Module 2: IAM Role Creation for foundation role into the dev account
module "role_foundation-dev" {
  source              = "../modules/iam_role"
  role_name           = "foundation-role"
  assume_role_policy  = data.aws_iam_policy_document.github_assume_role_policy-dev.json
  managed_policy_arns = [module.policies-dev.fq_foundation_write, module.policies-dev.tfstate_write, "arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/IAMAccessAnalyzerFullAccess", "arn:aws:iam::aws:policy/ServiceQuotasFullAccess"]
  providers = {
    aws = aws.fq-dev
  }
}



module "terraform_state" {
  source        = "../modules/terraform_state"
  bucket_name   = "fq-dev-terraform-state-bucket"
  dynom_db_name = "state_dynamo_db"
  tags = { "Name" : "terraform_state",
  "environment" : "dev" }
  providers = {
    aws = aws.fq-dev
  }
}

