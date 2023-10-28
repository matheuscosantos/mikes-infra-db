provider "aws" {
  region = "us-west-2"
}

resource "aws_db_instance" "database" {
  allocated_storage    = 20
  db_name              = "mikesdb"
  engine               = "postgres"
  engine_version       = "14"
  instance_class       = "db.t3.micro"
  username             = "changeit"
  password             = "changeit"
  skip_final_snapshot  = true
  allow_major_version_upgrade = true
}