resource "aws_cloudfront_distribution" "assets" {
  enabled             = true
  comment             = "${local.name_prefix} static assets"
  price_class         = "PriceClass_100"
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.assets.bucket_regional_domain_name
    origin_id   = "s3-assets"
  }

  default_cache_behavior {
    target_origin_id       = "s3-assets"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 86400
    max_ttl     = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name = "${local.name_prefix}-assets-cdn"
  }
}
