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

module "igw" {
  source = "./igw-m"
  igw_vpc_id = module.vpc.tp_output_vpcid
  igw_name = "tp-igw"
}

module "public_routetable" {
  source = "./routingt-m"
  tp_rt_vpcid = module.vpc.tp_output_vpcid
  rt_routes = [ 
    {
        cidr_block = "0.0.0.0/24"
        gateway_id = module.igw.igw_output_id

    }
   ]

   tp_rt_name = "public_routetable"
}

module "associate_routetable_az1" {
    source = "./associatert-m"
    assrt_subnetid = module.az1_publicsubnet.subnet_outputid
    assrt_routetableid = module.public_routetable.tp_routingtable_outputid

}

module "associate_routetable_az2" {
    source = "./associatert-m"
    assrt_subnetid = module.az2_publicsubnet.subnet_outputid
    assrt_routetableid = module.public_routetable.tp_routingtable_outputid

}

module "securitygroup_publicsub" {
  source = "./sg-m"
  sg_name = "public-sg"
  sg_vpcid = module.vpc.tp_output_vpcid

  sg_ingress_rules = [ {
    from_port = 80
    to_port = 80
    protocol = tcp
    cidr_blocks = "0.0.0.0/24"
  },
  {
    from_port = 443
    to_port = 443
    protocol = tcp
    cidr_blocks = "0.0.0.0/24"
  },{
    from_port = 22
    to_port = 22
    protocol = tcp
    cidr_blocks = "0.0.0.0/24"
  }
  ]
}

data "aws_ami" "amazon_linux" {
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"] # Pattern for Amazon Linux 2 AMIs
  }

  filter {
    name   = "architecture"
    values = ["x86_64"] # Specify architecture (e.g., x86_64 or arm64)
  }

  filter {
    name   = "owner-id"
    values = ["137112412989"] # Amazon's official owner ID for Amazon Linux
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  most_recent = true
}


module "Alb_publicsubnet" {
  source = "./loadbalancer-m"
  lb_name = "Alb-for-public-subnet"
  lb_isinternal = false
  lb_securitygroup = module.securitygroup_publicsub.tp_securitygroup_outputid
  lb_subnets = [module.az1_publicsubnet.subnet_outputid,module.az2_publicsubnet.subnet_outputid]
  lbtarget_vpc_id = module.vpc.tp_output_vpcid
  lb_type = "application"
  lb_listner_port = 80
  lb_target_group_port = 80
  lb_listner_protocol = "HTTP"
  lb_target_group_protocol = "HTTP"

}

module "az1_public_ec2" {
  source = "./instance-m"
  tp_ec2_ami = data.aws_ami.amazon_linux.id
  tp_ec2_instancetype = "t2.micro"
  ec2_subnetid = module.az1_publicsubnet.subnet_outputid
  ec2_securitygroup = [module.securitygroup_publicsub.tp_securitygroup_outputid]
  ec2_associatepublicip = "10.0.0.100/24"
  ec2_name = "AZ1_public_ApacheServer"
  ec2_target_group_arn = module.Alb_publicsubnet.alb_arn_output
  enable_local_exec = true
  enable_remote_exec = true

}

module "az2_public_ec2" {
  source = "./instance-m"
  tp_ec2_ami = data.aws_ami.amazon_linux.id
  tp_ec2_instancetype = "t2.micro"
  ec2_subnetid = module.az2_publicsubnet.subnet_outputid
  ec2_securitygroup = [module.securitygroup_publicsub.tp_securitygroup_outputid]
  ec2_associatepublicip = "10.0.2.100/24"
  ec2_name = "AZ2_public_ApacheServer"
  ec2_target_group_arn = module.Alb_publicsubnet.alb_arn_output
  enable_local_exec = true
  enable_remote_exec = true
}


#########################
#Private Zone
#########################

module "private_routetable" {
  source = "./routingt-m"
  tp_rt_vpcid = module.vpc.tp_output_vpcid
  rt_routes = [ 
    {
        cidr_block = "0.0.0.0/24"
        nat_gateway_id = module.igw.igw_output_id

    }
   ]

   tp_rt_name = "private_routetable"
}


module "associate_privateroutetable_az1" {
    source = "./associatert-m"
    assrt_subnetid = module.az1_privatesubnet.subnet_outputid
    assrt_routetableid = module.private_routetable.tp_routingtable_outputid

}

module "associate_privateroutetable_az2" {
    source = "./associatert-m"
    assrt_subnetid = module.az2_privatesubnet.subnet_outputid
    assrt_routetableid = module.private_routetable.tp_routingtable_outputid

}

module "securitygroup_privatesub" {
  source = "./sg-m"
  sg_name = "private-sg"
  sg_vpcid = module.vpc.tp_output_vpcid

  sg_ingress_rules = [ {
    from_port = 22
    to_port = 22
    protocol = tcp
    cidr_blocks = ["10.0.0.0/24","10.0.2.0/24"]
  }
  ]
}

module "NLB_privatesubnets" {
  source = "./loadbalancer-m"
  lb_name = "Nlb-for-private-subnet"
  lb_isinternal = true
  lb_securitygroup = module.securitygroup_privatesub.tp_securitygroup_outputid
  lb_subnets = [module.az1_privatesubnet.subnet_outputid,module.az2_privatesubnet.subnet_outputid]
  lbtarget_vpc_id = module.vpc.tp_output_vpcid
  lb_type = "network"
  lb_listner_port = 22
  lb_target_group_port = 22
  lb_listner_protocol = "TCP"
  lb_target_group_protocol = "TCP"
}

module "az1_private_ec2" {
  source = "./instance-m"
  tp_ec2_ami = data.aws_ami.amazon_linux.id
  tp_ec2_instancetype = "t2.micro"
  ec2_subnetid = module.az1_pprivatesubnet.subnet_outputid
  ec2_securitygroup = [module.securitygroup_privatesub.tp_securitygroup_outputid]
  ec2_associatepublicip = "10.0.1.100/24"
  ec2_name = "AZ1_private_BackendServer"
  ec2_target_group_arn = module.Alb_privatesubnet.alb_arn_output

}

module "az2_private_ec2" {
  source = "./instance-m"
  tp_ec2_ami = data.aws_ami.amazon_linux.id
  tp_ec2_instancetype = "t2.micro"
  ec2_subnetid = module.az2_privatesubnet.subnet_outputid
  ec2_securitygroup = [module.securitygroup_privatesub.tp_securitygroup_outputid]
  ec2_associatepublicip = "10.0.3.100/24"
  ec2_name = "AZ2_private_BackendServer"
  ec2_target_group_arn = module.Alb_privatesubnet.alb_arn_output
  
}

module "nat_gateway" {
  source = "./natgateway-m"
  nat_subnetid = moduule.az1_publicsubnet.subnet_outputid
}
