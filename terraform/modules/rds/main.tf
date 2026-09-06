resource "aws_db_subnet_group" "this" {
  name       = "${var.name_prefix}-db"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.name_prefix}-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier = "${var.name_prefix}-db"

  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.allocated_storage * 5
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.username
  password = var.password
  port     = 5432

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.security_group_ids
  publicly_accessible    = false
  multi_az               = var.multi_az

  backup_retention_period   = var.backup_retention_period
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.name_prefix}-db-final"

  performance_insights_enabled = true
  deletion_protection          = var.deletion_protection
}

# Optional read replica. Automated backups must be enabled on the primary for this to work,
# which they are as long as backup_retention_period > 0.
resource "aws_db_instance" "replica" {
  count = var.create_read_replica ? 1 : 0

  identifier          = "${var.name_prefix}-db-replica"
  replicate_source_db = aws_db_instance.this.identifier
  instance_class      = coalesce(var.replica_instance_class, var.instance_class)

  vpc_security_group_ids = var.security_group_ids
  publicly_accessible    = false
  storage_encrypted      = true

  skip_final_snapshot          = true
  performance_insights_enabled = true
  deletion_protection          = var.deletion_protection
}
