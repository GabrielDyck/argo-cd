# argo-hello-world


### Argo Core-Concepts

https://argoproj.github.io/argo-cd/core_concepts/

### Argo Getting Started

https://argoproj.github.io/argo-cd/getting_started/

### Argo Blue Green Deployment

https://argoproj.github.io/argo-rollouts/features/bluegreen.html


### Argo Analysis

https://argoproj.github.io/argo-rollouts/features/analysis.html#analysis-progressive-delivery

### Argo-UI:
```shell
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
#### Get UI Password:
```shell
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo
```

### Argo Private Repository

https://argoproj.github.io/argo-cd/user-guide/private-repositories/

#### Install kubeseal 

https://aws.amazon.com/es/blogs/opensource/managing-secrets-deployment-in-kubernetes-using-sealed-secrets/

#### Kubeseal Repo

https://github.com/bitnami-labs/sealed-secrets