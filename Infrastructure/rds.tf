# 1. Create RDS Security group
resource "aws_security_group" "rds_sg" {
  name        = "status-db-sg"
  description = "Allow EKS nodes to access RDS"
  vpc_id      = aws_vpc.main.id 

  # Inbound rule : 3306 port is allowed from the EKS nodes' security group
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_eks_cluster.status_eks.vpc_config[0].cluster_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "status-db-sg"
  }
}

# 2. DB subnet group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "main-rds-subnet-group"
  subnet_ids = aws_subnet.private[*].id 

  tags = {
    Name = "Steven DB subnet group"
  }
}

# 3. RDS MySQL Instance
resource "aws_db_instance" "status_db" {
  allocated_storage     = 20
  max_allocated_storage = 100
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.micro" # freetier
  db_name               = "status_db"
  username              = "admin"
  #password              = "[Type new password]" # password
  parameter_group_name  = "default.mysql8.0"
  skip_final_snapshot   = true
  multi_az               = true

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "steven-status-db"
  }
}
