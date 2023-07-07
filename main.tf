##----------------------------------------------------------------------------------------------------
#Description : Provides a DigitalOcean Certificate resource that allows you to manage certificates.
##----------------------------------------------------------------------------------------------------
resource "digitalocean_certificate" "custom" {
  count = var.enabled && var.custom_certificate == true ? 1 : 0

  name              = var.certificate_name
  type              = var.type
  private_key       = var.private_key != "" ? file(var.private_key) : null
  leaf_certificate  = var.leaf_certificate != "" ? file(var.leaf_certificate) : null
  certificate_chain = var.certificate_chain != "" ? file(var.certificate_chain) : null
}

##---------------------------------------------------------------------------------------------------
#Description :Provides a DigitalOcean Certificate resource that allows you to manage certificates.
##---------------------------------------------------------------------------------------------------
resource "digitalocean_certificate" "lets_encrypt" {
  count = var.enabled && var.custom_certificate == false ? 1 : 0

  name    = var.certificate_name
  type    = var.certificate_type
  domains = var.domain_names
}
