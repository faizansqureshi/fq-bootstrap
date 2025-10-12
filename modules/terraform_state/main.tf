module "s3_state"{
    source = "../s3"
    bucket_name = var.bucket_name
tags = var.tags
}


resource "aws_dynamodb_table" "terraform-locks" {
    name         = var.dynom_db_name
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}