output "ami_id" {
  value = data.aws_ami.centos.image_id
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

resource "null_resource" "null" {

  depends_on = [aws_instance.instances,aws_route53_record.instance]
  for_each      = var.components

  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instances[each.value["name"]].private_ip
    }

    inline = [
      "git clone https://github.com/girishiva1989/roboshop-shell-second.git",
      "cd roboshop-shell-second",
      "sudo bash ${each.value["name"]}.sh",
    ]
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
