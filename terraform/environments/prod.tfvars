environment = "prod"
aws_region  = "us-east-1"
vpc_cidr    = "10.20.0.0/16"
az_count    = 3

container_image  = "ghcr.io/fireship-dev/slopshop:latest"
container_cpu    = 512
container_memory = 1024
desired_count    = 2

db_instance_class      = "db.t4g.medium"
db_allocated_storage   = 50
db_multi_az            = true
db_deletion_protection = true
db_create_read_replica = true
