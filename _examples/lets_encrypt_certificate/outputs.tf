output "id" {
  value       = module.lets_encrypt_certificate[*].id
  description = "The unique ID of the certificate."
}
output "not_after" {
  value       = module.lets_encrypt_certificate[*].not_after
  description = "The unique ID of the certificate."
}
