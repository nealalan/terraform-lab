resource "aws_cloudwatch_event_rule" "guardduty-cw-main" {
  name = "Guardduty"
  description = "monitor gd alarms"
  event_pattern = <<PATTERN
{
  "source": [
    "aws.guardduty"
  ]
}
PATTERN
}

resource "aws_cloudwatch_event_target" "guardduty-sns-target" {
  rule = "${aws_cloudwatch_event_rule.guardduty-cw-main.name}"
  target_id = "SendToSNS"
  arn = "${aws_sns_topic.guardduty-sns-main.arn}"
}
