data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "allow_tls" {
  name        = "${var.name}"
  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.ingress_cidr
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "self" {
  security_group_id = aws_security_group.allow_tls.id
  referenced_security_group_id = aws_security_group.allow_tls.id
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "example" {
  security_group_id = aws_security_group.allow_tls.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

# master node
resource "aws_vpc_security_group_ingress_rule" "master_node" {
  count = var.master_node_sg_id != null ? 1 : 0
  security_group_id = aws_security_group.allow_tls.id
  referenced_security_group_id = var.master_node_sg_id
  ip_protocol       = "-1"
}

resource "aws_instance" "web" {
  count = var.num_of_instances
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = var.key_name
  security_groups = [aws_security_group.allow_tls.name]

  associate_public_ip_address = var.associate_public_ip_address
  root_block_device {
    volume_size = var.volume_size
  }
  tags = {
    Name = "${var.name}-node-${count.index}"
  }
}