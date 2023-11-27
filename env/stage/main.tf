##S3-Cloudfront
module "iofinnet" {
  source              = "../../s3-cloudfront-stage"
  environment         = "stage"
  name                = "iofinnet-devops"
  default_root_object = "index.html"
} 
