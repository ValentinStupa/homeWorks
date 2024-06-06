resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

module "analytics-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "analytics"
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [yandex_vpc_subnet.develop.id]
  instance_name  = "web"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

# module "marketing-vm" {
#   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
#   env_name       = "marketing"
#   network_id     = yandex_vpc_network.develop.id
#   subnet_zones   = ["ru-central1-a"]
#   subnet_ids     = [yandex_vpc_subnet.develop.id]
#   instance_name  = "web-marketing"
#   instance_count = 1
#   image_family   = "ubuntu-2004-lts"
#   public_ip      = true

#   metadata = {
#     user-data          = data.template_file.cloudinit.rendered
#     serial-port-enable = 1
#   }

# }

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username = var.username
    ssh_pub  = file("~/.ssh/dev_study.pub")
    packages = jsonencode(var.package)
  }
}

module "network" {
  source = "./modules/vpc"

  # env_name = "dev"
  # zone     = "ru-central1-a"
  # cidr     = ["10.0.1.0/24"]
}

