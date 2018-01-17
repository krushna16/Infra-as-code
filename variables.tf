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
  default = "XXXXXXXXXXXXXXXXXX" # Access Key of the user what you created
  description = "the user aws access key"
}

variable "aws_secret_key" {
  default = "XXXXXXXXXXXXXXXXXXXXX" # Secret Key of the user what you created
  description = "the user aws secret key"
}

/* # This option also we can try to export the Keys to local machines
variable "credentials" {
  default = "/home/krushna/.aws/credentials" #replace your home directory
  description = "where your access and secret_key are stored, you create the file when you run the aws config"
}
*/
variable "vpc-fullcidr" {
    default = "172.28.0.0/16"
  description = "the vpc cdir"
}
variable "Subnet-Public-AzA-CIDR" {
  default = "172.28.0.0/24"
  description = "the cidr of the private subnet"
}
variable "Subnet-Private-AzA-CIDR" {
  default = "172.28.3.0/24"
  description = "the cidr of the public subnet"
}
variable "key_name" {
  default = "vpc-peering"
  description = "the ssh key to use in the EC2 machines"
}
