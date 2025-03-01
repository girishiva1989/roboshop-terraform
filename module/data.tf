data "aws_ami" "centos" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

data "aws_route53_zone" "zone" {
  name = "gdevops89.online"
}

data "aws_security_group" "allow-all"{
  name = "allow-all"
}
