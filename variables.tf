# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default     = "eu-west-1"
}

variable "output_bucket" {
  description = "Default bucket for output files"
  type        = string
  default     = "uniq-s3bucket-name-stocks-change-as-you-want"
}

variable "lambda_name" {
  description = "Name of Lambda itself"
  type        = string
  default     = "lambda-stocks"
}

variable "lambda_function_name" {
  description = "Name of Lambda itself"
  type        = string
  default     = "Get-stock-prices-tf"
}

variable "lambda_function_handler" {
  description = "Name of Lambda function handler"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_function_variable_stock_cad" {
  description = "List of Canadian stocks"
  type        = string
  default     = "OCO.V"
}

variable "lambda_function_variable_stock_chf" {
  description = "List of Swiss stocks"
  type        = string
  default     = "SREN.SW"
}

variable "lambda_function_variable_stock_eu" {
  description = "List of EU stocks"
  type        = string
  default     = "SXR8.DE"
}

variable "lambda_function_variable_stock_eng" {
  description = "List of English stocks"
  type        = string
  default     = "BP.L"
}

variable "lambda_function_variable_stock_usa" {
  description = "List of USA stocks"
  type        = string
  default     = "MSFT"
}