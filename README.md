Privoxy Docker image for OpenShift and Kubernetes.

Same as https://hub.docker.com/r/gianarb/privoxy/ but this Dockerfile uses USER 1001. This is necessary to run on OpenShift.

Docker instructions:
```
docker run aliok/privoxy
``` 

OpenShift and Kubernetes instructions:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: proxy
  name: proxy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: proxy
  strategy: {}
  template:
    metadata:
      labels:
        app: proxy
    spec:
      containers:
      - image: aliok/privoxy
        name: privoxy
---
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: proxy
  name: proxy
spec:
  ports:
  - nodePort: 30001
    port: 8118
    protocol: TCP
    targetPort: 8118
  selector:
    app: proxy
  type: NodePort
status:
  loadBalancer: {}
```
