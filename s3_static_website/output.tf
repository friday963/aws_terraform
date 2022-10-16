output "account_id" {
    value = data.aws_caller_identity.current.account_id
}

output "rand_int" {
    value = random_integer.s3bucketrandint.id
}

output "s3_endpoint" {
    value = aws_s3_bucket_website_configuration.static_web.website_endpoint
}

output "cloud_front_endpoint" {
    value = aws_cloudfront_distribution.static_site_dist.aliases
}