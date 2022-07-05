resource "digitalocean_droplet" "bennetfts" {
  image = "ubuntu-20-04-x64"
  name = "BenNetFTS"
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
resource "digitalocean_volume_attachment" "bennetfts-persist" {
  droplet_id = digitalocean_droplet.bennetfts.id
  volume_id  = data.digitalocean_volume.bennetfts-persist.id
}
#  provisioner "remote-exec" {
#    inline = [
#      "apt update && apt upgrade -y",
#       "apt-get -y install nginx"
#    ]
#  }