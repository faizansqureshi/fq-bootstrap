# using 2 providers ? and understanding the policies ? and service quota and terraform state, review the provider terraform details 


# Module 1: OIDC Identity Provider for dev account 
module "oidc_provider-non-prod-network" {
  source = "./modules/oidc"
  providers = {
    aws = aws.fq-netw-non-prod
  }
}



# creating all the policies in to the dev account 
module "policies-non-prod-network" {
  source        = "./modules/policies"
  s3_bucket_arn = module.terraform_state-non-prod-network.s3_bucket_name
  providers = {
    aws = aws.fq-netw-non-prod
  }
}

# Module 2: IAM Role Creation for foundation role into the dev account
module "role_foundation--non-prod-network" {
  source              = "./modules/iam_role"
  role_name           = "foundation-role"
  assume_role_policy  = data.aws_iam_policy_document.github_assume_role_policy-non-prod-network.json
  managed_policy_arns = [module.policies-non-prod-network.fq_foundation_write, module.policies-non-prod-network.tfstate_write, "arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/IAMAccessAnalyzerFullAccess", "arn:aws:iam::aws:policy/ServiceQuotasFullAccess"]
  providers = {
    aws = aws.fq-netw-non-prod
  }
}



module "terraform_state-non-prod-network" {
  source        = "./modules/terraform_state"
  bucket_name   = "fq-network-terraform-state-bucket"
  dynom_db_name = "state_dynamo_db"
  tags = { "Name" : "terraform_state",
  "environment" : "non-prod-network" }
  providers = {
    aws = aws.fq-netw-non-prod
  }
}

