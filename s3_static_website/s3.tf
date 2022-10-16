resource "aws_s3_bucket_website_configuration" "static_web" {
  bucket = aws_s3_bucket.webbucket.id
  

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

#   routing_rule {
#     condition {
#       key_prefix_equals = "docs/"
#     }
#     redirect {
#       replace_key_prefix_with = "documents/"
#     }
#   }
}

resource "aws_s3_bucket_acl" "site" {
  bucket = aws_s3_bucket.webbucket.id
  acl = "public-read"
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.webbucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = [
          aws_s3_bucket.webbucket.arn,
          "${aws_s3_bucket.webbucket.arn}/*",
        ]
      },
    ]
  })
}

resource "aws_s3_object" "webpages" {
  for_each = fileset("web_page_content/", "*")
  bucket = aws_s3_bucket.webbucket.id
  key = each.value
  source = "web_page_content/${each.value}"
  etag = filemd5("web_page_content/${each.value}")
  content_type = "text/html"
}

resource "aws_s3_account_public_access_block" "block_pub" {
  block_public_acls = false
  block_public_policy = false
}

resource "aws_s3_bucket" "webbucket" {
 
  bucket = "static-web-${data.aws_caller_identity.current.account_id}${random_integer.s3bucketrandint.id}"
  
  tags = {
    "Name" = "My_Web_Bucket"
  }
}