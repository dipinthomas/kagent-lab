# Example AWS Pricing Agent Queries

## Product Information Queries
- Show me available EC2 instance types in us-east-1
- What are the available storage classes for S3?
- List the available RDS database engines

## Attribute Value Queries
- What regions are available for EC2?
- Show me all available instance families for EC2
- What are the valid storage types for EBS?

## Price List Queries
- Get the price list for t3 instances in us-east-1
- Show me S3 Standard storage pricing in all regions
- What's the price list for data transfer in us-west-2?

## Using Filters
- Show EC2 instances with more than 8 vCPUs
- Find S3 storage options with lifecycle transitions
- List RDS instances that support Multi-AZ

## Query Tips
1. Be specific about the service (EC2, S3, RDS, etc.)
2. Specify the region when querying prices
3. Use filters to narrow down results
4. Ask for specific attributes you're interested in
