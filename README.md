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
