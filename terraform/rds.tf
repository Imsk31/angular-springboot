resource "aws_security_group" "rds-sg" {
  name_prefix = "MariaDB-"
  ingress {
    from_port   = 0
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "angular-java-project-rds" {
  engine                 = var.rds_engine
  db_name                = var.db-name
  identifier             = var.db-name
  instance_class         = var.rds_instance_class
  allocated_storage      = 20
  publicly_accessible    = true
  multi_az               = true
  username               = var.rds_username
  password               = var.rds_password
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  skip_final_snapshot    = true

  tags = {
    Name = "springbackend-rds-db-angular-java-project"
  }
}