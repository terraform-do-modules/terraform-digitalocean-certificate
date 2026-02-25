# Architecture — terraform-digitalocean-certificate

## Overview

This module provisions a DigitalOcean managed TLS certificate. It supports two certificate types that are selected via the `custom_certificate` flag and the `type` / `certificate_type` variables:

- `lets_encrypt` — DigitalOcean requests and manages a certificate from Let's Encrypt on your behalf.
- `custom` — You supply your own PEM-formatted certificate files (private key, leaf certificate, and certificate chain).

Exactly one of the two underlying resources (`digitalocean_certificate.lets_encrypt` or `digitalocean_certificate.custom`) is created per module invocation, controlled by the `custom_certificate` boolean flag.

## Certificate Types

### Let's Encrypt (`custom_certificate = false`)

DigitalOcean automates the ACME challenge with Let's Encrypt. The `domains` list is passed to the provider, and DigitalOcean handles domain validation and initial issuance.

**Requirements:**

- All domains listed in `domain_names` must be managed by DigitalOcean DNS (i.e., the domain's authoritative name servers must be DigitalOcean's). DigitalOcean uses DNS-01 validation internally.
- The `certificate_type` variable must be `"lets_encrypt"` (the default).

**Renewal:**

Let's Encrypt certificates are valid for 90 days. DigitalOcean automatically renews them before expiration. No manual intervention is required. The certificate `name` remains stable across renewals; the underlying `uuid` and expiry date (`not_after`) will change after a renewal cycle.

### Custom (`custom_certificate = true`)

You supply three PEM files:

| Variable | Description |
|---|---|
| `private_key` | File path to the PEM-formatted private key. |
| `leaf_certificate` | File path to the PEM-formatted public certificate. |
| `certificate_chain` | File path to the PEM-formatted full certificate chain. |

Custom certificates are not automatically renewed. You must upload a new certificate before expiry and update any resources (CDN, Load Balancer) that reference the certificate by name.

## Integration with Other Resources

Certificates are referenced by `name` in resources such as:

- DigitalOcean CDN Endpoints (`certificate_name` input of the `terraform-digitalocean-cdn` module).
- DigitalOcean Load Balancers.

Use the `name` output of this module to wire the certificate into dependent resources.

## Operational Checklist

- Confirm all domains in `domain_names` are delegated to DigitalOcean DNS before applying. Validation will fail otherwise.
- Do not use the same certificate name for Let's Encrypt and custom types across environments; names must be unique within a DigitalOcean account.
- For custom certificates, store PEM files outside of version control and reference them via file paths or a secrets manager.
- Monitor the `not_after` output for custom certificates and schedule renewal ahead of the expiry date.
- When replacing a custom certificate, create a new resource with a new name, update dependent resources, then destroy the old resource. In-place replacement of a certificate is not supported by the DigitalOcean API.
- Set `enabled = false` to disable certificate provisioning without removing the module block from configuration.
