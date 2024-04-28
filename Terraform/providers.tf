# On détermine la version du provider OpenStack à utiliser
terraform {
  required_providers {
    openstack = {
      source = "terraform-providers/openstack"
    }
    vault = {
      source = "hashicorp/vault"
    }
    ovh = {
      source  = "ovh/ovh"
    }
  }
  required_version = ">= 1.0.0"
}

# On demande à Terraform d'utiliser le provider téléchargé à l'instant
provider "openstack" {
  cloud = "siham"
}

provider "vault" {
  # Adresse du serveur Vault et d'autres configurations nécessaires
  address = "https://vault.edu.forestier.re"
  token   = "hvs.CAESICgfkr72ogpYKNqcKnhEG-rkfWUCbLw4rLK-MhpXAHVmGh4KHGh2cy4xTUpUMjF0N2F3bkxiNVA5TW5QRTlxVWw"
  skip_child_token = true
}

data "vault_kv_secret" "ovh_credentials" {
  path = "gitlab/data/public/ovh_credentials"
}
locals {
  # Accès aux données du secret et décodage du JSON dans le champ 'data' j'ai essayé d'y accéder sans parser  mais cela ne fonctionne pas
  # j'ai des erreurs comme Invalid index, je ne comprends pas pourquoi et du coup j'ai décidé de stocker  ces informations dans locals.
  ovh_creds = jsondecode(data.vault_kv_secret.ovh_credentials.data["data"])
}

# Configuration du provider OVH en utilisant les secrets de Vault
provider "ovh" {
  endpoint            = "ovh-eu"
  application_key     = local.ovh_creds.APPLICATION_KEY #data.vault_kv_secret.ovh_credentials.data["data"]["APPLICATION_KEY"]
  application_secret  = local.ovh_creds.APPLICATION_SECRET 
  consumer_key        = local.ovh_creds.CONSUMER_KEY 
}