# create database subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "${var.project_name}-${var.environment}-database-subnets"
  subnet_ids  = [var.private_data_subnet_az1_id, var.private_data_subnet_az2_id]
  description = "subnets for database instance"

  tags = {
    Name = "${var.project_name}-${var.environment}-database-subnets"
  }
}

# get information about a database snapshot
#data "aws_db_snapshot" "latest_db_snapshot" {
 # db_snapshot_identifier = 
  #most_recent            = 
  #snapshot_type          = 
#}

# launch an rds instance from a database snapshot
# instance_class         = 
 # skip_final_snapshot    = 
  #availability_zone      = 
  #identifier             = 
  #snapshot_identifier    = 
  #db_subnet_group_name   = 
  #multi_az               = 
  #vpc_security_group_ids = 
#}

resource "aws_db_instance" "db_instance" {
  engine                 = "mysql"
  engine_version         = "8.0.31"
  multi_az               = false
  identifier             = "dev-rds-instance"
  instance_class         = db.t2.micro
  allocated_storage      = 200
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [var.database_security_group_id]
  availability_zone      = "us-east-1b"
  db_name                = "applicationdb"
  username               = "laurenj"
  password               = "test0042"
  skip_final_snapshot    = true

/*resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = var.dbengine
  engine_version       = var.e_version
  instance_class       = var.i_class
  db_name              = var.dbname
  username             = var.usrname
  password             = var.pword
  parameter_group_name = var.pg_name
  skip_final_snapshot  = var.skipfs */
}