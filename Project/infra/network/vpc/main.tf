resource "aws_vpc" "project01_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    instance_tenancy = "default"

    tags = {
            Name = "project01_vpc"
    }
}

resource "aws_subnet" "project01_public_subnet2a" {
        vpc_id = aws_vpc.project01_vpc.id
        cidr_block = var.public_subnet[0]
        availability_zone = var.azs[0]

    tags = {
        Name = "project01_public_subnet2a"
    }
}

resource "aws_subnet" "project01_public_subnet2c" {
        vpc_id = aws_vpc.project01_vpc.id
        cidr_block = var.public_subnet[1]
        availability_zone = var.azs[1]

    tags = {
        Name = "project01_public_subnet2c"
    }
}

resource "aws_subnet" "project01_private_subnet2a" {
        vpc_id = aws_vpc.project01_vpc.id
        cidr_block = var.private_subnet[0]
        availability_zone = var.azs[0]

    tags = {
        Name = "project01_private_subnet2a"
    }
}

resource "aws_subnet" "project01_private_subnet2c" {
        vpc_id = aws_vpc.project01_vpc.id
        cidr_block = var.private_subnet[1]
        availability_zone = var.azs[1]
    
    tags = {
        Name = "project01_private_subnet2c"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "project01_igw" {
    vpc_id = aws_vpc.project01_vpc.id

    tags = {
        Name = "project01_igw"
    }
}

resource "aws_eip" "project01_eip" {
    vpc = true
    depends_on = [aws_internet_gateway.project01_igw]
    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "project01_eip"
    }
}

resource "aws_nat_gateway" "project01_nat" {
    allocation_id = aws_eip.project01_eip.id
    subnet_id     = aws_subnet.project01_public_subnet2a.id
    depends_on    = [aws_internet_gateway.project01_igw]

    tags = {
        Name = "project01_nat"
    }
}

resource "aws_default_route_table" "project01_public_rt" {
        default_route_table_id = aws_vpc.project01_vpc.default_route_table_id

        route {
                cidr_block = "0.0.0.0/0"
                gateway_id = aws_internet_gateway.project01_igw.id
        }
    tags = {
        Name = "project01_public_route_table"
    }
}

resource "aws_route_table_association" "project01_public_rta_2a" { 
        subnet_id               = aws_subnet.project01_public_subnet2a.id
        route_table_id          = aws_default_route_table.project01_public_rt.id
}

resource "aws_route_table_association" "project01_public_rta_2c" {
        subnet_id               = aws_subnet.project01_public_subnet2c.id
        route_table_id = aws_default_route_table.project01_public_rt.id
}

resource "aws_route_table" "project01_private_rt01" {
	vpc_id = aws_vpc.project01_vpc.id
	tags   = {
		Name = "project01_private_route_table01"
	}
}

resource "aws_route" "project01_private_rt_table01" {
        route_table_id = aws_route_table.project01_private_rt01.id
        destination_cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.project01_nat.id
}

resource "aws_route_table_association" "project01_private_rta_2a" { 
        subnet_id      = aws_subnet.project01_private_subnet2a.id
        route_table_id = aws_route_table.project01_private_rt01.id
}

resource "aws_route_table" "project01_private_rt02" {
	vpc_id = aws_vpc.project01_vpc.id
	tags   = {
		Name = "project01_private_route_table02"
	}
}

resource "aws_route" "project01_private_rt_table02" {
        route_table_id = aws_route_table.project01_private_rt02.id
        destination_cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.project01_nat.id
}

resource "aws_route_table_association" "project01_private_rta_2c" { 
        subnet_id      = aws_subnet.project01_private_subnet2c.id
        route_table_id = aws_route_table.project01_private_rt02.id
}
