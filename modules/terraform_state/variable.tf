variable "bucket_name" {
    type = string
    }

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
 
 variable "dynom_db_name" {
    type = string
    }