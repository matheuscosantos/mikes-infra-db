variable "region" {
    type    = string
    default = "us-east-2"
}

variable "states_file" {
    type    = string
    default = "mikes-db.tfstate"
}

variable "states_bucket" {
    type     = string
    default  = "mikes-terraform-state"
}

variable "states_bucket_encrypt" {
    type     = boolean
    default  = "true"
}

variable "aws_db_subnet_group_name" {
    type     = string
    default  = "mikes-db-subnet-group-v3"
}

variable "subnet_ids" {
  type    = list(string)
  default = [
    "subnet-02fade20759ea9048",
    "subnet-0476b7fa27309a259",
    "subnet-01da20e70684fdc33",
  ]
}

variable "db_identifier" {
    type = string
    default = "mikes-db"
}

variable "db_allocated_storage" {
    type = integer
    default = 20
}

variable "db_name" {
    type = string
    default = "mikesdb"
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = [
    "sg-098c8756d60c43c2d",
  ]
}
variable "db_credentials_arn" {
    type = string
    default = "arn:aws:secretsmanager:us-east-2:644237782704:secret:mikes/db/db_credentials-6wQzyQ"

}
