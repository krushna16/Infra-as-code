# Declare the data source
data "aws_availability_zones" "available" {}

/* EXTERNAL NETWORG , IG, ROUTE TABLE */
resource "aws_internet_gateway" "gw" {
   vpc_id = "${aws_vpc.terraformmain.id}"
    tags {
        Name = "internet gw terraform generated"
    }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.terraformmain.id}"
  tags {
      Name = "public"
  }
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.terraformmain.id}"
  tags {
      Name = "private"
  }
  route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.Public1AZA.id}"
  }
}
resource "aws_eip" "forNat" {
    vpc      = true
}

resource "aws_route_table" "private1" {
  vpc_id = "${aws_vpc.terraformmain.id}"
  tags {
      Name = "private1"
  }
  route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.Public2AZA.id}"
  }
}
resource "aws_eip" "forNat1" {
    vpc      = true
}
resource "aws_nat_gateway" "Public1AZA" {
    allocation_id = "${aws_eip.forNat.id}"
    subnet_id = "${aws_subnet.Public1AZA.id}"
    depends_on = ["aws_internet_gateway.gw"]
}


resource "aws_nat_gateway" "Public2AZA" {
    allocation_id = "${aws_eip.forNat1.id}"
    subnet_id = "${aws_subnet.Public2AZA.id}"
    depends_on = ["aws_internet_gateway.gw"]
}