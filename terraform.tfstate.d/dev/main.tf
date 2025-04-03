module "vpc" {
    source = "./vpc-m"
    tp_vpc_cidrblock= "10.0.0.0/16"
}

module "az1_publicsubnet" {
  source = "./subnet-m"
  tp_subnet_vpcid = module.vpc.tp_output_vpcid
  tp_subnet_cidrblock = "10.0.0.0/24"
  tp_subnet_availabilityzone = "us-east-1a"
  tp_subnet_name = "az1_publicsubnet"
  publicorprivate = true
}

module "az1_privatesubnet" {
  source = "./subnet-m"
  tp_subnet_vpcid = module.vpc.tp_output_vpcid
  tp_subnet_cidrblock = "10.0.1.0/24"
  tp_subnet_availabilityzone = "us-east-1a"
  tp_subnet_name = "az1_privatesubnet"
  publicorprivate = false
  
}

module "az2_publicsubnet" {
  source = "./subnet-m"
  tp_subnet_vpcid = module.vpc.tp_output_vpcid
  tp_subnet_cidrblock = "10.0.2.0/24"
  tp_subnet_availabilityzone = "us-east-1b"
  tp_subnet_name = "az2_publicsubnet"
  publicorprivate = true
}

module "az2_privatesubnet" {
  source = "./subnet-m"
  tp_subnet_vpcid = module.vpc.tp_output_vpcid
  tp_subnet_cidrblock = "10.0.3.0/24"
  tp_subnet_availabilityzone = "us-east-1b"
  tp_subnet_name = "az2_privatesubnet"
  publicorprivate = false
  
}


data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

