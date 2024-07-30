#there is a inter dependency between the blocks, R53 is created if resource is create
# and resource is created if provisioner is created and provisioner is not created because R53 is not created
# to avoid this provisioner is placed in null_resource
#In this approach first resource will be created and then both null resource and R53 will run in parallel, but this also wrong
#But my requirement is first resource should be created, then R53 and then null resource should be created
#To avoid this we should use depends_on, here it will wait for mentioned resource to get created and then null resource will be created
output "ami_id" {
  value = data.aws_ami.centos.image_id
}

resource "aws_instance" "instances" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]

  tags = {
    Name = var.components_name
  }
}

resource "null_resource" "null" {

  depends_on = [aws_instance.instances,aws_route53_record.instance]

  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instances.private_ip
    }

    inline = [
      "rm -rf roboshop-shell-second",
      "git clone https://github.com/girishiva1989/roboshop-shell-second.git",
      "cd roboshop-shell-second",
      "sudo bash ${var.components_name}.sh ${var.password}"
    ]
  }
}


resource "aws_route53_record" "instance" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "${var.components_name}-dev.gdevops89.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.instances.private_ip]
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
