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

resource "aws_iam_user" "IAMUser" {
    path = "/"
    name = "Brian_Davis"
    tags = {
        Boss = "Brian D"
    }
}

resource "aws_iam_user" "IAMUser2" {
    path = "/"
    name = "Former2"
    tags = {
        "REPLACEME" = "Terraform" #Former2 access key 
        Terraform Config = "Former2"
    }
}

resource "aws_iam_role" "IAMRole" {
    path = "/service-role/"
    name = "AmazonAppStreamPCAAccess"
    assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"prod.euc.ecm.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
    max_session_duration = 3600
    tags = {}
}

resource "aws_iam_role" "IAMRole2" {
    path = "/service-role/"
    name = "AmazonAppStreamServiceAccess"
    assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"appstream.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
    max_session_duration = 3600
    tags = {}
}

resource "aws_iam_role" "IAMRole3" {
    path = "/service-role/"
    name = "ApplicationAutoScalingForAmazonAppStreamAccess"
    assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"application-autoscaling.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
    max_session_duration = 3600
    tags = {}
}

resource "aws_iam_role" "IAMRole4" {
    path = "/service-role/"
    name = "VisitorCounterAPI-role-fqc7x4pi"
    assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
    max_session_duration = 3600
    tags = {}
}

resource "aws_iam_service_linked_role" "IAMServiceLinkedRole" {
    aws_service_name = "dynamodb.application-autoscaling.amazonaws.com"
}

resource "aws_iam_service_linked_role" "IAMServiceLinkedRole2" {
    aws_service_name = "ops.apigateway.amazonaws.com"
    description = "The Service Linked Role is used by Amazon API Gateway."
}

resource "aws_iam_policy" "IAMManagedPolicy" {
    name = "AWSLambdaBasicExecutionRole-1b383ca4-38c6-4a3b-9e13-dc2c632f0d19"
    path = "/service-role/"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:us-east-1:606997302812:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:us-east-1:606997302812:log-group:/aws/lambda/VisitorCounterAPI:*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy" "IAMManagedPolicy2" {
    name = "Lambda_RW_FULL"
    path = "/"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "lambda:CreateFunction",
                "lambda:GetLayerVersion",
                "lambda:PublishLayerVersion",
                "lambda:DeleteProvisionedConcurrencyConfig",
                "lambda:InvokeAsync",
                "lambda:GetAccountSettings",
                "lambda:GetFunctionConfiguration",
                "lambda:CreateEventSourceMapping",
                "lambda:GetLayerVersionPolicy",
                "lambda:PutFunctionConcurrency",
                "lambda:DeleteCodeSigningConfig",
                "lambda:GetProvisionedConcurrencyConfig",
                "lambda:ListTags",
                "lambda:DeleteLayerVersion",
                "lambda:PutFunctionEventInvokeConfig",
                "lambda:DeleteFunctionEventInvokeConfig",
                "lambda:DeleteFunction",
                "lambda:GetAlias",
                "lambda:CreateCodeSigningConfig",
                "lambda:PutFunctionCodeSigningConfig",
                "lambda:UpdateFunctionUrlConfig",
                "lambda:CreateFunctionUrlConfig",
                "lambda:UpdateFunctionEventInvokeConfig",
                "lambda:DeleteFunctionCodeSigningConfig",
                "lambda:UpdateEventSourceMapping",
                "lambda:InvokeFunctionUrl",
                "lambda:UpdateFunctionCodeSigningConfig",
                "lambda:GetEventSourceMapping",
                "lambda:InvokeFunction",
                "lambda:GetFunction",
                "lambda:UpdateFunctionConfiguration",
                "lambda:GetFunctionUrlConfig",
                "lambda:GetFunctionCodeSigningConfig",
                "lambda:UpdateAlias",
                "lambda:UpdateCodeSigningConfig",
                "lambda:UpdateFunctionCode",
                "lambda:GetFunctionConcurrency",
                "lambda:GetFunctionEventInvokeConfig",
                "lambda:PutProvisionedConcurrencyConfig",
                "lambda:DeleteAlias",
                "lambda:PublishVersion",
                "lambda:DeleteFunctionConcurrency",
                "lambda:GetCodeSigningConfig",
                "lambda:DeleteEventSourceMapping",
                "lambda:DeleteFunctionUrlConfig",
                "lambda:GetPolicy",
                "lambda:CreateAlias"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_access_key" "IAMAccessKey" {
    status = "Active"
    user = "Brian_Davis"
}

