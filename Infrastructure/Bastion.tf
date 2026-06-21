# 1. Security Group for Bastion Host
resource "aws_security_group" "bastion_sg" {
  name        = "3tier-bastion-sg"
  description = "Allow SSH traffic to Bastion Host"
  vpc_id      = aws_vpc.main.id # Map to your existing VPC resource ID

  # Inbound Rule: Restrict SSH access (Port 22) for security hardening
  ingress {
    description = "SSH from Administrator IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Note: Opened to anywhere (0.0.0.0/0) for testing. 
    # Production best practice: Restrict to "Your-Public-IP/32"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Outbound Rule: Allow all traffic to communicate with internal resources (e.g., EKS Worker Nodes)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "3tier-bastion-sg"
  }
}

# 2. Bastion Host EC2 Instance deployed in the Public Subnet
resource "aws_instance" "bastion" {
  # Standard AMI ID for Amazon Linux 2023 (Verify the latest AMI ID for your target region)
  ami                         = "ami-0c9c942bd7bf113a2" 
  instance_type               = "t3.micro"               # Cost-effective instance type eligible for AWS Free Tier
  subnet_id                   = aws_subnet.public_1.id   # Must be deployed within a 'Public Subnet'
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  key_name                    = "steven-ssh-key"         # Your existing AWS EC2 Key Pair name

  # Automatically assign a public IP address to allow external inbound access
  associate_public_ip_address = true

  # Root Volume Configuration
  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "3tier-bastion-host"
  }
}