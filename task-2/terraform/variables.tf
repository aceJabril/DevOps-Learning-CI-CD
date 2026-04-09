variable "ami_type" {
    description = "ami type variable"
    type = string
    default = "ami-09dbc7ce74870d573"
}

variable "instance_type" {
    description = "instance type variable"
    type = string
    default = "t3.micro"
}

variable "key_name" {
    description = "key pair variable"
    type = string
    default = "jabz.uk"
}

