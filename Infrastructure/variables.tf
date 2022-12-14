variable "aws_region" {
  type        = string
  description = "The AWS region to use"
  default     = "us-east-1"
}

variable "aws_access_key" {
  type        = string
  description = "The AWS access key to use"
}

variable "aws_secret_key" {
  type        = string
  description = "The AWS secret key to use"
}

variable "vultr_api_key" {
  type        = string
  description = "The Vultr API key to use"
}