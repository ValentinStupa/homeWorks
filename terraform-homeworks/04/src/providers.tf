terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"

  backend "s3" {
    bucket   = "s3--tfstate"
    endpoint = "storage.yandexcloud.net"
    key      = "terraform.tfstate"
    region   = "ru-central1"

    dynamodb_table    = "tfstate-lock"  #таблица блокировок
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gth1tvcjpc968p7dh9/etnhcvbvi6i7vhtv758m" # можно получить при создании таблицы

    skip_region_validation      = true
    skip_credentials_validation = true
  }


}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
