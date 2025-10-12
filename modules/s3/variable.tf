
variable "bucket_name" {
  description = "The name of the S3 bucket to store Terraform state"
  type        = string
}

variable "state_file_key" {
  description = "The key (filename) for the Terraform state file"
  type        = string
  default     = "terraform.tfstate"
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
 
