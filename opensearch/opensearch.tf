resource "aws_elasticsearch_domain" "aos" {
    domain_name = var.aos_domain_name
    elasticsearch_version = var.opensearch_version

    cluster_config {
      instance_count = var.aos_data_instance_count
      instance_type = var.aos_data_instance_type
    }

    ebs_options {
      ebs_enabled = true
      volume_size = var.aos_data_instance_storage
    }

    vpc_options {
      subnet_ids = ["${aws_subnet.private.id}"]
      security_group_ids = ["${aws_security_group.opensearch.id}"]
    }

    advanced_security_options {
      enabled = false
      # internal_user_database_enabled = true
      # master_user_options {
      #   master_user_name = "tmaor119"
      #   master_user_password = "Tkdb79==!"
      # } 
    }

    encrypt_at_rest {
      enabled = true
    }

    node_to_node_encryption {
      enabled = true
    }

    domain_endpoint_options {
      enforce_https = true
      tls_security_policy = "Policy-Min-TLS-1-0-2019-07"
    }

  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "es:*",
      "Principal": "*",
      "Effect": "Allow",
      "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.aos_domain_name}/*"
    }
  ]
}
POLICY
}