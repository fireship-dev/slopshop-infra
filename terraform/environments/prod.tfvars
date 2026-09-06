environment = "prod"
aws_region  = "us-east-1"
vpc_cidr    = "10.20.0.0/16"
az_count    = 3

container_image  = "ghcr.io/fireship-dev/slopshop:latest"
container_cpu    = 512
container_memory = 1024
desired_count    = 2
min_capacity     = 2
max_capacity     = 8

db_instance_class      = "db.t4g.medium"
db_allocated_storage   = 50
db_multi_az            = true
db_deletion_protection = true

log_retention_days      = 90
nat_gateway_per_az      = true
alb_deletion_protection = true
