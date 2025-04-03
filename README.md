# Terraform-Project
Terraform Project: Secure VPC Architecture with Apache Installation
Overview
This project provisions a secure and scalable infrastructure using Terraform. It includes a Virtual Private Cloud (VPC) with public and private subnets across multiple Availability Zones, EC2 instances for proxy servers and backend web servers, and automated Apache installation. The architecture is based on modular Terraform configurations for reusability and clarity.

Features
VPC with CIDR block 10.0.0.0/16.

Public and private subnets in AZ1 and AZ2.

Proxy Servers in public subnets for handling incoming traffic.

Backend Web Servers in private subnets for secure application hosting.

Internet Gateway for public subnets and NAT Gateway for private subnets.

Security Groups for isolating proxy servers and backend web servers.

Automated provisioning for:

Logging public IPs of instances to all-ips.txt.

Installing Apache or proxy server on EC2 instances.
