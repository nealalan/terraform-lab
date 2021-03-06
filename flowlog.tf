resource "aws_flow_log" "main-flowlog" {
  log_group_name = "${aws_cloudwatch_log_group.flowlog-group.name}"
  iam_role_arn   = "${aws_iam_role.flowlog-role.arn}"
  vpc_id         = "${aws_vpc.neon_aluminum-vpc.id}"
  traffic_type   = "ALL"
}

resource "aws_cloudwatch_log_group" "flowlog-group" {
  name = "flowlog_group"
}

resource "aws_iam_role" "flowlog-role" {
  name = "flowlog_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "flowlog-policy" {
  name = "flowlog_policy"
  role = "${aws_iam_role.flowlog-role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
