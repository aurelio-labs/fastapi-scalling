# Get started

- Run local k8s cluster
- Create `fastapi` namespace
- Build the image `make build`
- Apply k8s resource `k apply -f kubernetes/manifests/`
- Install prometheus and apply the helm values from `/helm` instead `/kubernetes`
- Run deployment `make deploy` or `make build_and_deploy`
- Forward port `make kube_forward`
- Load test `make load_test`
- Monitor the scaling

Load test is under `load_test.sh` file

## Install prometheus

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus prometheus-community/prometheus --namespace monitoring

helm install prometheus-adapter prometheus-community/prometheus-adapter --namespace monitoring

helm upgrade prometheus prometheus-community/prometheus --namespace monitoring -f prometheus-values.yaml

helm upgrade prometheus-adapter prometheus-community/prometheus-adapter --namespace monitoring -f prometheus-adapter-values.yaml
```