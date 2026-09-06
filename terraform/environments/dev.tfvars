environment = "dev"
aws_region  = "us-east-1"
vpc_cidr    = "10.10.0.0/16"
az_count    = 2

container_image  = "ghcr.io/fireship-dev/slopshop:dev"
container_cpu    = 256
container_memory = 512
desired_count    = 1

db_instance_class      = "db.t4g.micro"
db_allocated_storage   = 20
db_multi_az            = false
db_deletion_protection = false

log_retention_days      = 7
nat_gateway_per_az      = false
alb_deletion_protection = false
