### Задание 1:
1. Terraform/docker versions:\
![Terraform/docker](./screenshots/task1.1-version.png)
2. Sensitive data:\
![sensitive](./screenshots/task1.2-secrets.png)
3. Secrets:
![secrets](./screenshots/task1.3-state_file.png)
4. Не было указано имя для ресурса(24 строка), неверное имя ресурса(29 строка) и "name" на (31 строке):
![faile1](./screenshots/task1.4-fail_validate.png)
![faile2](./screenshots/task1.4-fail_validate_1.png)
Исправлено
![fix](./screenshots/task1.4-ok_validate.png)
5. Запуск кода:
![apply](./screenshots/task1.5.png)
6. Замена имени docker контейнера:
![rename](./screenshots/task1.6.png)
Команда "terraform apply -auto-approve" - применяет код без подверждения от пользователя.
>You can pass the -auto-approve option to instruct Terraform to apply the plan without asking for confirmation.
Warning: If you use -auto-approve, we recommend making sure that no one can change your infrastructure outside of your Terraform workflow. This minimizes the risk of unpredictable changes and configuration drift.
[terraform apply -auto-approve](https://developer.hashicorp.com/terraform/cli/commands/apply)
7. Удаление проекта:\
![destroy](./screenshots/task1.7-destroy.png)
8. Образ не удаляется из-за опции "keep_locally=true"
![vscode](./screenshots/task1.8.1-code.png)
![webinfo](./screenshots/task1.8.2-keep_locally.png)

>keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation. [Docker_image](https://registry.terraform.io/providers/cybershard/docker/latest/docs/resources/image)
