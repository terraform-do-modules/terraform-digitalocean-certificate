provider "digitalocean" {}

##------------------------------------------------
## lets_encrypt certificate module call
##------------------------------------------------
module "lets_encrypt_certificate" {
  source           = "./../../"
  certificate_name = "test"
  domain_names     = ["clouddrove.ca"]
}