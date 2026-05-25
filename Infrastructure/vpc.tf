resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags                 = merge(local.common_tags, { Name = "steven-vpc" })
}

# Public Subnet (Internet Connection)
resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = "ap-northeast-2${count.index == 0 ? "a" : "c"}"
  tags              = { Name = "steven-pub-sub-${count.index}" }
}

# Private Subnet (EKS & RDS)
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 10}.0/24"
  availability_zone = "ap-northeast-2${count.index == 0 ? "a" : "c"}"
  tags              = { Name = "steven-pri-sub-${count.index}" }
}