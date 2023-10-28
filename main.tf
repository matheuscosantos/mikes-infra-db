provider "aws" {
  region = "us-west-2"
}

resource "aws_db_instance" "database" {
  allocated_storage    = 20
  db_name              = "mikes-db"
  engine               = "postgres"
  engine_version       = "14"
  instance_class       = "db.t2.micro"
  username             = "change-it"
  password             = "change-it"
  skip_final_snapshot  = true
  allow_major_version_upgrade = true
}