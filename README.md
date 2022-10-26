# lambda-stocks
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | ~> 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.lambda_event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda_event_rule_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_role.lambda_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda_stocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.allow_cloudwatch_to_call_rw_fallout_retry_step_deletion_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket.lambda_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.lambda_bucket_output](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_acl.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_object.lambda_stocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_ssm_parameter.output_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_pet.lambda_bucket_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [archive_file.lambda_stocks](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region for all resources. | `string` | `"eu-west-1"` | no |
| <a name="input_lambda_function_handler"></a> [lambda\_function\_handler](#input\_lambda\_function\_handler) | Name of Lambda function handler | `string` | `"lambda_function.lambda_handler"` | no |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | Name of Lambda itself | `string` | `"Get-stock-prices-tf"` | no |
| <a name="input_lambda_function_variable_stock_cad"></a> [lambda\_function\_variable\_stock\_cad](#input\_lambda\_function\_variable\_stock\_cad) | List of Canadian stocks | `string` | `"OCO.V"` | no |
| <a name="input_lambda_function_variable_stock_chf"></a> [lambda\_function\_variable\_stock\_chf](#input\_lambda\_function\_variable\_stock\_chf) | List of Swiss stocks | `string` | `"SREN.SW,NESN.SW"` | no |
| <a name="input_lambda_function_variable_stock_eng"></a> [lambda\_function\_variable\_stock\_eng](#input\_lambda\_function\_variable\_stock\_eng) | List of English stocks | `string` | `"BP.L"` | no |
| <a name="input_lambda_function_variable_stock_eu"></a> [lambda\_function\_variable\_stock\_eu](#input\_lambda\_function\_variable\_stock\_eu) | List of EU stocks | `string` | `"SXR8.DE,EUN2.DE,SXRT.DE,IS3N.DE,EUNL.DE,IUSE.SW,SXRV.DE,QDVE.DE,LYMS.DE,SAWD.MI,ENG.MC,VWCE.DE"` | no |
| <a name="input_lambda_function_variable_stock_usa"></a> [lambda\_function\_variable\_stock\_usa](#input\_lambda\_function\_variable\_stock\_usa) | List of USA stocks | `string` | `"O,XOM,IUIT.SW,TWTR,AMD,T,KO,WM,TRVG,PLTR,DISH,GE,DDOG,GM,ITI,MO,SPCE,NEE,LAC,INTC,VALE,VZ,RIVN,EVGO,SPLK,INVZ,HRZN,PSEC,BABA,ATVI,RIVN,TSLA,MCD,YUM,DPZ,PZZA,CMG,SBUX,PYPL,BABA,DDOG,MT,F,TWTR,JNJ,D,ORC,ABR,GLAD,ENB,UL,ARCC,PEP,SO,KMI,BTI,STAG,GOOD,KHC,WBA,NRZ,SBR,ET,STOR,EPD,MPLX,CAG,OKE,CVX,HPE,F,C,JPM,USB,MS,WBD,KMI,VIRI"` | no |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | Name of Lambda itself | `string` | `"lambda-stocks"` | no |
| <a name="input_output_bucket"></a> [output\_bucket](#input\_output\_bucket) | Default bucket for output files | `string` | `"icyak-stocks-api-v2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | Name of the Lambda function. |
| <a name="output_lambda_bucket_name"></a> [lambda\_bucket\_name](#output\_lambda\_bucket\_name) | Name of the S3 bucket used to store function code. |
<!-- END_TF_DOCS -->