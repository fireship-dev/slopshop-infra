variable "name_prefix" {
  description = "Prefix for resource names, e.g. slopshop-dev"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups attached to the instance"
  type        = list(string)
}

variable "engine_version" {
  description = "Postgres major version"
  type        = string
  default     = "16"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in GiB"
  type        = number
}

variable "db_name" {
  description = "Name of the application database"
  type        = string
}

variable "username" {
  description = "Master username"
  type        = string
}

variable "password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "multi_az" {
  description = "Run the instance in multi-AZ mode"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot when the instance is destroyed"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Days to keep automated backups"
  type        = number
  default     = 7
}
