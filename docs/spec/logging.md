# Logging

All accounts should have multiple logging pipelines available that can be used with
little thought. Accounts should all have the tooling necessary to retain and analyze
logs for a set retention period. All logging buckets should be replicated to another
account for longer-term retention and analysis.

See the [s3](s3/index.md) spec for details on bucket configurations necessary to
support log collection from various sources.

## AWS Service Logs

- All logs should be delivered to S3
- Use SNS to receive log delivery events
- Send events to SQS queues
- Subscribe Lambdas to the queues (invoked in parallel batches by SQS)

## Processing

Methods of log processing and delivery will vary depending on the volume of data there
is to process. Things like CloudTrail and ELB logs can become quite large with active
accounts and services.

- Lambdas should process the messages, build a list of files to process, route the list
  to other destinations (if necessary), and deliver the processed log data to another
  S3 bucket
- Use Athena's "Create Table As" query to convert logs to parquet and manage the
  associated Glue catalogs.
- Replicate processed logs between regions
- Replicate processed logs to another account

## Controlling Cost

## Monitoring

- Use S3 Inventory reports to periodically compare the processed S3 Events with the
  actual objects in the bucket. This ensures that we still process any objects in the
  event that S3 fails to properly fire and/or delivery an event.
