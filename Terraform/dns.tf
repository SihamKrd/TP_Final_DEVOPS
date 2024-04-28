# Configuration des enregistrements DNS pour chaque sous-domaine
resource "ovh_domain_zone_record" "nextcloud_record" {
  zone        = var.domain_name
  subdomain   = "cloud.${var.prenom}"
  fieldtype   = "A"
  ttl         = 3600
  target      = openstack_networking_floatingip_v2.floatip_1.address
}

resource "ovh_domain_zone_record" "wordpress_record" {
  zone        = var.domain_name
  subdomain   = "blog.${var.prenom}"
  fieldtype   = "A"
  ttl         = 3600
  target      = openstack_networking_floatingip_v2.floatip_1.address
}

resource "ovh_domain_zone_record" "project_record" {
  zone        = var.domain_name
  subdomain   = "projet.${var.prenom}"
  fieldtype   = "A"
  ttl         = 3600
  target      = openstack_networking_floatingip_v2.floatip_1.address
}
