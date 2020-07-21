variable "name" {
  description = "the name of the topic/subscription"
  type        = string
}

variable "name_subscription" {
  description = "the name of the subscription (specified only for backwards compatibility to imported resources)"
  type        = string

  default     = ""
}

variable "extra_subscriptions" {
  description = "the other subscriptions (map containing name and settings, NO ROLES)"
  type        = list

  default     = []
}

variable "project" {
  description = "the project in GCP"
  type        = string

}

variable "topic_only" {
  description = "whether we only want a topic or also a subscription"
  type        = bool

  default     = false
}

variable "roles_topic" {
  description = "the roles of the SA for the topic: specify 'roleName: [account1, account2]'"
  type        = map

  default     = {}
}

variable "roles_subscription" {
  description = "the roles of the SA for the subscription: specify 'roleName: [account1, account2]'"
  type        = map

  default     = {}
}

variable "labels" {
  description = "the labels of the pubsub topic/subscription"
  type        = map

  default     = {}
}

variable "ttl" {
  description = "the ttl (contains an array with ONE string. If null, google sets 2678400s; if present BUT empty, google sets to never expire)"
  type        = string

  default     = "2678400s"
}

variable "push" {
  description = "the push_config (contains an array with ONE string, or empty)"
  type        = string

  default     = ""
}

variable "message_retention_duration" {
  description = "message_retention_duration"
  type        = string

  default     = "604800s"
}

variable "ack_deadline_seconds" {
  description = "ack_deadline_seconds"
  type        = string

  default     = "600"
}

variable "retain_acked_messages" {
  description = "retain_acked_messages"
  type        = bool

  default     = true
}