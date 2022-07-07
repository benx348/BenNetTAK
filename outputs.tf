output "ip_address" {
  value = digitalocean_droplet.bennettaky.ipv4_address
  description = "The public IP address of your droplet application."
}
output "domain_output" {
  value = data.digitalocean_domain.domain.zone_file
}
