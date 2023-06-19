variable "vpc_id" {
  description = "ID of the VPC where the NACL resources will be created."
  type        = string
}

variable "nacl_count" {
  description = "Number of NACL resources to create."
  type        = number
  default     = 1
}

variable "subnets" {
  description = "List of subnet IDs to associate with each NACL resource."
  type        = list(string)
}

variable "nacl_names" {
  description = "List of names for each NACL resource."
  type        = list(string)
}

variable "inbound_rules" {
  description = "List of inbound rules for each NACL resource."
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    rule_action = string
    cidr_block  = string
  }))
}

variable "outbound_rules" {
  description = "List of outbound rules for each NACL resource."
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    rule_action = string
    cidr_block  = string
  }))
}
