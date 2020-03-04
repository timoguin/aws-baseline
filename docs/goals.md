# Goals

There are many steps required to properly setup a secure AWS environment. Some
of theses processes require manual work (sometimes from the root user only),
some can be automated with infrastructure as code, and some are a mixture of
the too. As well as baseline requirements, there is also a need to define
longer term goals and incremental improvements to the various components. Taken
together, this can all be difficult to comprehend and to properly implement.

## Documentation

The first goal of this document is to provide a detailed overview of all these
processes. Processes cannot be automated with first being documented in detail.

If there is not a source of truth that engineers can quickly reference, they
will burn more money than necessary. Teams will over-communicate with with each
other. They will make mistakes that can lead to a tangled, inconsistent mess of
infrastructure. This inconsistency leads to gaps in documentation, and
individual engineers will quickly become subject matter experts on various
aspects within. Bob will be asked about any IAM issues, Chris will be asked
about how alarms are configured, and every developer will ask how to access
logs and make changes in their accounts.

## Reliability

It's easier to sleep at night when there is confidence in the consistency of
your infrastructure. It is essential to have a source of truth.

Have you ever had questions like the following:

- Who changed the configuration for the load balancer?
- How do I use IAM to secure access to resources?
- How can I audit my instructure?
- What are the right ways to setup CloudTrail?
- How do I give developers freedom to experiment within their accounts with
  compromising essential security requirements?
- Why should I use tags, and what tags should I use?

Many questions like this shouldn't take more work that reading sections of this
document. No one should have to think much about all this.

## Security

Automating all the various aspect of security with an AWS account can be a 
daunting task. AWS offers a large handful of services that produce logs,
metrics, streams, and many integrations with other useful services. The format
and delivery of these logs vary between service: some only log to S3, some can
write to CloudWatch Logs, some offer notifications for log delivery, and so on.
In addition to service logs from AWS, there also have to be logging pipelines
for applications.

These features need to be easy and convenient to use, without much thought from
engineers.
