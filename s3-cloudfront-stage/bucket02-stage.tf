resource "aws_s3_bucket" "bucket02-stage" {
    bucket                      = "bucket02-stage"
    object_lock_enabled         = false
    tags                        = {}
    tags_all                    = {}
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket02-stage" {
  bucket = aws_s3_bucket.bucket02-stage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket02-stage" {
  bucket = aws_s3_bucket.bucket02-stage.id
  versioning_configuration {
    status = "Enabled"
  }
}