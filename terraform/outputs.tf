output "alb_dns_name" {
  description = "Public DNS name of the load balancer"
  value       = aws_lb.app.dns_name
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.app.name
}

output "db_endpoint" {
  description = "RDS endpoint (host:port)"
  value       = module.rds.endpoint
}

output "assets_bucket_name" {
  description = "Name of the static assets bucket"
  value       = aws_s3_bucket.assets.bucket
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}
