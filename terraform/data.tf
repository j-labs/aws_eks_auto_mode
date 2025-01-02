data "aws_region" "current" {}

# I added my user to the EKS cluster, as it was not included in the example from Terraform docs.
data "aws_iam_user" "jan_tyminski" {
  user_name = "jan.tyminski@j-labs.pl"
}