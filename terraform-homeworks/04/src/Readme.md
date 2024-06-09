# Решение к домашнему заданию 05

## Задание 1:

- tflint:

1. Модуль использует ветку по умолчанию - main
2. Не указана версия провайдера
3. Объявлены переменные, которые не используются.\
   ![tflint1](./screenshots-05/1.1-tflint.png)

- checkov:

1. CKV_YC_2 - Убедиться, что инстанц не использует публичный IP
2. CKV_YC_11 - Назначить группу безопасности сети
3. CKV_TF_1 - Использовать тэг или хэш коммита для модуля\
   ![ckv1](./screenshots-05/1.2.1-chekov.png)\
   ![ckv2](./screenshots-05/1.2.2-chekov.png)

## Задание 2:

![acl](./screenshots-05/acl.png)\
![backend](./screenshots-05/backend.png)\
![service_acc](./screenshots-05/service_account.png)\
![YDB](./screenshots-05/YDB.png)\
![YDB_table](./screenshots-05/YDB_table.png)\
![tfstate_in_S3](./screenshots-05/tfstate_in_s3.png)\
![lock](./screenshots-05/2.tfstate-lock.png)\
![apply-lock](./screenshots-05/2.tfstate-apply-lock.png)\
![s3](./screenshots-05/2.tfstate-s3.png)\
![s3YDB](./screenshots-05/2.tfstate-s3-YDB.png)\
![unlock](./screenshots-05/2.tfstate-unlock.png)

## Задание 3:

[Pull request](https://github.com/ValentinStupa/homeWorks/pull/1)

## Задание 4:

- Переменные:
  ![ok](./screenshots-05/4.-validate-ok.png)\
  ![error](./screenshots-05/4.-validate-error.png)\
- Один IP:
  ![ip_ok](./screenshots-05/4.-validate-IP-ok.png)\
  ![ip_error](./screenshots-05/4.-validate-IP-error.png)\
- Список IP:
  ![range_ok](./screenshots-05/4.-validate-range-IP-ok.png)\
  ![range_error](./screenshots-05/4.-validate-range-IP-error.png)\
