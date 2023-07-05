
output "id" {
  value       = module.custom_certificate[*].id
  description = "The unique ID of the certificate."
}
