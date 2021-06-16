resource "aws_route53_record" "default_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id 
  name    = "myapps-test.aconex.design"
  type    = "A"
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_dns_zone_id
    evaluate_target_health = true
  }  
}
