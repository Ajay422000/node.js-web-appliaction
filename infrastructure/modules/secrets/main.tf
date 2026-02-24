resource "aws_secretsmanager_secret" "app_secret" {
  name = "${var.environment}-app-secret"

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "app_secret_value" {
  secret_id     = aws_secretsmanager_secret.app_secret.id
  secret_string = jsonencode({
    db_password = var.db_password
  })
}