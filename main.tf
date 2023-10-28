provider "aws" {
  region = "us-east-2"
}

resource "aws_iam_policy" "secrets_manager_policy" {
  name        = "secrets-manager-policy"
  description = "Policy for AWS Secrets Manager"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetRandomPassword",
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret",
                "secretsmanager:ListSecretVersionIds"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "secrets_manager_role" {
  name = "secrets-manager-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "rds.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "secrets_manager_attachment" {
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
  roles      = [aws_iam_role.secrets_manager_role.name]
}

resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = ["subnet-08b040edf682e0f26", "subnet-08b040edf682e0f26", "subnet-0926c91b917672f40"]
}

resource "aws_db_instance" "mikes_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.6"
  instance_class       = "db.t2.micro"
  name                 = "mikes-db"
  parameter_group_name = "default.postgres12"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.mikes.id]
  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name
  iam_database_authentication_enabled = true
}

resource "aws_security_group" "mikes" {
  name_prefix = "sg-"
  
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Aberto para o mundo; ajuste conforme necessário
  }
}

data "aws_secretsmanager_secret" "db_credentials" {
  name = "db-credentials" # Substitua pelo nome do seu segredo no Secrets Manager
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = data.aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = "change-it",
    password = "change-it"
  })
}