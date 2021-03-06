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

### Serviceaccount

Define a SA this way:

```
module "my_service_account" {
  source       = "git::https://github.com/jobtome-labs/terraform-modules.git//serviceaccount-with-iam?ref=v3.1.0""

  project      = "my-gcp-project"
  name         = "my-application-deployer"
  displayname  = "my-application deploy access"
  description  = "This is the SA of the deployer for my-application"

  roles        = ["roles/container.viewer"]
}
```

`displayname` is optional and defaults to the name if omitted
`description` is optional and defaults to empty
`roles` is an array of roles, your own custom role can be used in the form of `projects/<projectname>/roles/<rolename>` or the built-ins `roles/<rolename>`

Note: as of now, if a SA gets an additional permission in IAM via GCP console, terraform will *not* notice and will not remove it. This will be fixed in a future version by using resource type `google_project_iam_binding` instead of the current `google_project_iam_member`

### Pub/sub

Define a PubSub this way:

```
module "my_queue" {
  source       = "git::https://github.com/jobtome-labs/terraform-modules.git//pubsub-with-iam?ref=v3.2.0"

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

By default it makes *one* topic and *one* subscription with the same name. In case of import of resources made prior to managing the infrastructure with terraform, there is a possibility to override this setting and name the subscription differently (`name_subscription`).

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
