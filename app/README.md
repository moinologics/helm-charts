### How To Deploy an App

1. first of all add repo to helm
   `helm repo add moinologics https://moinologics.github.io/helm-charts`
3. create this dir structure in your repo

```
app-root
└── helm
    ├── values-common.yaml
    └── values-production.yaml
```

3. Now Run

```
helm upgrade --install any-release-name -n namespace moinologics/app \
  -f ./helm/values-production.yaml \
  -f ./helm/values-common.yaml
```
