terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

}



resource "aws_instance" "web" {
  ami           = "ami-0c4e4b4eb2e11d1d4"
  instance_type = "t2.micro"
  count = 5
}