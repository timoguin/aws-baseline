resource "aws_accessanalyzer_analyzer" {
  analyzer_name = "main"
  tags          = {}
  type          = "ACCOUNT"
}
