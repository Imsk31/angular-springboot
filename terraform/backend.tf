terraform {
  backend "s3" {
    bucket = "31101999"
    key    = "31101999/terraform_statefile/terraform.tfstate"
    region = "us-east-1"
  }
}

