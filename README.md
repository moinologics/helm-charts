## How To add new chart

1. create new folder in same level as **app** now add your helm chart in it
2. run `helm lint new-dir`
3. run `helm package new-dir`
4. step 3 will generate a .gz file, add this in git push as well
5. run `helm repo index --url https://moinologics.github.io/helm-charts --merge index.yaml .`
6. add new-dir in git, commit & push


refernce - https://medium.com/@mattiaperi/create-a-public-helm-chart-repository-with-github-pages-49b180dbb417
