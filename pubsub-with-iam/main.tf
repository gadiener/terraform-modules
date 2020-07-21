locals {
  ttl_list = [var.ttl]
  push_list = var.push != "" ? [var.push] : []
  all_subscriptions = concat(
    [{
      "name" = coalesce(var.name_subscription,var.name)
      "roles" = var.roles_subscription
      "message_retention_duration" = var.message_retention_duration
      "ack_deadline_seconds"       = var.ack_deadline_seconds
      "retain_acked_messages"      = var.retain_acked_messages
      "ttl_list" = [var.ttl]
      "push_list" = var.push != "" ? [var.push] : []
    }],
    var.extra_subscriptions )
}

resource "google_pubsub_topic" "topic" {
  name    = var.name
  project = var.project

  labels  = var.labels

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "google_pubsub_subscription" "subscription" {
  count   = var.topic_only ? "0" : length(local.all_subscriptions)
  name    = local.all_subscriptions[count.index].name
  topic   = google_pubsub_topic.topic.name
  project = var.project

  message_retention_duration = try(local.all_subscriptions[count.index].message_retention_duration, var.message_retention_duration)
  ack_deadline_seconds       = try(local.all_subscriptions[count.index].ack_deadline_seconds, var.ack_deadline_seconds)
  retain_acked_messages      = try(local.all_subscriptions[count.index].retain_acked_messages, var.retain_acked_messages)

  dynamic "expiration_policy" {
    for_each = try(local.all_subscriptions[count.index].ttl_list, local.ttl_list) # 'for each' but it will only be one element
    content {
          ttl  = expiration_policy.value
    }
  }

  dynamic "push_config" {
    for_each = try(local.all_subscriptions[count.index].push_list, local.push_list) # 'for each' but it will only be one element
    content {
          push_endpoint  = push_config.value
    }
  }

  labels = var.labels

  depends_on = [google_pubsub_topic.topic]
}

resource "google_pubsub_topic_iam_binding" "pubsub_topic_role" {
  count = length(keys(var.roles_topic))

  topic        = google_pubsub_topic.topic.id
  role         = "roles/pubsub.${element(keys(var.roles_topic), count.index)}"
  members      = formatlist("serviceAccount:%s",lookup(var.roles_topic, element(keys(var.roles_topic),count.index)))

  depends_on = [google_pubsub_topic.topic]
}

resource "google_pubsub_subscription_iam_binding" "pubsub_subscription_role" {
  count = length(keys(var.roles_subscription))

  subscription = google_pubsub_subscription.subscription[0].id #terraform limitation
  role         = "roles/pubsub.${element(keys(var.roles_subscription), count.index)}"
  members      = formatlist("serviceAccount:%s",lookup(var.roles_subscription, element(keys(var.roles_subscription),count.index)))

  depends_on   = [google_pubsub_subscription.subscription]
}

