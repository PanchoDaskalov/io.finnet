provider "aws" {
  region  = "eu-west-1"
  default_tags {
    tags = {
      devops-exercise = "io.finnet"
    }
  }
}