resource "aws_iam_access_key" "IAMAccessKey2" {
    status = "Active"
    user = "Brian_Davis"
}

resource "aws_iam_access_key" "IAMAccessKey3" {
    status = "Active"
    user = "Former2"
}

resource "aws_iam_access_key" "IAMAccessKey4" {
    status = "Active"
    user = "Former2"
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

resource "aws_instance" "EC2Instance" {
    ami = "ami-0cff7528ff583bf9a"
    instance_type = "t2.micro"
    key_name = "LinuxDiddyKey"
    availability_zone = "us-east-1a"
    tenancy = "default"
    subnet_id = "subnet-0e7870c11a18d7ed7"
    ebs_optimized = false
    vpc_security_group_ids = [
        "${aws_security_group.EC2SecurityGroup.id}"
    ]
    source_dest_check = true
    root_block_device {
        volume_size = 8
        volume_type = "gp2"
        delete_on_termination = true
    }
    tags = {
        Name = "Fortune Of the Day"
    }
}

resource "aws_security_group" "EC2SecurityGroup" {
    description = "launch-wizard created 2022-07-17T20:41:41.513Z"
    name = "launch-wizard-1"
    tags = {}
    vpc_id = "vpc-0e3ad828372693163"
    ingress {
        cidr_blocks = [
            "96.250.91.141/32"
        ]
        from_port = 22
        protocol = "tcp"
        to_port = 22
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_ebs_volume" "EC2Volume" {
    availability_zone = "us-east-1a"
    encrypted = false
    size = 8
    type = "gp2"
    snapshot_id = "snap-08f1069dfde2007ba"
    tags = {}
}

resource "aws_volume_attachment" "EC2VolumeAttachment" {
    volume_id = "vol-056628ce75d75d6aa"
    instance_id = "i-0296cd79c8faf7ddd"
    device_name = "/dev/xvda"
}

resource "aws_network_interface" "EC2NetworkInterface" {
    description = ""
    private_ips = [
        "172.31.20.177"
    ]
    subnet_id = "subnet-0e7870c11a18d7ed7"
    source_dest_check = true
    security_groups = [
        "${aws_security_group.EC2SecurityGroup.id}"
    ]
}

resource "aws_network_interface_attachment" "EC2NetworkInterfaceAttachment" {
    network_interface_id = "eni-09875cbbd3a9e29b5"
    device_index = 0
    instance_id = "i-0296cd79c8faf7ddd"
}

resource "aws_key_pair" "EC2KeyPair" {
    public_key = "REPLACEME"
    key_name = "LinuxDiddyKey"
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
    role = "${aws_iam_role.IAMRole4.arn}"
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

resource "aws_opsworks_user_profile" "OpsWorksUserProfile" {
    allow_self_management = false
    user_arn = "arn:aws:iam::606997302812:user/Former2"
    ssh_username = "former2"
}

resource "aws_cloudwatch_metric_alarm" "CloudWatchAlarm" {
    alarm_name = "TargetTracking-table/VisitorCounter-AlarmHigh-14e9adf9-2325-4d0c-bb18-c7f7c1f16e23"
    alarm_description = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:8ca2c2e3-6e1c-4323-89f7-2c860d52fa86:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/4af15cab-94bf-4a5a-b7c6-968cf8a4c0e6."
    actions_enabled = true
    alarm_actions = [
        "arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:8ca2c2e3-6e1c-4323-89f7-2c860d52fa86:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/4af15cab-94bf-4a5a-b7c6-968cf8a4c0e6"
    ]
    metric_name = "ConsumedReadCapacityUnits"
    namespace = "AWS/DynamoDB"
    statistic = "Sum"
    dimensions {
        TableName = "VisitorCounter"
    }
    period = 60
    evaluation_periods = 2
    threshold = 42
    comparison_operator = "GreaterThanThreshold"
}

resource "aws_cloudwatch_metric_alarm" "CloudWatchAlarm2" {
    alarm_name = "TargetTracking-table/VisitorCounter-AlarmHigh-758ae445-ec87-4671-b0e3-71e772b91c6a"
    alarm_description = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:a1b4aa81-f7d3-40fe-bf40-c046cf015aba:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/965af01d-e5b5-43db-b955-6485a448297d."
    actions_enabled = true
    alarm_actions = [
        "arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:a1b4aa81-f7d3-40fe-bf40-c046cf015aba:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/965af01d-e5b5-43db-b955-6485a448297d"
    ]
    metric_name = "ConsumedWriteCapacityUnits"
    namespace = "AWS/DynamoDB"
    statistic = "Sum"
    dimensions {
        TableName = "VisitorCounter"
    }
    period = 60
    evaluation_periods = 2
    threshold = 42
    comparison_operator = "GreaterThanThreshold"
}

resource "aws_cloudwatch_metric_alarm" "CloudWatchAlarm3" {
    alarm_name = "TargetTracking-table/VisitorCounter-AlarmLow-688963f7-aafc-4c0c-8d70-1f20a684a12e"
    alarm_description = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:8ca2c2e3-6e1c-4323-89f7-2c860d52fa86:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/4af15cab-94bf-4a5a-b7c6-968cf8a4c0e6."
    actions_enabled = true
    alarm_actions = [
        "arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:8ca2c2e3-6e1c-4323-89f7-2c860d52fa86:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/4af15cab-94bf-4a5a-b7c6-968cf8a4c0e6"
    ]
    metric_name = "ConsumedReadCapacityUnits"
    namespace = "AWS/DynamoDB"
    statistic = "Sum"
    dimensions {
        TableName = "VisitorCounter"
    }
    period = 60
    evaluation_periods = 15
    threshold = 30
    comparison_operator = "LessThanThreshold"
}

resource "aws_cloudwatch_metric_alarm" "CloudWatchAlarm4" {
    alarm_name = "TargetTracking-table/VisitorCounter-AlarmLow-f7f5de71-8bb3-42d6-a9be-96bd5c74c029"
    alarm_description = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:a1b4aa81-f7d3-40fe-bf40-c046cf015aba:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/965af01d-e5b5-43db-b955-6485a448297d."
    actions_enabled = true
    alarm_actions = [
        "arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:a1b4aa81-f7d3-40fe-bf40-c046cf015aba:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/965af01d-e5b5-43db-b955-6485a448297d"
    ]
    metric_name = "ConsumedWriteCapacityUnits"
    namespace = "AWS/DynamoDB"
    statistic = "Sum"
    dimensions {
        TableName = "VisitorCounter"
    }
    period = 60
    evaluation_periods = 15
    threshold = 30
    comparison_operator = "LessThanThreshold"
}

resource "aws_cloudwatch_metric_alarm" "CloudWatchAlarm5" {
    alarm_name = "TargetTracking-table/VisitorCounter-ProvisionedCapacityHigh-56bd96a1-2fa8-45d8-97d5-a9b4cb6fca37"
    alarm_description = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:8ca2c2e3-6e1c-4323-89f7-2c860d52fa86:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/4af15cab-94bf-4a5a-b7c6-968cf8a4c0e6."
    actions_enabled = true
    alarm_actions = [
        "arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:8ca2c2e3-6e1c-4323-89f7-2c860d52fa86:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/4af15cab-94bf-4a5a-b7c6-968cf8a4c0e6"
    ]
    metric_name = "ProvisionedReadCapacityUnits"
    namespace = "AWS/DynamoDB"
    statistic = "Average"
    dimensions {
        TableName = "VisitorCounter"
    }
    period = 300
    evaluation_periods = 3
    threshold = 1
    comparison_operator = "GreaterThanThreshold"
}

resource "aws_cloudwatch_metric_alarm" "CloudWatchAlarm6" {
    alarm_name = "TargetTracking-table/VisitorCounter-ProvisionedCapacityHigh-dfc13ca8-0ca2-44c0-b7ce-7c2237878790"
    alarm_description = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:a1b4aa81-f7d3-40fe-bf40-c046cf015aba:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/965af01d-e5b5-43db-b955-6485a448297d."
    actions_enabled = true
    alarm_actions = [
        "arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:a1b4aa81-f7d3-40fe-bf40-c046cf015aba:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/965af01d-e5b5-43db-b955-6485a448297d"
    ]
    metric_name = "ProvisionedWriteCapacityUnits"
    namespace = "AWS/DynamoDB"
    statistic = "Average"
    dimensions {
        TableName = "VisitorCounter"
    }
    period = 300
    evaluation_periods = 3
    threshold = 1
    comparison_operator = "GreaterThanThreshold"
}

resource "aws_cloudwatch_metric_alarm" "CloudWatchAlarm7" {
    alarm_name = "TargetTracking-table/VisitorCounter-ProvisionedCapacityLow-6b5a66f4-e329-4143-b2d6-65e5e17e23e9"
    alarm_description = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:a1b4aa81-f7d3-40fe-bf40-c046cf015aba:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/965af01d-e5b5-43db-b955-6485a448297d."
    actions_enabled = true
    alarm_actions = [
        "arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:a1b4aa81-f7d3-40fe-bf40-c046cf015aba:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/965af01d-e5b5-43db-b955-6485a448297d"
    ]
    metric_name = "ProvisionedWriteCapacityUnits"
    namespace = "AWS/DynamoDB"
    statistic = "Average"
    dimensions {
        TableName = "VisitorCounter"
    }
    period = 300
    evaluation_periods = 3
    threshold = 1
    comparison_operator = "LessThanThreshold"
}

resource "aws_cloudwatch_metric_alarm" "CloudWatchAlarm8" {
    alarm_name = "TargetTracking-table/VisitorCounter-ProvisionedCapacityLow-7917ed6b-0abf-4e0b-875c-d7107a7b3fd4"
    alarm_description = "DO NOT EDIT OR DELETE. For TargetTrackingScaling policy arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:8ca2c2e3-6e1c-4323-89f7-2c860d52fa86:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/4af15cab-94bf-4a5a-b7c6-968cf8a4c0e6."
    actions_enabled = true
    alarm_actions = [
        "arn:aws:autoscaling:us-east-1:606997302812:scalingPolicy:8ca2c2e3-6e1c-4323-89f7-2c860d52fa86:resource/dynamodb/table/VisitorCounter:policyName/$VisitorCounter-scaling-policy:createdBy/4af15cab-94bf-4a5a-b7c6-968cf8a4c0e6"
    ]
    metric_name = "ProvisionedReadCapacityUnits"
    namespace = "AWS/DynamoDB"
    statistic = "Average"
    dimensions {
        TableName = "VisitorCounter"
    }
    period = 300
    evaluation_periods = 3
    threshold = 1
    comparison_operator = "LessThanThreshold"
}

resource "aws_cloudwatch_log_group" "LogsLogGroup" {
    name = "/aws/lambda/VisitorCounterAPI"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/05/[$LATEST]0b86e2926c284b14adfb4b974b01b475"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream2" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/05/[$LATEST]2b288514447f48ec9d9dbae56fbf94ec"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream3" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/05/[$LATEST]6402f9372ba8477f8c5d00c35dc20dd8"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream4" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/05/[$LATEST]6922c37b43db4139aedaf7be4b1089b8"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream5" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/05/[$LATEST]b451c1dd3a0c45328d7176f483c07c19"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream6" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/05/[$LATEST]febf6fb02ec3479596e652889d62890e"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream7" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/06/[$LATEST]4e95f1dacd9b486eb055cc8cc18d9206"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream8" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/06/[$LATEST]514cbcb0a1ae424b98c04152b4bcd105"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream9" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/06/[$LATEST]517b29340a324ea68ae856118eae4063"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream10" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/06/[$LATEST]77daa9a9bbb54bc1a4ee7591f6b89754"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream11" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/06/[$LATEST]820886960c984bb3a80154fb986005d8"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream12" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/06/[$LATEST]88d26b09bd9e46e4ac96753e4907b01d"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream13" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/06/[$LATEST]a05c6fc81b034ac0a32f82ce318cf7a9"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream14" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/06/[$LATEST]c2613c89cd4b46b2b058c3435c486d01"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream15" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/06/[$LATEST]c288574597854c64bce607048a0f9170"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream16" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/06/[$LATEST]c79e11689bc94a349d730489512e3155"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream17" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/06/[$LATEST]e74f073e1cb44cadb3c356a25517938e"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream18" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/06/[$LATEST]e7b9479dd7154e799d8a20924eff9ca0"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream19" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/07/[$LATEST]189f6cbdc57b4d6992f3031d9d4d3ceb"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream20" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/07/[$LATEST]44d8259179044d04b39bbc46c845fc2b"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream21" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/07/[$LATEST]5d1d5333e4cf4841823a4dcc33381b70"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream22" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/07/[$LATEST]b93df4a76f4046b891ff97fefe226f86"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream23" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/07/[$LATEST]dc9b0f96c284418eb4750e9fc722ff51"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream24" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/07/[$LATEST]f0def7fcedcd4c1ca2a738492b155b65"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream25" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2022/12/07/[$LATEST]ff5bc84011894052b1108bc9f0adaa89"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream26" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/01/29/[$LATEST]02cd46254a8647269db46dc9de86ce6b"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream27" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/01/29/[$LATEST]3cb37c45798c4bbc8b4f6d305307090e"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream28" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/18/[$LATEST]7a7a4be31b4e45deaf724944db7c8b4b"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream29" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/22/[$LATEST]0bb3ecb2b8084eceb4378fdba104b29c"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream30" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/22/[$LATEST]7fc6645fe69f46cdabcbf84d080c8cef"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream31" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/22/[$LATEST]955686356fe149d098efb812e0629fff"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream32" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/22/[$LATEST]b2b628e7b7ca444eb77f5fdecb55c164"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream33" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]03310c22ead8477496812393df95977b"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream34" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]08bb71d8cc684d28a8f5957a02a6419b"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream35" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]12ad12eb2de44a90a6b2b5b48125fc26"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream36" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]29b0146e59014927b4220322f6eaa894"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream37" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]2ac2aa0842b944dbbeeffd1bc34d0f23"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream38" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]348ce4442a7c4ea99c92d9e25df65168"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream39" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]3d4501d76e0c4c73a7d6bb7977c5669d"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream40" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]5c0e5dcad64042f88e88bba3b58ea3dc"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream41" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]6cb3a39da5e14c568c8b3e9fd618536a"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream42" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]8866969b79c34cfe953431c09c8d2080"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream43" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]929cafc1d0524775aea9e9513672453c"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream44" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]99e9dc6a638a44239343861ad39ab955"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream45" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]ac5f11ef013f4a308e63bc3923562b39"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream46" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]b09345f06e4249db8b4212abfabd20cc"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream47" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]b7e6109e4e6c44f98526e67c139effb8"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream48" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]bf9b356f555349078d65ce6a21fb055b"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream49" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]cdd87fda6401430cbee438e27583d5a9"
}

