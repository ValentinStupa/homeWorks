# Создание группы безопасности

resource "yandex_vpc_security_group" "nat-instance-sg" {
  name       = local.sg_nat_name
  network_id = yandex_vpc_network.develop.id

  # Любой исходящий страфик
  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Любой входящий трафик
  ingress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  # Ниже указанные правила блокируют выход в интернет!!!

  # ingress {
  #   protocol       = "TCP"
  #   description    = "ssh"
  #   v4_cidr_blocks = ["0.0.0.0/0"]
  #   port           = 22
  # }

  # ingress {
  #   protocol       = "TCP"
  #   description    = "ext-http"
  #   v4_cidr_blocks = ["0.0.0.0/0"]
  #   port           = 80
  # }

  # ingress {
  #   protocol       = "TCP"
  #   description    = "ext-https"
  #   v4_cidr_blocks = ["0.0.0.0/0"]
  #   port           = 443
  # }
}
