output "sg_id" {
  value = aws_security_group.allow_tls.id
}

output "instance_private_ip" {
  value = aws_instance.web[*].private_ip 
}


output "instance_public_ip" {
  value = aws_instance.web[*].public_ip 
}