output "CarSales-VPC-ID" {
   value  = "${aws_vpc.carsales_vpc.id}"
}


output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = ["${aws_subnet.carsales-public-1a.id}","${aws_subnet.carsales-public-1b.id}"]

}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = ["${aws_subnet.carsales-private-1a.id}","${aws_subnet.carsales-private-1b.id}"]

}

