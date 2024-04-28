data "openstack_images_image_v2" "deb"{
    name = "Official-debian-11"
    tags = ["latest"]
}

resource "openstack_compute_instance_v2" "instance"{
    name            = "instance-1"
    image_id        = data.openstack_images_image_v2.deb.id
    flavor_name       = "v4.m8.d20"
    security_groups = ["default"]

    network {
      name = openstack_networking_network_v2.network.name
    }
    user_data = file("./conf.yaml")
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_networking_floatingip_v2.floatip_1.address
  instance_id = openstack_compute_instance_v2.instance.id
}

resource "openstack_compute_volume_attach_v2" "va_1" {
  instance_id = openstack_compute_instance_v2.instance.id
  volume_id   = openstack_blockstorage_volume_v3.volume_1.id
}
