resource "aws_subnet" "Public1AZA" {   # Create public subnet 1 to Specific AZ
  vpc_id = "${aws_vpc.terraformmain.id}"
  cidr_block = "${var.Subnet-Public1-AzA-CIDR}"
  tags {
        Name = "Public1AZA"
  }
 availability_zone = "${data.aws_availability_zones.available.names[0]}"
 }
 
 resource "aws_subnet" "Public2AZA" {   # Create public subnet 2 to Specific AZ
  vpc_id = "${aws_vpc.terraformmain.id}"
  cidr_block = "${var.Subnet-Public2-AzA-CIDR}"
  tags {
        Name = "Public2AZA"
  }
 availability_zone = "${data.aws_availability_zones.available.names[1]}"
}

resource "aws_route_table_association" "Public_Assoc" {  # Associate Public Subnet 1 to Public Route Table
    subnet_id = "${aws_subnet.Public1AZA.id}"
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "Public1_Assoc" {   # Associate Public Subnet 2 to Public Route Table
    subnet_id = "${aws_subnet.Public2AZA.id}"
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_subnet" "Private1AZA" {   # Create private subnet 1 to Specific AZ
  vpc_id = "${aws_vpc.terraformmain.id}"
  cidr_block = "${var.Subnet-Private1-AzA-CIDR}"
  tags {
        Name = "Private1AZA"
  }
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
}

resource "aws_subnet" "Private2AZA" {   # Create private subnet 2 to Specific AZ
  vpc_id = "${aws_vpc.terraformmain.id}"
  cidr_block = "${var.Subnet-Private2-AzA-CIDR}"
  tags {
        Name = "Private2AZA"
  }
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
}


resource "aws_route_table_association" "Private_Assoc" { # Associate Private Subnet 1 to Private Route Table
    subnet_id = "${aws_subnet.Private1AZA.id}"
    route_table_id = "${aws_route_table.private.id}"
}


resource "aws_route_table_association" "private1_assoc" { # Associate Private Subnet 2 to Private1 Route Table
  subnet_id = "${aws_subnet.Private2AZA.id}"
  route_table_id = "${aws_route_table.private1.id}"
}