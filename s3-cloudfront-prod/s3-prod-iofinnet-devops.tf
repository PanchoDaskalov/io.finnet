resource "aws_s3_bucket" "prod-iofinnet" {
    bucket                      = "prod-iofinnet-devops"
    object_lock_enabled         = false
    tags                        = {
        "Environment"     = "prod"
        "Name"            = "prod-iofinnet-devops"
        "devops-exercise" = "io.finnet"
    }
    tags_all                    = {
        "Environment"     = "prod"
        "Name"            = "prod-iofinnet-devops"
        "devops-exercise" = "io.finnet"
    }
} 

resource "aws_s3_bucket_policy" "prod-iofinnet" {
  bucket = aws_s3_bucket.prod-iofinnet.id
  policy = data.aws_iam_policy_document.prod-iofinnet.json
}

data "aws_iam_policy_document" "prod-iofinnet" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.prod-iofinnet.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3-bucket.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.prod-iofinnet.arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3-bucket.iam_arn]
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "prod-iofinnet" {
  bucket = aws_s3_bucket.prod-iofinnet.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "prod-iofinnet-devops" {
  bucket = aws_s3_bucket.prod-iofinnet.id
  versioning_configuration {
    status = "Enabled"
  }
}