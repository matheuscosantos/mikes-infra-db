variable "region" {
    type    = string
    default = "us-east-2"
}

variable "aws_db_subnet_group_name" {
    type     = string
    default  = "mikes-db-subnet-group-v4"
}

variable "subnet_ids" {
  type    = list(string)
  default = [
    "subnet-0bf429bd21d7c0dfb"
  ]
}

variable "db_identifier" {
    type = string
    default = "mikes-db"
}

variable "db_allocated_storage" {
    type = number
    default = 20
}

variable "db_name" {
    type = string
    default = "mikesdb"
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = [
    "sg-0b54a118ef1d3a749",
  ]
}
variable "db_credentials_arn" {
    type = string
    default = "arn:aws:secretsmanager:us-east-2:644237782704:secret:mikes/db/db_credentials-6wQzyQ"

}



