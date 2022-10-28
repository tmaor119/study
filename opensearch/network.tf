data "aws_vpc" "selected" {
  id = var.vpc_id
}

#private subnet
resource "aws_subnet" "private" {
  vpc_id     = var.vpc_id
  cidr_block = "172.31.64.0/20"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "private_subnet"
  }
}

resource "aws_route_table" "private_subnet_route" {
    vpc_id                  = var.vpc_id
    tags = {
        Name                = "private_subnet_route"
    }
}

resource "aws_route_table_association" "private_subnet_route_association" {
	subnet_id               = "${aws_subnet.private.id}"
	route_table_id          = "${aws_route_table.private_subnet_route.id}"
}