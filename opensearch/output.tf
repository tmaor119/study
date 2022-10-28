    output "test" {
      value = "${aws_subnet.private.cidr_block}"
    }

    output "test1" {
      value = "${aws_elasticsearch_domain.aos.endpoint}"
    }