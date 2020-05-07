# Config

Config is an AWS service that tracks the configuration of resources. Any modifications
to resources supported by Config will be captured and presented on a timeline, along
with a diff of config changes and details about what principal modified the resource.

Config Rules allow tracking compliance requirements. There is a list of built-in rules
that can be enabled, and custom rules can be created via Lambda functions. 

Config delivers logs to S3 and sends a notification to SNS upon delivery. Rules can be
configured to send notifications, perform remediation, or perform other customizable
actions.

## Recommended

-

### Built-in Rules

TODO: Build list of recommended Config Rules

- 

### Custom Rules

TODO: Add recommendations for how to use custom rules, including any that should be
enabled by default.

## AWS Organizations SCPs

If your account is part of an AWS Organization, Service Control Policies can be used to
ensure the usage of Config and Config Rules, as well as ensure critical resources
cannot be changed.

TODO: Add example SCP for Config
