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
