variable "region" {
  default = "us-west1"
}

variable "region_zone" {
  default = "us-west1-a"
}

variable "project_name" {
  default     = "terraform-demo-cfp"
  description = "The ID of the Google Cloud project"
}


variable "ip_white_list" {
  description = "A list of ip addresses that can be white listed through security policies"
  default     = ["192.0.2.0/24"]
}
