module "rds" {
  source = "./modules/rds"

  name_prefix        = local.name_prefix
  subnet_ids         = aws_subnet.private[*].id
  security_group_ids = [aws_security_group.rds.id]

  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password

  multi_az            = var.db_multi_az
  deletion_protection = var.db_deletion_protection
  skip_final_snapshot = var.environment != "prod"
}

# Connection string for the app, stored as a SecureString and injected into the task as a secret.
resource "aws_ssm_parameter" "database_url" {
  name  = "/${var.project}/${var.environment}/DATABASE_URL"
  type  = "SecureString"
  value = "postgresql://${var.db_username}:${var.db_password}@${module.rds.address}:${module.rds.port}/${var.db_name}"
}
