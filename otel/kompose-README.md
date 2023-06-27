#

```
kompose convert [file] [flags]

  -c, --chart                    Create a Helm chart for converted objects
      --controller               Set the output controller ("deployment"|"daemonSet"|"replicationController")
      --controller string            Set the output controller ("deployment"|"daemonSet"|"replicationController")
  -o, --out string                   Specify a file name or directory to save objects to (if path does not exist, a file will be created)
      --volumes string               Volumes to be generated ("persistentVolumeClaim"|"emptyDir"|"hostPath" | "configMap") (default "persistentVolumeClaim")
  -f, --file stringArray    Specify an alternative compose file
```

##

```
kompose convert --file ./local/docker-compose.yaml --out ./helm-claim --chart

### var proc commented out
kompose convert --file ./local/docker-compose.yaml --out ./helm-configMap --chart --volumes configMap

kompose convert --file ./local/docker-compose.yaml --out ./helm-hostPath --chart --volumes hostPath

kompose convert --file ./local/docker-compose.yaml \
  --out ./helm-hostPath-daemonSet \
  --chart \
  --volumes hostPath \
  --controller daemonSet
```
