resource "aws_sns_topic" "guardduty-sns-main" {
  name          = "guardduty-main"
  display_name  = "GuardDuty"
}
# Protocol 'email' is not supported thus subscription will have be done manually
