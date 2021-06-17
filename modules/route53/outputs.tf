# Output MyDomain Zone ID
output "mydomain_zoneid" {
  description = "The Hosted Zone id of the desired Hosted Zone"
  value = data.aws_route53_zone.mydomain.zone_id
}

# Output MyDomain name
output "mydomain_name" {
  description = " The Hosted Zone name of the desired Hosted Zone."
  value = data.aws_route53_zone.mydomain.name
}

output "alb_dns_record" {
  description = " The Hosted Zone name of the desired Hosted Zone."
  value = "${aws_route53_record.default_dns.name}"
}

