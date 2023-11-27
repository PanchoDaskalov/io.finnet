##S3-Cloudfront
module "iofinnet" {
  source              = "../../s3-cloudfront-dev"
  environment         = "dev"
  name                = "iofinnet-devops"
  default_root_object = "index.html"
}