output "address" {
  description = "Hostname of the primary instance"
  value       = aws_db_instance.this.address
}

output "endpoint" {
  description = "Endpoint of the primary instance (host:port)"
  value       = aws_db_instance.this.endpoint
}

output "port" {
  description = "Port the instance listens on"
  value       = aws_db_instance.this.port
}

output "instance_id" {
  description = "Identifier of the primary instance"
  value       = aws_db_instance.this.id
}

output "replica_address" {
  description = "Hostname of the read replica, null if none"
  value       = var.create_read_replica ? aws_db_instance.replica[0].address : null
}
