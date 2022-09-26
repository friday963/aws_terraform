data "aws_caller_identity" "current" {}

resource "random_integer" "s3bucketrandint" {
  min = 10
  max = 100
}