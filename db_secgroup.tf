resource "aws_security_group" "RDS_secgroup" {
  name        = "RDS_secgroup"
  description = "Access port 80 and 3306"
  vpc_id      = aws_vpc.admin_vpc.id

  tags = {
    Name = "RDS security group"
  }

  
  ingress {
    description = "HTTP proxy access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from any IP address
  }


  ingress {
   description = "mySQL/aurora access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH traffic from any IP address
  }

  egress {
    description = "allow all outbound access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

}