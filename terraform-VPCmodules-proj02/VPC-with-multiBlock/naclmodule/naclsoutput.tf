output "nacl_ids" {
  description = "List of IDs of the created NACL resources."
  value       = aws_network_acl.nacl[*].id
}
