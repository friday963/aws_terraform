output "account_id" {
    value = data.aws_caller_identity.current.account_id
}

output "rand_int" {
    value = random_integer.s3bucketrandint.id
}