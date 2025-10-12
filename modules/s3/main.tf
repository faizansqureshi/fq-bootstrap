
# modules/s3_state_storage/main.tf

resource "aws_s3_bucket" "state_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = var.tags
  
}
