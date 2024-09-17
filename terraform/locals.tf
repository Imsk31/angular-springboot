locals {
  region = var.aws_region
  name   = var.cluster_name
  vpc_cidr = var.vpc_cidr
  azs      = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  intra_subnets   = var.intra_subnets
  tags = {
    Example = local.name
  }
}