resource "aws_cloudfront_distribution" "static_site_dist" {
  origin {
    domain_name = aws_s3_bucket_website_configuration.static_web.website_endpoint
    origin_id = aws_s3_bucket_website_configuration.static_web.website_endpoint
  }
  enabled = true
  is_ipv6_enabled = false
  default_root_object = "index.html"
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket_website_configuration.static_web.website_domain
    viewer_protocol_policy = "allow-all"
  }
  restrictions {
    geo_restriction {
    restriction_type = "none"
    }
  }
}