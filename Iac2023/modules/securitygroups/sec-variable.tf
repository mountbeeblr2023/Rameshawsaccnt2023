#### variables for private Security Group #######
variable private_sec_ingress_port {
  type        = list(number)
  default     = [80, 443, 8080, 22]
  description = "list of ingress port"
}

variable public_sec_ingress_port {
  type        = list(number)
  default     = [80, 443, 8080, 22]
  description = "list of ingress port"
}
