resource "aws_s3_bucket" "web_static" {
  bucket = "steven-status-web-bucket" 
  tags   = local.common_tags
}

# static web site hosting setting
resource "aws_s3_bucket_website_configuration" "web_config" {
  bucket = aws_s3_bucket.web_static.id
  index_document { suffix = "index.html" }
}

# public access prevention deactivated (For web service)
resource "aws_s3_bucket_public_access_block" "web_access" {
  bucket = aws_s3_bucket.web_static.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}