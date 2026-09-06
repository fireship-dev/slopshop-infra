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
