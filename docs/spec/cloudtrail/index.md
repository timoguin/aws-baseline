# CloudTrail

CloudTrail is an AWS service that records API calls and other events that occur within
an account. Accounts should have a mechanism in place to quickly and easy analyze the
large variety of API calls and events that flow through the system.

## Recommended

- Create a single trail for global events (IAM) in us-east-1
- Create a trail in each region for read events
- Create a trail in each region for write events
- Create a trail in each region for S3 Object events
- Create a trail in each region for Lambda events

## Service Events

https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-aws-service-specific-topics.html

## AWS Organizations SCPs

If your account is part of an AWS Organization, Service Control Policies can be used to
ensure use of CloudTrail, as well as ensure critical resources cannot be changed.

TODO: Add example SCP for CloudTrail
