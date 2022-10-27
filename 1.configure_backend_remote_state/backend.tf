terraform {
  backend "s3" {
    bucket         = "tfremotetest"
    region         = "us-east-1"
    key            = "backend.tfstate"
    dynamodb_table = "tfstatelock"
  }
}
