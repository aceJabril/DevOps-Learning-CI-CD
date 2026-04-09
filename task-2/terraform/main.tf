resource "aws_instance" "cicd" {
  ami                     = var.ami_type
  instance_type           = var.instance_type
  key_name                = var.key_name
  vpc_security_group_ids  = [aws_security_group.cicd-task2-sg.id]

   tags = {
    Name = "cicd-instance-task-2"
  }
}

resource "aws_security_group" "cicd-task2-sg" {
  
ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

ingress {
  from_port   = 5002
  to_port     = 5002
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  }



