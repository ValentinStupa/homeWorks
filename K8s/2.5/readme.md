# Решение к домашнему заданию: "Helm"
```
helm create netDev-chart
helm template dev-chart . -f values-dev.yml
helm install netdev-chart . -f values-dev.yml
helm install netdev-chart . -f values-dev.yml -n app1
helm list
helm list -n app1
helm history netdev-chart
helm history netdev-chart -n app1
```
- [Template deployment](./netDev-chart/templates/deployment_nginx.yml)
- [Variables dev](./netDev-chart/values-dev.yml)
- [Variables prod](./netDev-chart/values-prod.yml)
---
Namespace -- app1\
![app1](./screenshots/revision-2.png)\
Helm Upgrade -- app1\
![upgade](./screenshots/revision-2.png)\
Namespace -- app2\
![app2](./screenshots/revision-1-app2.png)
