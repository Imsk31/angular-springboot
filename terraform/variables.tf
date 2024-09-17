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

