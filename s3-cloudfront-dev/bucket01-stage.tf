resource "aws_s3_bucket" "bucket01-stage" {
    bucket                      = "bucket01-stage"
    object_lock_enabled         = false
    tags                        = {}
    tags_all                    = {}
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket01-stage" {
  bucket = aws_s3_bucket.bucket01-stage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket01-stage" {
  bucket = aws_s3_bucket.bucket01-stage.id
  versioning_configuration {
    status = "Enabled"
  }
}