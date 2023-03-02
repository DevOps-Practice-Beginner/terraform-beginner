terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.29.4"
    }
  }
}


# Configure the Linode Provider
provider "linode" {
  token = "5fdd0af7ba3be26bb840753dca3bd7fd06ae9e8890d7021870e76efb57dd7520"
  #"E5f8efa7f78e882802caf24b4f7f14e5efa1b211e575269f59d38e542b86012c"
}


# Create a Linode
resource "linode_instance" "web" {
  label  = "simple_instance"
  image  = "linode/ubuntu18.04"
  region = "us-central"
  type   = "g6-standard-2"
  #authorized_keys = ["ssh-rsa ++0ByosgVolvEyg++JD+/+/+9gqmsI/++wmm52Wnl++IcMPae6/+6rxjyGvFGkON//NW8"]
  root_pass = "Terra@123"

}