# Inputs and Outputs — terraform-digitalocean-certificate

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enabled | Flag to control the resources creation. | `bool` | `true` | no |
| custom\_certificate | A boolean flag to enable/disable custom certificate. Set to `true` to provision a custom certificate; `false` (default) provisions a Let's Encrypt certificate. | `bool` | `false` | no |
| certificate\_name | The name of the certificate for identification. Must be unique within the DigitalOcean account. | `string` | `""` | no |
| type | The type of certificate to provision for the custom certificate resource. Must be one of: `custom`, `lets_encrypt`. | `string` | `"custom"` | no |
| certificate\_type | The type of certificate to provision for the Let's Encrypt certificate resource. | `string` | `"lets_encrypt"` | no |
| domain\_names | List of fully qualified domain names (FQDNs) for which the certificate will be issued. The domains must be managed using DigitalOcean's DNS. Only valid when `custom_certificate = false`. | `list(any)` | `[]` | no |
| private\_key | File path to the PEM-formatted private key corresponding to the SSL certificate. Only used when `custom_certificate = true`. | `string` | `""` | no |
| leaf\_certificate | File path to the PEM-formatted public TLS certificate. Only used when `custom_certificate = true`. | `string` | `""` | no |
| certificate\_chain | File path to the PEM-formatted full certificate chain. Only used when `custom_certificate = true`. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The unique ID of the certificate. |
| name | The name of the certificate. |
| not\_after | The expiration date of the certificate. |
| sha1\_fingerprint | The SHA-1 fingerprint of the certificate. |
| uuid | The UUID of the certificate. |
