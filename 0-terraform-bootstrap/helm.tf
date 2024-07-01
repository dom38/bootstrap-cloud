resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.3.3"
  create_namespace = true
  namespace = "argocd"

  depends_on = [
    google_container_cluster.primary,
    google_container_node_pool.primary_preemptible_nodes
  ]
}

# resource "kubernetes_manifest" "core-project" {
#   manifest = yamldecode(file("../0-bootstrap/core-project.yaml"))

#   depends_on = [ helm_release.argocd ]
# }

# resource "kubernetes_manifest" "core-application" {
#   manifest = yamldecode(file("../0-bootstrap/core-application.yaml"))

#   depends_on = [ 
#     helm_release.argocd,
#     kubernetes_manifest.core-project
#   ]
# }
