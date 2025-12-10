terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

}


provider "aws" {
  region  = "eu-west-1"
  profile = "fq-netw-non-prod"
  alias   = "fq-netw-non-prod"
}

provider "aws" {
  region  = "eu-west-1"
  profile = "fq-dev"
  alias   = "fq-dev"
}

provider "aws" {
  region  = "eu-west-1"
  profile = "AWSMGMT"
  alias   = "AWSMGMT"
}

provider "aws" {
  region  = "eu-west-1"
  profile = "fq-test"
  alias   = "fq-test"
}

provider "aws" {
  region  = "eu-west-1"
  profile = "fq-uat"
  alias   = "fq-uat"
}

provider "aws" {
  region  = "eu-west-1"
  profile = "fq-prod"
  alias   = "fq-prod"
}


provider "aws" {
  region  = "eu-west-1"
  profile = "fq-netw-prod"
  alias   = "fq-netw-prod"
}


terraform {
  backend "s3" {
    bucket         = "tfstate-bootstrap-state-s13082025"
    key            = "bootstrap/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraformstate-locks-tfstate-s3082025"
    encrypt        = true
    profile        = "AWSMGMT"
  }
}

