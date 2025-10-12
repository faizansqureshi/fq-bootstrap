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
  profile = "fq-personal-network"
  alias   = "fq-personal-network"
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

