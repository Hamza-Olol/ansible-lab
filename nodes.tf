module "node" {
    source      = "./modules/ec2"
    name = "managed-node"
    num_of_instances = 1
    key_name = "ho-nodes"
    ingress_cidr = "188.214.12.0/23"
    associate_public_ip_address = true
    volume_size = 8
}

output "node_private_ip" {
    value = module.node.instance_private_ip
}

output "node_public_ip" {
    value = module.node.instance_public_ip
}
