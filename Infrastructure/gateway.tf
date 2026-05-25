# 1. Internet gateway (VPC main gate)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(local.common_tags, { Name = "steven-igw" })
}

# 2. Stable IP (NAT Gateway)
resource "aws_eip" "nat" {
  domain = "vpc"
  tags   = merge(local.common_tags, { Name = "steven-nat-eip" })
}

# 3. NAT Gateway (Outbound path)
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  tags          = merge(local.common_tags, { Name = "steven-nat-gw" })

  # IGW is first
  depends_on = [aws_internet_gateway.igw]
}