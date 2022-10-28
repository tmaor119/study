#proxy
resource "aws_security_group" "proxy" {
    name = "${var.aos_domain_name}-opensearch-proxy"
    vpc_id = var.vpc_id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = var.proxy_inbound_cidr_blocks
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group_rule" "proxy_inbound_user" {
  security_group_id = aws_security_group.proxy.id
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

#opensearch
resource "aws_security_group" "opensearch" {
    name = "${var.aos_domain_name}-opensearch-domain"
    vpc_id = var.vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group_rule" "opensearch" {
  security_group_id = aws_security_group.opensearch.id

  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["${aws_subnet.private.cidr_block}"]
}

resource "aws_security_group_rule" "opensearch_proxy" {
    security_group_id = aws_security_group.opensearch.id

    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    source_security_group_id = aws_security_group.proxy.id
}