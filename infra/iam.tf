resource "aws_iam_policy" "iam_policy" {
  name       = "lambda_functions"
  depends_on = [aws_dynamodb_table.table1, aws_s3_bucket.my_bucket, aws_sns_topic.sns_topic]
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "Perm1",
        Effect = "Allow",
        Action = [
          "polly:SynthesizeSpeech",
          "s3:GetBucketLocation",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      },
      {
        Sid    = "Perm2",
        Effect = "Allow",
        Action = [
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:GetItem"
        ],
        Resource = aws_dynamodb_table.table1.arn
      },
      {
        Sid    = "Perm3",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetBucketLocation"
        ],
        Resource = "${aws_s3_bucket.my_bucket.arn}/*"
      },
      {
        Sid    = "Perm4",
        Effect = "Allow",
        Action = [
          "sns:Publish"
        ],
        Resource = aws_sns_topic.sns_topic.arn
      }
    ]
  })
}
resource "aws_iam_role" "iam_role" {
  name = "lambda_functions_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}