provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA3KCJVLCVPBTWCJPC"
  secret_key = "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"
  #export below keys from commandline
  #export AWS_ACCESS_KEY_ID="anaccesskey"
  #export AWS_SECRET_ACCESS_KEY="asecretkey"
}

# Security Group
variable "ingressrules" {
  type    = list(number)
  default = [8080, 22, 80]
}
resource "aws_security_group" "web_traffic" {
  name        = "Allow web traffic"
  description = "inbound ports for ssh and standard http and everything outbound"
  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Terraform" = "true"
    Name        = "Jenkins"
  }
}


resource "aws_instance" "Jenkins" {
  ami             = "ami-09d3b3274b6c5d4aa" # us-west-2 : Linux:ami-09d3b3274b6c5d4aa ubuntu:ami-08c40ec9ead489470
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.web_traffic.name]
  key_name        = "terraform"
  tags = {
    Name = "Jenkins"
  }
  provisioner "remote-exec" {
    inline = [
      #"wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",
      #"sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      #"sudo apt update -qq",
      #"sudo apt install -y default-jre",
      #"sudo apt install -y jenkins",
      #"sudo systemctl start jenkins"
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum upgrade -y",
      "sudo amazon-linux-extras install java-openjdk11 -y",
      "sudo yum install jenkins -y",
      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins",
      "sudo systemctl status jenkins",
      "echo =================================InitialAdminPassword==================================",
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user" #ubuntu ec2-user
    agent       = true
    private_key = file("./terraform.pem")
  }

}

output "ec2_global_ips" {
  value = aws_instance.Jenkins.*.public_ip
}