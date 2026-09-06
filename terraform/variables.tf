variable "project" {
  description = "Project name, used as a prefix for all resources"
  type        = string
  default     = "slopshop"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones to spread subnets across"
  type        = number
  default     = 2
}

variable "container_image" {
  description = "Container image for the SlopShop app (repository:tag)"
  type        = string
}

variable "container_port" {
  description = "Port the app container listens on"
  type        = number
  default     = 3000
}

variable "container_cpu" {
  description = "CPU units for the ECS task (1024 = 1 vCPU)"
  type        = number
  default     = 1024
}

variable "container_memory" {
  description = "Memory (MiB) for the ECS task"
  type        = number
  default     = 1024
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GiB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Name of the application database"
  type        = string
  default     = "slopshop"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "slopshop"
}

variable "db_password" {
  description = "Master password for the database. Pass via TF_VAR_db_password, never commit it."
  type        = string
  sensitive   = true
}

variable "db_multi_az" {
  description = "Whether to run the database in multi-AZ mode"
  type        = bool
  default     = false
}

variable "db_deletion_protection" {
  description = "Whether to enable deletion protection on the database"
  type        = bool
  default     = false
}

variable "min_capacity" {
  description = "Minimum number of ECS tasks for autoscaling"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of ECS tasks for autoscaling"
  type        = number
  default     = 2
}

variable "log_retention_days" {
  description = "CloudWatch log retention for the app log group"
  type        = number
  default     = 30
}

variable "nat_gateway_per_az" {
  description = "Create one NAT gateway per AZ (true) or a single shared one (false)"
  type        = bool
  default     = false
}

variable "alb_deletion_protection" {
  description = "Enable deletion protection on the load balancer"
  type        = bool
  default     = false
}
