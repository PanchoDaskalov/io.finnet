##S3-Cloudfront
module "iofinnet" {
  source              = "../../s3-cloudfront-prod"
  environment         = "prod"
  name                = "iofinnet-devops"
  default_root_object = "index.html"
}