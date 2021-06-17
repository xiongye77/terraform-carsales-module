output "alb_url_addr" {
  value       =  "${module.alb.alb_dns_name}"
  description = "The ALB load balancer URL"
}	


output "alb_dns_addr" {
  value       =  "${module.route53.alb_dns_record}"
  description = "The ALB DNS Name "
}

