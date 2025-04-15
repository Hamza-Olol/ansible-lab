variable "ingress_cidr" {
    type = string
    description = "CIDR block for ingress security group rules" 
}

variable "num_of_instances" {
    type = number
}

variable "key_name" {
    type = string
}

variable "name" {
    type = string
}

variable "associate_public_ip_address" {
    type = bool
    default = false
}

variable "volume_size" {
    type = number
}

variable "master_node_sg_id" {
    type = string
    default = null
}