# AWS provider setting 
provider "aws" {
  region = "ap-northeast-2" # region seoul
}

# tags
locals {
  common_tags = {
    Project     = "SimpleStatus"
    Owner       = "Steven"
    Environment = "Dev"
  }
}