variable "aws_region" {
  type = string
  description = "AWS region for resources"
}
variable "azs" {
  type = list(string)
  description = "Availability Zones"
}

variable "rds_username" {
  type = string
  description = "Master username for rds"
}

variable "rds_password" {
  type = string
  description = "Master password for rds"
}

variable "db-name" {
  type = string
  description = "RDS Name"
}

variable "rds_instance_class" {
  type = string
  description = "RDS Instance Class"
}

variable "rds_engine" {
  type = string
  description = "RDS engine"
}