resource "aws_network_acl" "nacl" {
  count = var.nacl_count

  vpc_id   = var.vpc_id
  subnet_association {
    subnet_id = var.subnets[count.index]
  }

  tags = {
    Name = var.nacl_names[count.index]
  }

  dynamic "ingress" {
    for_each = var.inbound_rules[count.index]
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      rule_action = ingress.value.rule_action
      cidr_block  = ingress.value.cidr_block
      rule_number = ingress.key + 100  # Assuming rule number starts from 100
    }
  }

  dynamic "egress" {
    for_each = var.outbound_rules[count.index]
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      rule_action = egress.value.rule_action
      cidr_block  = egress.value.cidr_block
      rule_number = egress.key + 100  # Assuming rule number starts from 100
    }
  }
}
