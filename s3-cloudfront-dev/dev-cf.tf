resource "aws_cloudfront_origin_access_identity" "s3-bucket" {
  comment = "origin identity for iofinnet"
}

resource "aws_cloudfront_distribution" "distribution-dev" {
    comment                        = "dev - Cloudfront for origin: dev-iofinnet-devops.s3.eu-west-1.amazonaws.com"
    default_root_object            = var.default_root_object
    enabled                        = true
    http_version                   = "http2"
    is_ipv6_enabled                = true
    price_class                    = "PriceClass_All"
    retain_on_delete               = false
    staging                        = false
    tags                           = {
        "Environment"     = "dev"
        "devops-exercise" = "io.finnet"
    }
    tags_all                       = {
        "Environment"     = "dev"
        "devops-exercise" = "io.finnet"
    }
    wait_for_deployment            = true

    custom_error_response {
        error_caching_min_ttl = 0
        error_code            = 404
        response_code         = 200
        response_page_path    = "/index.html"
    }

    default_cache_behavior {
        allowed_methods        = [
            "GET",
            "HEAD",
        ]
        cached_methods         = [
            "GET",
            "HEAD",
        ]
        compress               = true
        default_ttl            = 86400
        max_ttl                = 31536000
        min_ttl                = 0
        smooth_streaming       = false
        target_origin_id       = "dev-iofinnet-devops"
        trusted_key_groups     = []
        trusted_signers        = []
        viewer_protocol_policy = "redirect-to-https"

        forwarded_values {
            headers                 = []
            query_string            = false
            query_string_cache_keys = []

            cookies {
                forward           = "none"
                whitelisted_names = []
            }
        }
    }

    ordered_cache_behavior {
        allowed_methods        = [
            "GET",
            "HEAD",
        ]
        cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        cached_methods         = [
            "GET",
            "HEAD",
        ]
        compress               = true
        default_ttl            = 0
        max_ttl                = 0
        min_ttl                = 0
        path_pattern           = "/auth/*"
        smooth_streaming       = false
        target_origin_id       = "bucket01-dev.s3.eu-west-1.amazonaws.com"
        trusted_key_groups     = []
        trusted_signers        = []
        viewer_protocol_policy = "allow-all"
    }
    ordered_cache_behavior {
        allowed_methods        = [
            "GET",
            "HEAD",
        ]
        cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        cached_methods         = [
            "GET",
            "HEAD",
        ]
        compress               = true
        default_ttl            = 0
        max_ttl                = 0
        min_ttl                = 0
        path_pattern           = "/info/*"
        smooth_streaming       = false
        target_origin_id       = "bucket02-dev.s3.eu-west-1.amazonaws.com"
        trusted_key_groups     = []
        trusted_signers        = []
        viewer_protocol_policy = "allow-all"
    }
    ordered_cache_behavior {
        allowed_methods        = [
            "GET",
            "HEAD",
        ]
        cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        cached_methods         = [
            "GET",
            "HEAD",
        ]
        compress               = true
        default_ttl            = 0
        max_ttl                = 0
        min_ttl                = 0
        path_pattern           = "/customers/*"
        smooth_streaming       = false
        target_origin_id       = "bucket03-dev.s3.eu-west-1.amazonaws.com"
        trusted_key_groups     = []
        trusted_signers        = []
        viewer_protocol_policy = "allow-all"
    }

    origin {
        connection_attempts = 3
        connection_timeout  = 10
        domain_name         = "bucket01-dev.s3.eu-west-1.amazonaws.com"
        origin_id           = "bucket01-dev.s3.eu-west-1.amazonaws.com"
    }
    origin {
        connection_attempts = 3
        connection_timeout  = 10
        domain_name         = "bucket02-dev.s3.eu-west-1.amazonaws.com"
        origin_id           = "bucket02-dev.s3.eu-west-1.amazonaws.com"
    }
    origin {
        connection_attempts = 3
        connection_timeout  = 10
        domain_name         = "bucket03-dev.s3.eu-west-1.amazonaws.com"
        origin_id           = "bucket03-dev.s3.eu-west-1.amazonaws.com"
    }
    origin {
        connection_attempts = 3
        connection_timeout  = 10
        domain_name         = "dev-iofinnet-devops.s3.eu-west-1.amazonaws.com"
        origin_id           = "dev-iofinnet-devops"

        s3_origin_config {
            origin_access_identity = aws_cloudfront_origin_access_identity.s3-bucket.cloudfront_access_identity_path
        }
    }

    restrictions {
        geo_restriction {
            locations        = []
            restriction_type = "none"
        }
    }

    viewer_certificate {
        cloudfront_default_certificate = true
        minimum_protocol_version       = "TLSv1"
    }
}