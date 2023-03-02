resource "aws_instance" "app_server" {
  ami           = "ami-0c4e4b4eb2e11d1d4"
  instance_type = "t3.micro"
  #subnet_id     = "subnet-081e02cfef8d11dff"
  #lifecycle {
   #         prevent_destroy = true
   # }
  tags = {
    Name = "WayneCorp"
  }
}
