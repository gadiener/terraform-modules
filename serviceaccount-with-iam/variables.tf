variable "name" {
  description = "the name of the service account (MAX 30 characters)"
  type        = string
}

variable "displayname" {
  description = "the display name of the service account"
  type        = string

  default     = ""
}

variable "project" {
  description = "the project in GCP"
  type        = string

}

variable "description" {
  description = "Optional description"
  type        = string

  default     = ""
}

variable "roles" {
  description = "the roles of the SA"
  type        = list(string)

  default     = []
}