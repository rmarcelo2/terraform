provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "marcelo-bucket-000001111122222333334444455555666666"
  acl    = "private"

  tags = {
    Name       = "Bucket Marcelo"
    Enviroment = "Dev"
    Manageby   = "Terraform"
  }
}