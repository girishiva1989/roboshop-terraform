data "aws_ami" "centos" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

output "ami_id" {
  value = data.aws_ami.centos.image_id
}

data "aws_route53_zone" "zone" {
  name = "gdevops89.online"
}


data "aws_security_group" "allow-all"{
  name = "allow-all"
}

variable "instance_type" {
  default = "t3.small"
}

variable "components" {
  default = ["frontend","mongod","catalogue","redis","user","cart","mysql","shipping","rabbitmq",
  "payment"]
}

resource "aws_instance" "instances" {
  #count         = length(var.components)
  for_each = toset(var.components)
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]

  tags = {
    #Name = var.components[count.index]
    Name = each.key
  }
}

output "instance" {
  value = aws_instance.instances.public_ip
}
#
# resource "aws_route53_record" "instance" {
#   zone_id = data.aws_route53_zone.zone.zone_id
#   name    = "frontend-dev.gdevops89.online"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.instances.private_ip]
# }


# resource "aws_instance" "catalogue" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#
#   tags = {
#     Name = "catalogue"
#   }
# }
#
# resource "aws_route53_record" "catalogue" {
#   zone_id = "Z014155316GQK32DIY108"
#   name    = "catalogue-dev.gdevops89.online"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.frontend.private_ip]
# }
#
# resource "aws_instance" "mongod" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#
#   tags = {
#     Name = "mongod"
#   }
# }
#
# resource "aws_route53_record" "mongod" {
#   zone_id = "Z014155316GQK32DIY108"
#   name    = "mongod-dev.gdevops89.online"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.frontend.private_ip]
# }
#
# resource "aws_instance" "redis" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#
#   tags = {
#     Name = "redis"
#   }
# }
#
# resource "aws_route53_record" "redis" {
#   zone_id = "Z014155316GQK32DIY108"
#   name    = "redis-dev.gdevops89.online"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.frontend.private_ip]
# }
#
# resource "aws_instance" "user" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#
#   tags = {
#     Name = "user"
#   }
# }
#
# resource "aws_route53_record" "user" {
#   zone_id = "Z014155316GQK32DIY108"
#   name    = "user-dev.gdevops89.online"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.frontend.private_ip]
# }
#
# resource "aws_instance" "cart" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#
#   tags = {
#     Name = "cart"
#   }
# }
#
# resource "aws_route53_record" "cart" {
#   zone_id = "Z014155316GQK32DIY108"
#   name    = "cart-dev.gdevops89.online"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.frontend.private_ip]
# }
#
# resource "aws_instance" "mysql" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#
#   tags = {
#     Name = "mysql"
#   }
# }
#
# resource "aws_route53_record" "mysql" {
#   zone_id = "Z014155316GQK32DIY108"
#   name    = "mysql-dev.gdevops89.online"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.frontend.private_ip]
# }
#
# resource "aws_instance" "shipping" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#
#   tags = {
#     Name = "shipping"
#   }
# }
#
# resource "aws_route53_record" "shipping" {
#   zone_id = "Z014155316GQK32DIY108"
#   name    = "shipping-dev.gdevops89.online"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.frontend.private_ip]
# }
#
# resource "aws_instance" "rabbitmq" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = "t3.small"
#
#   tags = {
#     Name = var.instance_type
#   }
# }
#
# resource "aws_route53_record" "rabbitmq" {
#   zone_id = "Z014155316GQK32DIY108"
#   name    = "rabbitmq-dev.gdevops89.online"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.frontend.private_ip]
# }
#
# resource "aws_instance" "payment" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#
#   tags = {
#     Name = "Payment"
#   }
# }
#
# resource "aws_route53_record" "payment" {
#   zone_id = "Z014155316GQK32DIY108"
#   name    = "payment-dev.gdevops89.online"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.frontend.private_ip]
#}