resource "aws_cloudwatch_log_stream" "LogsLogStream50" {
    log_group_name = "/aws/lambda/VisitorCounterAPI"
    name = "2023/03/23/[$LATEST]e32ea789f2b841009556821443aaad4e"
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

resource "aws_api_gateway_rest_api" "ApiGatewayRestApi" {
    name = "Visitor Counter"
    description = "This API will invoke a lambda function to display the number of people that visited a website."
    api_key_source = "HEADER"
    endpoint_configuration {
        types = [
            "REGIONAL"
        ]
    }
}

resource "aws_api_gateway_stage" "ApiGatewayStage" {
    stage_name = "Prod"
    deployment_id = "xu1f8p"
    rest_api_id = "3kgi0zz7gj"
    description = "Production stage for API"
    cache_cluster_enabled = false
    xray_tracing_enabled = false
}

resource "aws_api_gateway_deployment" "ApiGatewayDeployment" {
    rest_api_id = "3kgi0zz7gj"
}

resource "aws_api_gateway_deployment" "ApiGatewayDeployment2" {
    rest_api_id = "3kgi0zz7gj"
}

resource "aws_api_gateway_deployment" "ApiGatewayDeployment3" {
    rest_api_id = "3kgi0zz7gj"
}

resource "aws_api_gateway_deployment" "ApiGatewayDeployment4" {
    rest_api_id = "3kgi0zz7gj"
    description = "prod"
}

resource "aws_api_gateway_deployment" "ApiGatewayDeployment5" {
    rest_api_id = "3kgi0zz7gj"
}

resource "aws_api_gateway_deployment" "ApiGatewayDeployment6" {
    rest_api_id = "3kgi0zz7gj"
    description = "Created by AWS Lambda"
}

resource "aws_api_gateway_method" "ApiGatewayMethod" {
    rest_api_id = "3kgi0zz7gj"
    resource_id = "21oy3xhpo9"
    http_method = "OPTIONS"
    authorization = "NONE"
    api_key_required = false
    request_parameters {}
}

resource "aws_api_gateway_method" "ApiGatewayMethod2" {
    rest_api_id = "3kgi0zz7gj"
    resource_id = "21oy3xhpo9"
    http_method = "GET"
    authorization = "NONE"
    api_key_required = false
    request_parameters {}
}

resource "aws_api_gateway_method" "ApiGatewayMethod3" {
    rest_api_id = "3kgi0zz7gj"
    resource_id = "21oy3xhpo9"
    http_method = "POST"
    authorization = "NONE"
    api_key_required = false
    request_parameters {}
}

resource "aws_api_gateway_model" "ApiGatewayModel" {
    rest_api_id = "3kgi0zz7gj"
    name = "Error"
    description = "This is a default error schema model"
    schema = <<EOF
{
  "$schema" : "http://json-schema.org/draft-04/schema#",
  "title" : "Error Schema",
  "type" : "object",
  "properties" : {
    "message" : { "type" : "string" }
  }
}
EOF
    content_type = "application/json"
}

resource "aws_api_gateway_model" "ApiGatewayModel2" {
    rest_api_id = "3kgi0zz7gj"
    name = "Empty"
    description = "This is a default empty schema model"
    schema = <<EOF
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title" : "Empty Schema",
  "type" : "object"
}
EOF
    content_type = "application/json"
}

resource "aws_acm_certificate" "CertificateManagerCertificate" {
    domain_name = "bdavisawsresume.link"
    subject_alternative_names = [
        "bdavisawsresume.link",
        "*.bdavisawsresume.link",
        "www.bdavisawsresume.link"
    ]
    validation_method = "DNS"
}
