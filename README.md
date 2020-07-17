# Terraform modules

A set of Terraform modules for configuring production infrastructure with Google Cloud Platform

## Supported version

```
terraform {
  required_version = ">= 0.12"

  required_providers = {
    google = ">= 3.27.0"
    google-beta = ">= 3.27.0"
  }
}
```

## Instructions



### Pub/sub

Define a PubSub this way:

```
module "my_queue" {
  source       = "git::https://github.com/jobtome-labs/terraform-modules.git//pubsub-with-iam?ref=v3.2.0""

  project      = "my-gcp-project"
  name         = "my-pubsub"

  roles_topic = {
    admin: [module.my_serviceaccount-3.full_name]
    editor: []
    publisher: [module.my_serviceaccount.full_name]
    subscriber: [module.my_serviceaccount.full_name]
    viewer: [module.my_serviceaccount-2.full_name, module.my_serviceaccount.full_name]
  }

  roles_subscription = {
    admin: [module.my_serviceaccount-3.full_name]
    editor: []
    subscriber: [module.my_serviceaccount.full_name]
    viewer: [module.my_serviceaccount-2.full_name, module.my_serviceaccount.full_name]
  }
}
```

By default it makes *one* topic and *one* subscription with the same name. In case of import of resources made prior to tf, there is a possibility to override this setting and name the subscription differently (`name_subscription`).

`roles_topic` is an object containing all possible roles along with an array of SA with that privilege; in case we want nobody with that permission, we set an empty array.
Note: We want this way because if a SA gets an additional permission in the topic/subscription (e.g. via GCP console), terraform will notice and will remove it at the next `terraform apply`.

The same idea applies for `roles_subscription`. Note that for GCP resource 'subscriptions', there is one fewer role than the resource 'topic'.

One can have only a topic by specifying `topic_only = true`. In which case, `roles_subscription` is ignored.

One can have more subscriptions by specifying an array `extra_subscriptions` which contains objects with the following keys:
 - `name`
 - `roles`
 - `message_retention_duration`
 - `ack_deadline_seconds`
 - `retain_acked_messages`
 - `ttl_list`
 - `push_list`

which is basically the parameters of a subscription (therefore only `name` is mandatory). Notice however the name `ttl_list` and `push_list`: despite it is a single value (and optional in both), it **must** be coerced into a list. If parameters are omitted, all the extra subscriptions will have the same parameters (ttl, ack, etc) of the 'main' subscription.

Note: currently the design is limited and it is not possible to assign different permissions to the other subscriptions. In other words, all the subscriptions will have the same permissions of the 'main' subscription.
