#Install prometheus

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus prometheus-community/prometheus --namespace monitoring --create-namespace

# This is installed directly via deployment
helm install prometheus-adapter prometheus-community/prometheus-adapter --namespace monitoring

helm upgrade prometheus prometheus-community/prometheus --namespace monitoring -f prometheus-values.yaml

```