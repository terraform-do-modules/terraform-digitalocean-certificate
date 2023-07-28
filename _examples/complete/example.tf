provider "digitalocean" {}

##------------------------------------------------
## custom_certificate module call
##------------------------------------------------
module "custom_certificate" {
  source             = "./../../"
  custom_certificate = true
  certificate_name   = "test"
  private_key        = "./../../private_key.pem" ## Path of the PEM-formatted private key file corresponding to the SSL certificate.
  leaf_certificate   = "./../../cert.pem"        ## Path of the contents of a PEM-formatted public TLS certificate file.
  certificate_chain  = "./../../fullchain.pem"   ## Path of the PEM-formatted fullchain.pem file.
}
