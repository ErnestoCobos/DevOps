variable "tags" {
  type = list(string)
  description = "The tags to apply to the server"
  default = []
}

variable "label" {
  type = string
  description = "The label to apply to the server"
  default = ""
}

variable "hostname" {
  type = string
  description = "The hostname to apply to the server"
}