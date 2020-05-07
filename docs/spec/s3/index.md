# S3

- Buckets for AWS service logs in each region (w/ S3 Object Lock)
- Bucket for AWS S3 access logs in each region (w/ S3 Object Lock)
- Replicate logging buckets to another account for longer retention and auditing

S3 access logs are an outlier in that the object ownership and ACLs are special for the
S3 service. Cross-account access requires role assumption and changes to object
ownership.

## Patterns

### Single Bucket

Bucket name:         <account_id>-<environment>-aws-service-logs-<region>
Bucket name example: 123456789012-dev-aws-service-logs-us-east-1

Log types and prefixes:

- CloudTrail: cloudtrail/
- Config: config/
- ALB/ELB/NLB: lb/, alb/, elb/, nlb/ (pull from any and process the same)

### Multiple Per-Service Buckets

- CloudTrail: <account_id>-<environment>-cloudtrail-logs-<region>
- Config: <account_id>-<environment>-config-logs-<region>
- ELB: <account_id>-<environment>-elb-access-logs-<region>
- S3: <account_id>-<environment>-s3-access-logs-<region>

### Delivery Notications

- CloudTrail: send to SNS
- Config: send to SNS
- ELB: S3 events to SNS
- S3: S3 events to SNS

#### Plumbing

- Use S3 Events (optional) -> SNS -> SQS to retain a queue of events to process
- SNS can also fan out to other destinations
- SNS Event Forking to SAM applications (parallel processing and filtering)
- SNS topics and SQS queues send failures to deadletter queues
- Lambda to process the deadletter queues

### Security

- Each bucket only allows access from specific AWS services in the same region
- All buckets encrypted with KMS, forced via the bucket policy
- Public access blocked
- Object Lock enabled (use compliance mode)
- VPC Endpoint for S3
 
#### Special Notes for S3 Access Logs

Logging buckets for S3 access logs _cannot_ be encrypted. The bucket owner for the
objects is also specific to the logging service. Objects cannot be accessed from
another account without assuming a role into the account with the bucket.

To allow these logs to be processed in the same manner as other service logs, use a
Lambda (or some other form of automation) to copy the logs to another bucket and update
the object ownerships.

NOTE: Research S3 bucket replication in the context of S3 access logs. Could enable
getting around the need for Lambda processing.

#### Bucket Policies

Specific AWS services vary on how to grant permissions to use the buckets:

- CloudTrail uses a service principal (cloudtrail.amazonaws.com) to put logs and check bucket ACLs
- Config uses an IAM role to do the same
- ELB uses AWS account IDs (root) for the ELB service, different ones in each region

### Durability

- Replication (replicate buckets to another region and/or account for longer-term storage and analysis)
- Versioning enabled (required for replication and object lock)

### Cost Controls

- Lifecycle policies to transition objects into cheaper storage (and/or eventually delete)
- 
