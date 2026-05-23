module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    public_subnets = var.public_subnets
}

module "security_group"{
    source = "./modules/security-group"
    vpc_id = module.vpc.vpc_id
}

module "alb" {
    source = "./modules/alb"
    subnets = module.vpc.public_subnet_ids
    security_group_id = module.security_group.security_group_id
    vpc_id = module.vpc.vpc_id
}

module "autoscaling" {
    source = "./modules/autoscaling"
    ami_id = var.ami_id
    instance_type = var.instance_type
    security_group_id = module.security_group.security_group_id
    subnets = module.vpc.public_subnet_ids
    target_group_arn = module.alb.target_group_arn
}
