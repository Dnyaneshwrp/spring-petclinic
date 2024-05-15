# resource "aws_iam_role" "codebuild_role" {
#   name = "codebuild-service-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Principal = {
#         Service = "codebuild.amazonaws.com"
#       },
#       Action    = "sts:AssumeRole"
#     }]
#   })

#   // Attach policies here as needed for your CodeBuild project
# }




resource "aws_codebuild_project" "example" {
  name          = "test-project"
  description   = "test_codebuild_project"
  build_timeout = 5
  service_role  = "arn:aws:iam::654654465867:role/myrolecodebuild"

  artifacts {
    type = "NO_ARTIFACTS"
  }
 

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
     
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

     
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/Dnyaneshwrp/game-of-life.git"
    buildspec       = file("./buildspec.yaml")
    git_clone_depth = 1

     
  }

  source_version = "dev"

  tags = {
    Environment = "Test"
  }
}