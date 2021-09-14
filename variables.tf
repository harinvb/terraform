variable "resource_group_name" {
  default = "DevEnvironment-Resources"
  type    = string
}

variable "location" {
  default = "Central India"
  type    = string
}

variable "ProjectName" {
  type    = string
  default = "DevEnvironment"
}

variable "Instances" {
  type    = list(string)
  default = ["Jenkins", "Artifactory", "Docker"]
}