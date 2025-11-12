#!/bin/bash

# CloudWatch Log Groups Setup Script
# This script creates the required log groups and sample data for the lab

set -e

# Configuration
AWS_REGION="us-east-1"
LOG_GROUP_PREFIX_LAMBDA="/aws/lambda/test-function"
LOG_GROUP_PREFIX_APP="/aws/ec2/application"

echo "🚀 Setting up CloudWatch Log Groups for Kagent Lab..."

# Check AWS CLI and credentials
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI not found. Please install AWS CLI first."
    exit 1
fi

if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ AWS credentials not configured. Please run 'aws configure' first."
    exit 1
fi

echo "✅ AWS CLI and credentials verified"

# Function to create log group safely
create_log_group() {
    local log_group_name=$1
    
    if aws logs describe-log-groups --log-group-name-prefix "$log_group_name" --region "$AWS_REGION" --query 'logGroups[?logGroupName==`'$log_group_name'`]' --output text | grep -q "$log_group_name"; then
        echo "⚠️  Log group $log_group_name already exists, skipping..."
    else
        echo "📝 Creating log group: $log_group_name"
        aws logs create-log-group --log-group-name "$log_group_name" --region "$AWS_REGION"
        echo "✅ Created log group: $log_group_name"
    fi
}

# Function to add sample log events
add_sample_logs() {
    local log_group_name=$1
    local log_stream_name=$2
    local app_name=$3
    
    echo "📊 Adding sample log events to $log_group_name"
    
    # Create log stream
    aws logs create-log-stream \
        --log-group-name "$log_group_name" \
        --log-stream-name "$log_stream_name" \
        --region "$AWS_REGION" 2>/dev/null || true
    
    # Current timestamp in milliseconds
    local base_timestamp=$(date +%s)000
    
    # Sample log events with realistic application logs
    local log_events='[
        {
            "timestamp": '$base_timestamp',
            "message": "[INFO] '$app_name' application started successfully on port 8080"
        },
        {
            "timestamp": '$((base_timestamp + 1000))',
            "message": "[INFO] Database connection pool initialized with 10 connections"
        },
        {
            "timestamp": '$((base_timestamp + 2000))',
            "message": "[WARN] High memory usage detected: 85% of heap space used"
        },
        {
            "timestamp": '$((base_timestamp + 3000))',
            "message": "[ERROR] Database connection failed: Connection timeout after 30 seconds"
        },
        {
            "timestamp": '$((base_timestamp + 4000))',
            "message": "[INFO] Retrying database connection..."
        },
        {
            "timestamp": '$((base_timestamp + 5000))',
            "message": "[INFO] Database connection restored successfully"
        },
        {
            "timestamp": '$((base_timestamp + 6000))',
            "message": "[DEBUG] Processing user request: GET /api/users"
        },
        {
            "timestamp": '$((base_timestamp + 7000))',
            "message": "[INFO] Request processed successfully in 245ms"
        },
        {
            "timestamp": '$((base_timestamp + 8000))',
            "message": "[WARN] Slow query detected: SELECT * FROM users took 2.3 seconds"
        },
        {
            "timestamp": '$((base_timestamp + 9000))',
            "message": "[INFO] Health check passed: All systems operational"
        }
    ]'
    
    aws logs put-log-events \
        --log-group-name "$log_group_name" \
        --log-stream-name "$log_stream_name" \
        --log-events "$log_events" \
        --region "$AWS_REGION" > /dev/null
    
    echo "✅ Added sample logs to $log_group_name"
}

# Create 10 empty Lambda log groups
echo "📁 Creating 10 empty Lambda log groups..."
for i in {1..10}; do
    create_log_group "${LOG_GROUP_PREFIX_LAMBDA}-${i}"
done

# Create 5 application log groups with sample data
echo "📁 Creating 5 application log groups with sample data..."
for i in {1..5}; do
    log_group_name="${LOG_GROUP_PREFIX_APP}-${i}"
    log_stream_name="$(date +%Y/%m/%d)/instance-$(printf "%03d" $i)"
    app_name="Application-${i}"
    
    create_log_group "$log_group_name"
    add_sample_logs "$log_group_name" "$log_stream_name" "$app_name"
done

# Verify setup
echo "🔍 Verifying log groups setup..."
total_groups=$(aws logs describe-log-groups --region "$AWS_REGION" --query 'length(logGroups[?starts_with(logGroupName, `/aws/lambda/test-function`) || starts_with(logGroupName, `/aws/ec2/application`)])' --output text)

echo "📊 Setup Summary:"
echo "   • Total log groups created: $total_groups"
echo "   • Empty Lambda log groups: 10"
echo "   • Application log groups with data: 5"
echo "   • Region: $AWS_REGION"

if [ "$total_groups" -eq 15 ]; then
    echo "✅ CloudWatch log groups setup completed successfully!"
    echo ""
    echo "🎯 Next steps:"
    echo "   1. Ensure Kagent and CloudWatch MCP server are running"
    echo "   2. Create your AI agent in the Kagent UI"
    echo "   3. Start querying the log groups!"
else
    echo "⚠️  Expected 15 log groups but found $total_groups. Please check for errors above."
fi

echo ""
echo "🔗 Useful commands for verification:"
echo "   aws logs describe-log-groups --region $AWS_REGION --query 'logGroups[?starts_with(logGroupName, \`/aws/lambda/test-function\`) || starts_with(logGroupName, \`/aws/ec2/application\`)].logGroupName' --output table"
echo "   aws logs describe-log-streams --log-group-name '/aws/ec2/application-1' --region $AWS_REGION"
