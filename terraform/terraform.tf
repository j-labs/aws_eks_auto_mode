terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # Amazon EKS Auto Mode support was added in version 5.79
      version = ">= 5.79"
    }
  }
}