variable "region" {
  default = "us-east-1" # Mention the region 
}
variable "AmiLinux" {
  default = {
    us-east-1 = "ami-55ef662f" # N Virginia AMI ID
    us-east-2 = "ami-2452275e" # N Virginia AMI ID
  }
  description = "I add only 1 region (Virginia) to show the feature"
}

variable "aws_access_key" {
  default = "XXXXXXXXXXXXXXXXXXXXXXXX" # Access Key of the user what you created
  description = "the user aws access key"
}

variable "aws_secret_key" {
  default = "XXXXXXXXX" # Secret Key of the user what you created
  description = "the user aws secret key"
}

variable "vpc-fullcidr" {
    default = "172.28.0.0/16"
  description = "the vpc cdir"
}
variable "Subnet-Public1-AzA-CIDR" {
  default = "172.28.0.0/24"
  description = "the cidr of the private subnet"
}
variable "Subnet-Public2-AzA-CIDR" {
  default = "172.28.1.0/24"
  description = "the cidr of the private subnet"
}
variable "Subnet-Private1-AzA-CIDR" {
  default = "172.28.3.0/24"
  description = "the cidr of the public subnet"
}
variable "Subnet-Private2-AzA-CIDR" {
  default = "172.28.4.0/24"
  description = "the cidr of the public subnet"
}
variable "key_name" {
  default = "vpc-peering"
  description = "the ssh key to use in the EC2 machines"
}
variable "elb_healthy_threshold" {
  default = "2"
  description = "Define the Healthy threshold value"
}
variable "elb_unhealthy_threshold" {
  default = "2"
  description = "Define the Unhealthy threshold value"
}
variable "elb_timeout" {
  default = "3"
  description = "Define the Timeout value"
}
variable "elb_interval" {
  default = "30"
  description = "Define the Interval value"
}
variable "asg_max" {
  default = "2"
  description = "Define the ASG Max Time value"
}
variable "asg_min" {
  default = "1"
  description = "Define the ASG Min Time value"
}
variable "asg_grace" {
  default = "300"
  description = "Define the ASG grace Time value"
}
variable "asg_hct" {
  default = "EC2"
  description = "Define the ASG HCT Time value"
}
variable "asg_cap" {
  default = "2"
  description = "Define the ASG CAP Time value"
}
variable "lc_instance_type" {
  default = "t2.micro"
  description = "Define the ASG Instance Type value"
}
