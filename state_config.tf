terraform {
  backend "s3" {
    bucket = "bia-terraform-2025"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
