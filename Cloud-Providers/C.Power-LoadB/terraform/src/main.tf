data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username = var.username
    ssh_pub  = file("~/.ssh/dev_study.pub")
    packages = jsonencode(var.package)
  }
}


resource "yandex_compute_instance_group" "ig-1" {
  name                = "fixed-ig"
  folder_id           = var.folder_id
  service_account_id  = var.cloud_id
  deletion_protection = false
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory        = 1
      cores         = 2
      core_fraction = 5

    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
      }
    }

    network_interface {
      network_id = yandex_vpc_network.network-1.id
      subnet_ids = ["${yandex_vpc_subnet.subnet-1.id}"]
      #security_group_ids = ["<список_идентификаторов_групп_безопасности>"]
    }

    metadata = {
      serial-port-enable = 1
      user-data          = data.template_file.cloudinit.rendered

    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "Целевая группа Network Load Balancer"
  }
}

resource "yandex_lb_network_load_balancer" "lb-1" {
  name = "network-load-balancer-1"

  listener {
    name = "network-load-balancer-1-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.ig-1.load_balancer.0.target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/index.html"
      }
    }
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
