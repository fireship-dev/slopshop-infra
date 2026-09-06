environment = "staging"
aws_region  = "us-east-1"
vpc_cidr    = "10.30.0.0/16"
az_count    = 2

container_image  = "ghcr.io/fireship-dev/slopshop:staging"
container_cpu    = 512
container_memory = 1024
desired_count    = 2
min_capacity     = 1
max_capacity     = 4

db_instance_class      = "db.t4g.small"
db_allocated_storage   = 20
db_multi_az            = false
db_deletion_protection = true

log_retention_days      = 14
nat_gateway_per_az      = true
alb_deletion_protection = false
