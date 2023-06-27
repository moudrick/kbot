#

##

```
helm lint     ./otel/helm
helm template ./otel/helm
helm package  ./otel/helm
```

```
kubectl apply -f ./otel/helm/templates -n otel-monitoring

helm list --all --all-namespaces

k delete namespace otel-monitoring
k create namespace otel-monitoring
helm install otel ./otel-0.0.1.tgz -n otel-monitoring
helm upgrade otel ./otel-0.0.11.tgz -n otel-monitoring
```