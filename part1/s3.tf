# create a S3 bucket
resource "aws_s3_bucket" "nitro_dev_02_bucket" {
  bucket = var.s3_bucket_name
}

# create s3 policy
resource "aws_s3_bucket_policy" "nitro_dev_02_bucket_policy" {
  bucket = aws_s3_bucket.nitro_dev_02_bucket.id
  policy = data.aws_iam_policy_document.nitro_dev_02_bucket_policy.json
}
