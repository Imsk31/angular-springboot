variable "aws_region" {
  type = string
  description = "AWS region for resources"
}
variable "cluster_name" {
  type = string
  description = "Cluster Name"
}
variable "vpc_name" {
  type = string
  description = "VPC Name"
}
variable "vpc_cidr" {
  type = string
  description = "VPC CIDR"
}
variable "public_subnets" {
  type = list(string)
  description = "Public Subnets"
}
variable "private_subnets" {
  type = list(string)
  description = "Private Subnets"
}
variable "intra_subnets" {
  type = list(string)
  description = "Intra Subnets for Cluter"
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