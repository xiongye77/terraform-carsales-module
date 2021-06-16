output "ALB-SG" {
   value  = "${aws_security_group.carsales_alb_sg.id}"
}

output "alb_dns_name" {
   value = "${aws_lb.carsales_alb.dns_name}"
}

output "alb_dns_zone_id" {
   value = "${aws_lb.carsales_alb.zone_id}"
}

output "alb_carsales-back-end-tg-1" {
   value = "${aws_lb_target_group.carsales-back-end-tg-1}"

}

output "alb_carsales-back-end-tg-2" {
   value = "${aws_lb_target_group.carsales-back-end-tg-2}"

}


