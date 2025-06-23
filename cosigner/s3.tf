# create a S3 bucket
resource "aws_s3_bucket" "nitro_mainnet_bucket" {
  bucket = "nitro-mainnet-bucket-${random_id.bucket_suffix.hex}"
}

# create s3 policy
resource "aws_s3_bucket_policy" "nitro_mainnet_bucket_policy" {
  bucket = aws_s3_bucket.nitro_mainnet_bucket.id
  policy = data.aws_iam_policy_document.nitro_mainnet_bucket_policy.json
}

# Random ID for bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 4
}
