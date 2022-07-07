resource "digitalocean_droplet" "bennettaky" {
  image = "ubuntu-20-04-x64"
  name = "BenNetTAKY"
  region = "nyc1"
  size = "s-1vcpu-1gb"
  user_data = "${file("${var.cloud_config}")}"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = "${file("${var.private_key}")}"            
    timeout = "2m"
  }
}  
resource "digitalocean_record" "bennettaky-dns" {
  domain = data.digitalocean_domain.domain.id
  type   = "A"
  name   = "tak"
  ttl    =  "60"
  value  = "${digitalocean_droplet.bennettaky.ipv4_address}"
}
resource "digitalocean_volume" "bennettaky-volume" {
  region      = "nyc1"
  name        = "bennettaky-volume"
  size        = 1
  snapshot_id = data.digitalocean_volume_snapshot.snapshot.id
}
resource "digitalocean_volume_attachment" "volume-attach" {
  droplet_id = digitalocean_droplet.bennettaky.id
  volume_id  = digitalocean_volume.bennettaky-volume.id
}
