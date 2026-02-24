module "vpc" {
  source       = "./modules/vpc"
  environment  = var.environment
  project_name = var.project_name
}


module "iam" {
  source       = "./modules/iam"
  environment  = var.environment
  project_name = var.project_name
  secret_arn   = module.secrets.secret_arn
}

module "ec2" {
  source                 = "./modules/ec2"
  environment            = var.environment
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnet_id
  vpc_id                 = module.vpc.vpc_id
  project_name           = var.project_name
  instance_profile_name  = module.iam.instance_profile_name
}

module "secrets" {
  source       = "./modules/secrets"
  environment  = var.environment
  project_name = var.project_name
  db_password  = var.db_password
}

module "ecr" {
  source       = "./modules/ecr"
  environment  = var.environment
  project_name = var.project_name
}

resource "aws_ecr_repository" "node_app" {
  name = "dev-nodejs-app"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"
}