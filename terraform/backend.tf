terraform {
  backend "s3" {
    bucket = "jegankumard-ekssupermario"
    key    = "EKS/terraform.tfstate"
    region = "us-east-1"
  }
}
