resource "aws_dynamodb_table" "template_table" {
  name         = "user-template-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "user"
  range_key    = "id"

  attribute {
    name = "user"
    type = "S"
  }

  attribute {
    name = "id"
    type = "S"
  }

  tags = local.tags
}