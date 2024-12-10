variable "tf_state_bucket" {
  description = "Name of s3 bucket "
  default     = "rl-infra-stage-tf"
}

variable "tf_state_lock_table" {
  description = "Name of the dynamodb table for tf state locking"
  default     = "rl-infra-stage-tf-lock"
}

variable "project" {
  description = "Project name for tagging resources"
  default     = "uniquex-booking-system"
}

variable "contact" {
  description = "Contact name for tagging resources"
  default     = "abhiram.das@kilowott.com"
}
