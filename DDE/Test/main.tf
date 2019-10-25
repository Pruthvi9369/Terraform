provider "aws" {
  region = "us-east-2"
}

module "DDvpc" {
  source = "../../APPIAAC/Networking/"
  Vpc_provision_region = "us-east-2"
  vpcname = "DD_Test_VPC"
  publicazs = ["us-east-2a", "us-east-2b"]
  dnshostname = true
  publicsubnetcidr = ["10.0.1.0/24", "10.0.2.0/24"]
  privateroutefornatgateway = "0.0.0.0/0,0.0.0.0/1"
  publicNACL_inbound = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port = "80"
      to_port = "80"
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    },
    {
      rule_number = 101
      rule_action = "allow"
      from_port = "3306"
      to_port = "3306"
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    }
  ]

  publicNACL_outbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_block = "0.0.0.0/0"
      },
      {
        rule_number = 101
        rule_action = "allow"
        from_port = "3306"
        to_port = "3306"
        protocol = "tcp"
        cidr_block = "0.0.0.0/0"
      }
  ]
}

module "DD_Instance_SG" {
  source = "../../APPIAAC/MachineSG/"
  sg_name = "DD_Instance_SG"
  assign_vpc_id = "${module.DDvpc.vpc_id}"
}

module "DD_Instance" {
  source = "../../APPIAAC/Machines/"

  instance_name = "DD_Test_Instance"
  instanceregion = "us-east-2"
  instance_ami = "ami-00c03f7f7f2ec15c3"
  instance_subnet = "${element(module.DDvpc.vpc_public_subnet_ids,0)}"
  auto_instance_public_ip = "true"
  instance_vpc_sg_ids = ["${module.DD_Instance_SG.sg_id}"]
  instance_keyname = "linux_ohio"
}

module "DD_Object_storage" {
  source = "../../APPIAAC/ObjectStorage/"

  bucketname = "123456789-dd-bucket"
  bucket_region = "us-east-2"
}

module "DD_RDS_SG" {
  source = "../../APPIAAC/MachineSG/"
  assign_vpc_id = "${module.DDvpc.vpc_id}"
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
  database_subnet_ids = "${module.DDvpc.vpc_public_subnet_ids}"
  database_engine = "MySQL"
  database_engine_version = "5.7.22"
  database_final_snapshot_identifier = "DD-Database-final-snapshot"
  database_identifier = "dddbidentifier"
  database_instance_class = "db.t2.micro"
  initial_database_name = "DD_DB_Identifier"
  database_master_user_password = "DDDBIdentifier"
  database_port = "3306"
  database_publicly_accessible = true
  database_storage_type = "gp2"
  database_master_user_name = "DDDBIdentifier"
  database_vpc_security_group_ids = ["${module.DD_RDS_SG.sg_id}"]
}

module "DD_Object_storage_test" {
  source = "../../APPIAAC/ObjectStorage/"

  bucketname = "123456789-dd-bucket-test"
  bucket_region = "us-east-2"
}

module "DD_Instance_1" {
  source = "../../APPIAAC/Machines/"

  instance_name = "DD_Test_Instance_1"
  instanceregion = "us-east-2"
  #availability_zone = "us-east-2b"
  instance_ami = "ami-00c03f7f7f2ec15c3"
  instance_subnet = "${element(module.DDvpc.vpc_public_subnet_ids,1)}"
  auto_instance_public_ip = "true"
  instance_vpc_sg_ids = ["${module.DD_Instance_SG.sg_id}"]
  instance_keyname = "linux_ohio"
}
