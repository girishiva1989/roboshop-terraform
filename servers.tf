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

variable "components" {
  default = {
    frontend = {
      name          = "frontend"
      instance_type = "t3.small"
    }
    mongod = {
      name          = "mongod"
      instance_type = "t3.small"
    }
    catalogue = {
      name          = "catalogue"
      instance_type = "t3.small"
    }
    redis = {
      name          = "redis"
      instance_type = "t3.small"
    }
    user = {
      name          = "user"
      instance_type = "t3.small"
    }
    cart = {
      name          = "cart"
      instance_type = "t3.small"
    }
    mysql = {
      name          = "mysql"
      instance_type = "t3.small"
    }
    shipping = {
      name          = "shipping"
      instance_type = "t3.small"
    }
    rabbitmq = {
      name          = "rabbitmq"
      instance_type = "t3.small"
    }
    payment = {
      name          = "payment"
      instance_type = "t3.small"
    }
  }
}

resource "aws_instance" "instances" {
  for_each      = var.components
  ami           = data.aws_ami.centos.image_id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]

  tags = {
    Name = each.value["name"]
  }
}

output "instance" {
  value = [for i in aws_instance.instances : i.public_ip]
}

resource "aws_route53_record" "instance" {
  for_each = var.components
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "${each.value["name"]}-dev.gdevops89.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.instances[each.value["name"]].private_ip]
}


# variable "components" {
#   default = ["frontend","mongod","catalogue","redis","user","cart","mysql","shipping","rabbitmq",
#   "payment"]
# }
#
# resource "aws_instance" "instances" {
#   #count         = length(var.components)
#   for_each      = toset(var.components)
#   ami           = data.aws_ami.centos.image_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#
#   tags = {
#     #Name = var.components[count.index]
#     Name = each.key
#   }
# }
#
# output "instance" {
#   value = [for i in aws_instance.instances : i.public_ip]
# }

# resource "aws_route53_record" "instance" {
#   zone_id = data.aws_route53_zone.zone.zone_id
#   name    = "frontend-dev.gdevops89.online"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.instances.private_ip]
# }
