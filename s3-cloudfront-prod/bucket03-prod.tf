resource "aws_s3_bucket" "bucket03-prod" {
    bucket                      = "bucket03-prod"
    object_lock_enabled         = false
    tags                        = {}
    tags_all                    = {}
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket03-prod" {
  bucket = aws_s3_bucket.bucket03-prod.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket03-prod" {
  bucket = aws_s3_bucket.bucket03-prod.id
  versioning_configuration {
    status = "Enabled"
  }
}