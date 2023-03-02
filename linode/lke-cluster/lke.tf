terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.29.4"
    }
  }
}


# Configure the Linode Provider
provider "linode" {
  token = var.token
}

//Use the linode_lke_cluster resource to create a Kubernetes cluster
resource "linode_lke_cluster" "rp" {
  k8s_version = var.k8s_version
  label       = var.label
  region      = var.region
  tags        = var.tags

  dynamic "pool" {
    for_each = var.pools
    content {
      type  = pool.value["type"]
      count = pool.value["count"]
      autoscaler {
        min = 3
        max = 10
      }
    }

  }
}

//Export this cluster's attributes
output "kubeconfig" {
  value     = linode_lke_cluster.rp.kubeconfig
  sensitive = true
}

output "api_endpoints" {
  value = linode_lke_cluster.rp.api_endpoints
}

output "status" {
  value = linode_lke_cluster.rp.status
}

output "id" {
  value = linode_lke_cluster.rp.id
}

output "pool" {
  value = linode_lke_cluster.rp.pool
}
    