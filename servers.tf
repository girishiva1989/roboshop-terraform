data "aws_ami" "centos" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}

output "ami_id" {
  value = data.aws_ami.centos.image_id
}

resource "aws_instance" "frontend" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.small"

  tags = {
    Name = "frontend"
  }
}

output "frontend" {
  value = aws_instance.frontend.public_ip
}

resource "aws_route53_record" "frontend" {
  zone_id = Z014155316GQK32DIY108
  name    = "frontend-dev.gdevops89.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.private_ip]
}


resource "aws_instance" "catalogue" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.small"

  tags = {
    Name = "catalogue"
  }
}

resource "aws_route53_record" "catalogue" {
  zone_id = Z014155316GQK32DIY108
  name    = "catalogue-dev.gdevops89.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "mongod" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.small"

  tags = {
    Name = "mongod"
  }
}

resource "aws_route53_record" "mongod" {
  zone_id = Z014155316GQK32DIY108
  name    = "mongod-dev.gdevops89.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "redis" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.small"

  tags = {
    Name = "redis"
  }
}

resource "aws_route53_record" "redis" {
  zone_id = Z014155316GQK32DIY108
  name    = "redis-dev.gdevops89.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "user" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.small"

  tags = {
    Name = "user"
  }
}

resource "aws_route53_record" "user" {
  zone_id = Z014155316GQK32DIY108
  name    = "user-dev.gdevops89.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "cart" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.small"

  tags = {
    Name = "cart"
  }
}

resource "aws_route53_record" "cart" {
  zone_id = Z014155316GQK32DIY108
  name    = "mongod-dev.gdevops89.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "mysql" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.small"

  tags = {
    Name = "mysql"
  }
}

resource "aws_route53_record" "mysql" {
  zone_id = Z014155316GQK32DIY108
  name    = "mysql-dev.gdevops89.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "shipping" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.small"

  tags = {
    Name = "shipping"
  }
}

resource "aws_route53_record" "shipping" {
  zone_id = Z014155316GQK32DIY108
  name    = "shipping-dev.gdevops89.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "rabbitmq" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.small"

  tags = {
    Name = "rabbitmq"
  }
}

resource "aws_route53_record" "rabbitmq" {
  zone_id = Z014155316GQK32DIY108
  name    = "rabbitmq-dev.gdevops89.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "payment" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.small"

  tags = {
    Name = "Payment"
  }
}

resource "aws_route53_record" "payment" {
  zone_id = Z014155316GQK32DIY108
  name    = "payment-dev.gdevops89.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.private_ip]
}