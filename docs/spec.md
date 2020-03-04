# Specification

This document contains a high-level overview of the essentials. It contains a
breakdown of different categories of requirements.

## Processes

### Manual

Some actions require logging in as a root user to perform. These are typically
related to initial IAM user creation, enabling/disabling certain regions,
billing, and other things.

Prequisites:

- understand the scope of any accounts being managed
- use a consistent naming scheme across accounts
- use a consistent process to manage any root account emails and passwords

The following process much be performed manually, typically as the root user:

- root user password
- root user mfa
- disable unused regions
- opt in to the longer ARN format for ECS (not necessary for new accounts)

### Automated

Other processes can be automated via the relevant AWS APIs.

TODO: This is really just a big list, you know. . .

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
- Events to Capture¶
- root logins
- config changes
- access denied events
- kms key rotations and usage

## Common Tooling

Every account needs tooling to move events around.

- logging pipelines
- notification pipelines

### Compliance

Every account should have tooling to perform analysis for compliance audits.
The necessary data should be compiled by indexing the various event sources
available. Where practical, data should be streamed and processed in real time,
reacting to data via automated pipelines. Data should also be indexed for
historical analysis as well.

In short, accounts should audit themselves, while still providing mechanisms to
make the data available outside of the account.

- config rules
- cloudtrail analysis
- required tags

## Advanced

TODO

## Costs

TODO
