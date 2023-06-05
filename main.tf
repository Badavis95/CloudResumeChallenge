terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.0.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "VisitorCounterAPI" {
  function_name                  = "VisitorCounterAPI"
  handler                        = "lambda_function.lambda_handler"
  memory_size                    = 128
  reserved_concurrent_executions = -1
  role                           = "arn:aws:iam::606997302812:role/service-role/VisitorCounterAPI-role-fqc7x4pi"
  runtime                        = "python3.9"
  timeout                        = 3
  architectures                  = ["x86_64"]

  # Add the S3 bucket and key where your function is stored
  s3_bucket = "awscrclambdadbupdatefunc"
  s3_key    = "Update_DB_Count.zip"

  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_dynamodb_table" "VisitorCounter" {
  attribute {
    name = "WebsiteVisits"
    type = "S"
  }

  billing_mode = "PROVISIONED"
  hash_key     = "WebsiteVisits"
  name         = "VisitorCounter"

  point_in_time_recovery {
    enabled = "false"
  }

  read_capacity  = "1"
  stream_enabled = "false"
  write_capacity = "1"
}


resource "aws_s3_bucket" "bdavisawsresume_link" {
  bucket        = "bdavisawsresume.link"
  force_destroy = false
}

resource "aws_s3_bucket_policy" "bdavisawsresume_link" {
  bucket = aws_s3_bucket.bdavisawsresume_link.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource = [
          "${aws_s3_bucket.bdavisawsresume_link.arn}/*",
        ],
      },
    ],
  })
}

resource "aws_s3_bucket_website_configuration" "bdavisawsresume_link" {
  bucket = aws_s3_bucket.bdavisawsresume_link.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_versioning" "bdavisawsresume_link" {
  bucket = aws_s3_bucket.bdavisawsresume_link.id

  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bdavisawsresume_link" {
  bucket = aws_s3_bucket.bdavisawsresume_link.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket" "www_bdavisawsresume_link" {
  bucket        = "www.bdavisawsresume.link"
  force_destroy = false
}

resource "aws_s3_bucket_policy" "www_bdavisawsresume_link" {
  bucket = aws_s3_bucket.www_bdavisawsresume_link.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource = [
          "${aws_s3_bucket.www_bdavisawsresume_link.arn}/*",
        ],
      },
    ],
  })
}

resource "aws_s3_bucket_website_configuration" "www_bdavisawsresume_link" {
  bucket = aws_s3_bucket.www_bdavisawsresume_link.id

  redirect_all_requests_to {
    host_name = "bdavisawsresume.link"
    protocol  = "https"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "www_bdavisawsresume_link" {
  bucket = aws_s3_bucket.www_bdavisawsresume_link.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


resource "aws_api_gateway_stage" "ApiGatewayStage" {
    stage_name = "Prod"
    deployment_id = "xu1f8p"
    rest_api_id = "${aws_api_gateway_rest_api.ApiGatewayRestApi.id}"
    description = "Production stage for API"
    cache_cluster_enabled = false
    xray_tracing_enabled = false

    lifecycle {
    ignore_changes = [
      # Ignore changes to stage settings
      deployment_id,
    ]
  }
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

resource "aws_api_gateway_method" "ApiGatewayMethod" {
    rest_api_id = "${aws_api_gateway_rest_api.ApiGatewayRestApi.id}"
    resource_id = "21oy3xhpo9"
    http_method = "GET"
    authorization = "NONE"
    api_key_required = false
}

resource "aws_api_gateway_method" "ApiGatewayMethod2" {
    rest_api_id = "${aws_api_gateway_rest_api.ApiGatewayRestApi.id}"
    resource_id = "21oy3xhpo9"
    http_method = "POST"
    authorization = "NONE"
    api_key_required = false
}

resource "aws_api_gateway_method" "ApiGatewayMethod3" {
    rest_api_id = "${aws_api_gateway_rest_api.ApiGatewayRestApi.id}"
    resource_id = "21oy3xhpo9"
    http_method = "OPTIONS"
    authorization = "NONE"
    api_key_required = false
}


resource "aws_api_gateway_model" "ApiGatewayModel" {
    rest_api_id = "${aws_api_gateway_rest_api.ApiGatewayRestApi.id}"
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
    lifecycle {
    ignore_changes = [
      # Ignore changes to model settings
      schema,
    ]
  }
}


resource "aws_api_gateway_model" "ApiGatewayModel2" {
    rest_api_id = "${aws_api_gateway_rest_api.ApiGatewayRestApi.id}"
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
      lifecycle {
    ignore_changes = [
      # Ignore changes to model settings
      schema,
    ]
  }
}


resource "aws_api_gateway_deployment" "ApiGatewayDeployment" {
    rest_api_id = "${aws_api_gateway_rest_api.ApiGatewayRestApi.id}"
    description = "prod"
}

resource "aws_api_gateway_deployment" "ApiGatewayDeployment2" {
    rest_api_id = "${aws_api_gateway_rest_api.ApiGatewayRestApi.id}"
    description = "Created by AWS Lambda"
}

