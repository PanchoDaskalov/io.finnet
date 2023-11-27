resource "aws_s3_bucket" "bucket03-dev" {
    bucket                      = "bucket03-dev"
    object_lock_enabled         = false
    tags                        = {}
    tags_all                    = {}
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket03-dev" {
  bucket = aws_s3_bucket.bucket03-dev.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket03-dev" {
  bucket = aws_s3_bucket.bucket03-dev.id
  versioning_configuration {
    status = "Enabled"
  }
}