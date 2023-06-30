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

2023-06-27T10:40:57.117Z error HelmRelease/otel.otel-monitoring - Reconciler error Helm upgrade failed: cannot patch "loki" with kind Service: The order in patch list:
[map[name:9093-ruler-alertmanager-url port:3100] map[name:3100 port:3100 targetPort:3100] map[name:9096-grpc-listen-port port:9096 targetPort:9096]]
 doesn't match $setElementOrder list:
[map[port:3100] map[port:9096] map[port:3100]]