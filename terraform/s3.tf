resource "aws_s3_bucket" "assets" {
  bucket = "${local.name_prefix}-assets-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket_versioning" "assets" {
  bucket = aws_s3_bucket.assets.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "assets" {
  bucket = aws_s3_bucket.assets.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Public policy needs to be allowed here so the CDN can read objects from the bucket.
resource "aws_s3_bucket_public_access_block" "assets" {
  bucket = aws_s3_bucket.assets.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "assets_read" {
  statement {
    sid       = "AllowCDNRead"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.assets.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "assets_read" {
  bucket = aws_s3_bucket.assets.id
  policy = data.aws_iam_policy_document.assets_read.json

  depends_on = [aws_s3_bucket_public_access_block.assets]
}
