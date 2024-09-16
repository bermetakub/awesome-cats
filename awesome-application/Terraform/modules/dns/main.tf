# Create a DNS Managed Zone
resource "google_dns_managed_zone" "primary" {
  name        = var.dns_zone_name
  dns_name    = var.dns_name
  description = "Managed zone for ${var.dns_name}"

  visibility = "public"
}

# # External DNS Deployment
# resource "helm_release" "external_dns" {
#   name       = "external-dns"
#   namespace  = "kube-system"
#   chart      = "external-dns"
#   repository = "https://kubernetes-sigs.github.io/external-dns/"
#   version    = "1.12.0"

#   values = [
#     <<EOF
# replicaCount: 1

# image:
#   repository: k8s.gcr.io/external-dns/external-dns
#   tag: v0.10.1

# serviceAccount:
#   create: true
#   name: external-dns

# sources: 
#   - service
#   - ingress

# provider: google

# google:
#   project: "${var.project_id}"
#   domainFilters:
#     - "${google_dns_managed_zone.primary.dns_name}"

# extraArgs:
#   - --google-project="${var.project_id}"

# extraVolumes: 
#   - name: gcp-credentials
#     secret: 
#       secretName: external-dns-gcp-credentials #Specifies the name of the Kubernetes Secret containing Google Cloud credentials

# extraVolumeMounts: 
#   - name: gcp-credentials
#     mountPath: /etc/kubernetes/gcp 
#     readOnly: true 
 
# env:
#   - name: GOOGLE_APPLICATION_CREDENTIALS
#     value: /etc/kubernetes/gcp/key.json
# EOF
#   ]
# }

# # Cert-Manager Deployment
# resource "helm_release" "cert_manager" {
#   name       = "cert-manager"
#   namespace  = "cert-manager"
#   chart      = "cert-manager"
#   repository = "https://charts.jetstack.io"
#   version    = "v1.10.0"

#   values = [
#     <<EOF
# installCRDs: true
# EOF
#   ]
# }

# Optional: Let’s Encrypt ClusterIssuer
# resource "kubernetes_manifest" "letsencrypt_issuer" {
#   manifest = {
#     apiVersion = "cert-manager.io/v1"
#     kind       = "ClusterIssuer"
#     metadata = {
#       name = "letsencrypt-prod"
#     }
#     spec = {
#       acme = {
#         server      = "https://acme-v02.api.letsencrypt.org/directory"
#         email       = "bermetalymkulova55@gmail.com"
#         privateKeySecretRef = {
#           name = "letsencrypt-prod"
#         }
#         solvers = [
#           {
#             http01 = {
#               ingress = {
#                 class = "nginx"
#               }
#             }
#           }
#         ]
#       }
#     }
#   }
# }
