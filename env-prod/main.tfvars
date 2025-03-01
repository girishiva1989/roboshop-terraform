components = {
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
    password      = "RoboShop@1"
  }
  shipping = {
    name          = "shipping"
    instance_type = "t3.small"
    password      = "RoboShop@1"
  }
  rabbitmq = {
    name          = "rabbitmq"
    instance_type = "t3.small"
    password      = "roboshop123"
  }
  payment = {
    name          = "payment"
    instance_type = "t3.small"
    password      = "roboshop123"
  }
}

env = "prod"