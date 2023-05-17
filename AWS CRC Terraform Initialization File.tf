terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "S3Bucket" {
    bucket = "bdavisawsresume.link"
}

resource "aws_s3_bucket" "S3Bucket2" {
    bucket = "www.bdavisawsresume.link"
}

resource "aws_s3_bucket_policy" "S3BucketPolicy" {
    bucket = "bdavisawsresume.link"
    policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Sid\":\"AllowPublicRead\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":\"s3:GetObject\",\"Resource\":\"arn:aws:s3:::bdavisawsresume.link/*\"}]}"
}

resource "aws_s3_bucket_policy" "S3BucketPolicy2" {
    bucket = "www.bdavisawsresume.link"
    policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Sid\":\"PublicReadGetObject\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":\"s3:GetObject\",\"Resource\":\"arn:aws:s3:::www.bdavisawsresume.link/*\"}]}"
}

resource "aws_lambda_function" "LambdaFunction" {
    description = ""
    function_name = "VisitorCounterAPI"
    handler = "lambda_function.lambda_handler"
    architectures = [
        "x86_64"
    ]
    s3_bucket = "prod-04-2014-tasks"
    s3_key = "/snapshots/606997302812/VisitorCounterAPI-0ade7f65-8759-45d2-b7c7-fcc45be5d599"
    s3_object_version = "LV1oh0qNRTHss00.R6eYHqX5VrvdggMY"
    memory_size = 128
    role = "arn:aws:iam::606997302812:role/service-role/VisitorCounterAPI-role-fqc7x4pi"
    runtime = "python3.9"
    timeout = 3
    tracing_config {
        mode = "PassThrough"
    }
}

resource "aws_lambda_permission" "LambdaPermission" {
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.LambdaFunction.arn}"
    principal = "apigateway.amazonaws.com"
    source_arn = "arn:aws:execute-api:us-east-1:606997302812:3kgi0zz7gj/*/GET/"
}

resource "aws_lambda_permission" "LambdaPermission2" {
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.LambdaFunction.arn}"
    principal = "apigateway.amazonaws.com"
    source_arn = "arn:aws:execute-api:us-east-1:606997302812:tp224zoeok/*/GET/"
}

resource "aws_lambda_permission" "LambdaPermission3" {
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.LambdaFunction.arn}"
    principal = "apigateway.amazonaws.com"
    source_arn = "arn:aws:execute-api:us-east-1:606997302812:3kgi0zz7gj/*/GET/"
}

resource "aws_lambda_permission" "LambdaPermission4" {
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.LambdaFunction.arn}"
    principal = "apigateway.amazonaws.com"
    source_arn = "arn:aws:execute-api:us-east-1:606997302812:3kgi0zz7gj/*/POST/"
}

resource "aws_lambda_permission" "LambdaPermission5" {
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.LambdaFunction.arn}"
    principal = "apigateway.amazonaws.com"
    source_arn = "arn:aws:execute-api:us-east-1:606997302812:3kgi0zz7gj/*/OPTIONS/"
}

resource "aws_lambda_permission" "LambdaPermission6" {
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.LambdaFunction.arn}"
    principal = "apigateway.amazonaws.com"
    source_arn = "arn:aws:execute-api:us-east-1:606997302812:3kgi0zz7gj/*/*/VisitorCounterAPI"
}

resource "aws_dynamodb_table" "DynamoDBTable" {
    attribute {
        name = "WebsiteVisits"
        type = "S"
    }
    name = "VisitorCounter"
    hash_key = "WebsiteVisits"
    read_capacity = 1
    write_capacity = 1
}

resource "aws_cloudfront_distribution" "CloudFrontDistribution" {
    aliases = [
        "bdavisawsresume.link",
        "www.bdavisawsresume.link"
    ]
    origin {
        custom_origin_config {
            http_port = 80
            https_port = 443
            origin_keepalive_timeout = 15
            origin_protocol_policy = "http-only"
            origin_read_timeout = 60
            origin_ssl_protocols = [
                "TLSv1.2"
            ]
        }
        domain_name = "bdavisawsresume.link.s3-website-us-east-1.amazonaws.com"
        origin_id = "bdavisawsresume.link.s3.us-east-1.amazonaws.com"
        
        origin_path = ""
    }
    default_cache_behavior {
        allowed_methods = [
            "HEAD",
            "DELETE",
            "POST",
            "GET",
            "OPTIONS",
            "PUT",
            "PATCH"
        ]
        cached_methods   = ["HEAD", "GET"]
        compress = false
        smooth_streaming  = false
        target_origin_id = "bdavisawsresume.link.s3.us-east-1.amazonaws.com"
        viewer_protocol_policy = "https-only"
    }
    comment = ""
    price_class = "PriceClass_All"
    enabled = true
    viewer_certificate {
        acm_certificate_arn = "arn:aws:acm:us-east-1:606997302812:certificate/9d25171c-0b23-42a6-9ff7-43781f558d03"
        cloudfront_default_certificate = false
        minimum_protocol_version = "TLSv1.2_2021"
        ssl_support_method = "sni-only"
    }
    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }
    http_version = "http2and3"
    is_ipv6_enabled = false
}

resource "aws_route53_zone" "Route53HostedZone" {
    name = "bdavisawsresume.link."
}

resource "aws_route53_record" "Route53RecordSet" {
    name = "bdavisawsresume.link."
    type = "A"
    alias {
        name = "d3gj2jt63jkpo6.cloudfront.net."
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
    zone_id = "Z02439581WWGOU9XWNRUC"
}

resource "aws_route53_record" "Route53RecordSet2" {
    name = "bdavisawsresume.link."
    type = "NS"
    ttl = 172800
    records = [
        "ns-443.awsdns-55.com.",
        "ns-1450.awsdns-53.org.",
        "ns-1846.awsdns-38.co.uk.",
        "ns-1014.awsdns-62.net."
    ]
    zone_id = "Z02439581WWGOU9XWNRUC"
}

resource "aws_route53_record" "Route53RecordSet3" {
    name = "bdavisawsresume.link."
    type = "SOA"
    ttl = 900
    records = [
        "ns-443.awsdns-55.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
    ]
    zone_id = "Z02439581WWGOU9XWNRUC"
}

resource "aws_route53_record" "Route53RecordSet4" {
    name = "_cb31b662b029242718bc0359324eee97.bdavisawsresume.link."
    type = "CNAME"
    ttl = 300
    records = [
        "_8a173c1a41e2a9823db46171adf7d32f.yzdtlljtvc.acm-validations.aws."
    ]
    zone_id = "Z02439581WWGOU9XWNRUC"
}

resource "aws_route53_record" "Route53RecordSet5" {
    name = "www.bdavisawsresume.link."
    type = "A"
    alias {
        name = "d3gj2jt63jkpo6.cloudfront.net."
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
    zone_id = "Z02439581WWGOU9XWNRUC"
}

resource "aws_route53_record" "Route53RecordSet6" {
    name = "_ab70973604270b6137c09e1477a38222.www.bdavisawsresume.link."
    type = "CNAME"
    ttl = 300
    records = [
        "_703785457d5440529b1916f59c98733d.kqlycvwlbp.acm-validations.aws."
    ]
    zone_id = "Z02439581WWGOU9XWNRUC"
}

resource "aws_iam_user" "IAMUser" {
    path = "/"
    name = "Brian_Davis"
    tags = {
        Boss = "Brian D"
    }
}
