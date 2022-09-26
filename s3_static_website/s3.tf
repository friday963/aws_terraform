resource "aws_s3_bucket_website_configuration" "static_web" {
  bucket = aws_s3_bucket.webbucket.bucket
  

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