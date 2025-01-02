provider "aws" {
  # Instances in Ireland are cheaper than in Frankfurt.
  # You can check costs e.g. at https://instances.vantage.sh/
  region = "eu-west-1"
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "eks-auto-mode-poc"
    }
  }
}