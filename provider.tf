terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.21.0"
    }
  }
}

variable "do_token" {default = "Digital_Ocean_AccessKey"}
variable "private_key" {default = "SSH_Private_Key"}
variable "cloud_config" {default = "cloud-config.yml"}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = "DigitalOceanLinux"
}
data "digitalocean_volume_snapshot" "snapshot" {
  name  = "bennettaky-volume-snapshot"
  region      = "nyc1"
  most_recent = true
}
data "digitalocean_domain" "domain" {
  name = "Digital_Ocean_Domain"
}
#data "digitalocean_volume" "bennetfts-persist" {
#  name   = "bennetfts-persist"
#  region = "nyc1"
#}

