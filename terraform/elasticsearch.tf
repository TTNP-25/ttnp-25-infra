resource "aws_elasticsearch_domain" "ttnp25-elasticsearch" {
    domain_name = "ttnp25"
    elasticsearch_version = "5.1"
    advanced_options {
        "rest.action.multi.allow_explicit_index" = true
    }

    access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Condition": {
                "IpAddress": {"aws:SourceIp": ["66.193.100.22/32"]}
            }
        }
    ]
}
CONFIG

    snapshot_options {
        automated_snapshot_start_hour = 23
    }

    tags {
      Domain = "ttnp25"
    }
}
