terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      Student     = var.student
      ManagedBy   = "Terraform"
    }
  }
}

# ─── MÓDULO DE RED ───────────────────────────────────────────────────────
module "network" {
  source = "./modules/network"

  project_name         = var.project_name
  environment          = var.environment
  aws_region           = var.aws_region
  vpc_cidr             = "10.50.0.0/16"
  public_subnet_cidrs  = ["10.50.1.0/24", "10.50.2.0/24"]
  private_subnet_cidrs = ["10.50.11.0/24", "10.50.12.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}

# ─── MÓDULO DE CÓMPUTO ───────────────────────────────────────────────────────

module "compute" {
  source = "./modules/compute"

  project_name       = var.project_name
  environment        = var.environment
  aws_region         = var.aws_region
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
  instance_type      = "t3.micro"
  asg_min_size       = 2
  asg_desired_size   = 2
  asg_max_size       = 6
  key_name           = "p01-webha-key"
  bastion_allowed_ip = ["186.116.80.228"]
}
