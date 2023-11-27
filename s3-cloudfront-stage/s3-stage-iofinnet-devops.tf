resource "aws_s3_bucket" "stage-iofinnet" {
    bucket                      = "stage-iofinnet-devops"
    object_lock_enabled         = false
    tags                        = {
        "Environment"     = "stage"
        "Name"            = "stage-iofinnet-devops"
        "devops-exercise" = "io.finnet"
    }
    tags_all                    = {
        "Environment"     = "stage"
        "Name"            = "stage-iofinnet-devops"
        "devops-exercise" = "io.finnet"
    }
}

resource "aws_s3_bucket_policy" "stage-iofinnet" {
  bucket = aws_s3_bucket.stage-iofinnet.id
  policy = data.aws_iam_policy_document.stage-iofinnet.json
}

data "aws_iam_policy_document" "stage-iofinnet" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.stage-iofinnet.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3-bucket.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.stage-iofinnet.arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3-bucket.iam_arn]
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "stage-iofinnet" {
  bucket = aws_s3_bucket.stage-iofinnet.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "stage-iofinnet-devops" {
  bucket = aws_s3_bucket.stage-iofinnet.id
  versioning_configuration {
    status = "Enabled"
  }
}