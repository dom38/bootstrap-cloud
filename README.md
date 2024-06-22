# Bootstrap-Cloud

A disorganised repo that will create minimal GKE clusters using Crossplane then deploy applications on them using ArgoCD (After some manual configuration)

Requirements:

- A Kubernetes Cluster (Kind, Minikube, GKE, EKS).
- A GCP account.
- A GCP service account for Crossplane to use.
- ArgoCD CLI

Steps:

1. Change the projectID value to your project in [the value file](charts/crossplane-providers/values.yaml) or overwrite it.
1. From the root of the repo and with the correct kubernetes context, run `bootstrap/bootstrap.sh`. This will install ArgoCD and set up an initial project and applications.
1. Create a secret in the `crossplane-system` namespace that contains the base64 encoded json from your GCP service account. This should look like this: 
```
apiVersion: v1
kind: Secret
metadata:
  name: gcp-provider-secret
data:
  credentials: |
    (Your base64 encoded json here)
```
1. Add some clusters in [the core values file](core/values.yaml), these will be created by Crossplane.

At this point, Crossplane will pass the cluster credentials back to the ArgoCD namespace as secrets, however they are missing some information and the clusters themselves are missing permissions. This could be automated, however here are the instructions to manually import them for now:

1. Port-forward the ArgoCD server to your local machine, unless you have access via an ingress
1. Login using your credentials, or the admin credentials `argocd login {The address}`
1. Fetch the contexts of the deployed clusters from the gcloud console using `gcloud container clusters get-credentials {Cluster name} --region {region}`
1. Add each context using `argocd add cluster {context name}`
1. Enable clusterApplications in [the core values file](core/values.yaml) and ArgoCD will deploy applications on your new GCP clusters.

NOTE: The context names are usually quite long
