variable "aws_region" {
    default = "ap-south-1"
}
variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
 variable "public_subnets" {
    default = ["10.0.1.0/24",
               "10.0.2.0/24"
               ]
 }
 variable "instance_type" {
    default = "t3.micro"
 }
 variable "ami_id" {
   default = "ami-009be0edec0817ffd"
 }