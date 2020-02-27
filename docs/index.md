# AWS Account Baseline

This document outlines a set of baseline essentials that should be applied in
every AWS account. This module is intended to codify these practices.

*Status*: Planning

## Prerequisites

- understand the scope of any accounts being managed
- use a consistent naming scheme across accounts
- use a consistent process to manage any root account emails and passwords

## Manual

- root user password
- root user mfa
- disable unused regions
- opt in to the longer ARN format for ECS (not necessary for new accounts)

## Automated

- account alias
- account password policy
- delete default vpcs
- service log buckets
- s3 access log buckets
- cloudtrail
- config
- iam access analyzer
- sns topics
- sqs queues
- iam users
- iam roles
- iam policies
- iam saml providers
- cloudwatch log groups
- lambda functions
- kinesis streams
- firehose delivery streams
- cloudwatch events processors
- eventbridge processors
- dynamodb table(s) for Terraform state locks
- s3 buckets for Terraform state
- s3 bucket replication (cross-account / cross-region)
- dynamodb table replication (use Global Tables)
- kms keys
- budgets
- s3 inventory
- s3 analytics
- service quotas

## Events to Capture

- root logins
- config changes
- access denied events
- kms key rotations and usage

## Common Tooling

- logging pipelines
- notification pipelines

## Compliance Audits

- config rules
- cloudtrail analysis
- required tags
