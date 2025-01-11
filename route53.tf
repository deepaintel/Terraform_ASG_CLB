data "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "site_domain" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  type    = "A"
  name    = var.record_name

  alias {
    name                   = aws_elb.clbdemo.dns_name
    zone_id                = aws_elb.clbdemo.zone_id
    evaluate_target_health = true
  }
}