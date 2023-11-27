resource "aws_s3_bucket" "dev-iofinnet" {
    bucket                      = "dev-iofinnet-devops"
    object_lock_enabled         = false
    tags                        = {
        "Environment"     = "dev"
        "Name"            = "dev-iofinnet-devops"
        "devops-exercise" = "io.finnet"
    }
    tags_all                    = {
        "Environment"     = "dev"
        "Name"            = "dev-iofinnet-devops"
        "devops-exercise" = "io.finnet"
    }
}

resource "aws_s3_bucket_policy" "dev-iofinnet" {
  bucket = aws_s3_bucket.dev-iofinnet.id
  policy = data.aws_iam_policy_document.dev-iofinnet.json
}

data "aws_iam_policy_document" "dev-iofinnet" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.dev-iofinnet.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3-bucket.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.dev-iofinnet.arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3-bucket.iam_arn]
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dev-iofinnet" {
  bucket = aws_s3_bucket.dev-iofinnet.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "dev-iofinnet-devops" {
  bucket = aws_s3_bucket.dev-iofinnet.id
  versioning_configuration {
    status = "Enabled"
  }
}