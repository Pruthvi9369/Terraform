provider "aws" {
  region = "us-east-2"
}

module "DDvpc_dev" {
  source = "../../APPIAAC/Networking/"
  Vpc_provision_region = "us-east-2"
  vpcname = "DD_Test_VPC"
  publicazs = ["us-east-2a", "us-east-2b"]
  dnshostname = true
  publicsubnetcidr = ["10.0.1.0/24", "10.0.2.0/24"]
  publicsubnet_public_ip = true
  privateroutefornatgateway = "0.0.0.0/0,0.0.0.0/1"
  publicNACL_inbound = [
    {
      rule_number = 100
      rule_action = "allow"
      protocol = "all"
      cidr_block = "0.0.0.0/0"
    }
  ]

  publicNACL_outbound = [
      {
        rule_number = 100
        rule_action = "allow"
        protocol = "all"
        cidr_block = "0.0.0.0/0"
      }
  ]
}

module "DD_Dev_RDS_SG" {
  source = "../../APPIAAC/MachineSG/"
  assign_vpc_id = "${module.DDvpc_dev.vpc_id}"
  sg_name = "DD_RDS_SG"
  instance_sg_ingress = [
    {
      from_port = "80"
      to_port = "80"
      protocol = "TCP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port = "3306"
      to_port = "3306"
      protocol = "TCP"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "DD_Database" {
  source = "../../APPIAAC/Databases/"
  rds_region = "us-east-2"
  vpc_name = "DD_Test_VPC"
  database_storage = "20"
  database_max_allocated_storage = "500"
  database_minor_version_upgrade = true
  database_subnet_ids = "${module.DDvpc_dev.vpc_public_subnet_ids}"
  database_engine = "MySQL"
  database_engine_version = "5.7.22"
  database_final_snapshot_identifier = "DD-Database-final-snapshot"
  database_identifier = "dddbidentifier"
  database_instance_class = "db.t2.micro"
  initial_database_name = "DD_DB_Identifier"
  database_master_user_password = "dddbidentifier"
  database_port = "3306"
  database_publicly_accessible = true
  database_storage_type = "gp2"
  database_master_user_name = "dddbidentifier"
  database_vpc_security_group_ids = ["${module.DD_Dev_RDS_SG.sg_id}"]
}
