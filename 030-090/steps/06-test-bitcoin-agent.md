# Step 6: Testing Bitcoin Price Agent

In this step, we'll create and test an AI agent that interacts with our Bitcoin Price MCP server.

## 1. Deploy the Agent

First, deploy the Bitcoin Price agent:

```bash
# Deploy the agent
kubectl apply -f support-code/bitcoin-agent.yaml
```

## 2. Verify Agent Deployment

Check that the agent is running:

```bash
# Check pod status
kubectl get pods -l app=bitcoin-price-agent

# Check logs
kubectl logs -l app=bitcoin-price-agent
```

## 3. Test the Agent

You can test the agent using various queries:

### Basic Price Queries
```bash
# Get Bitcoin price in USD
curl -X POST http://localhost:8080/query \
  -H "Content-Type: application/json" \
  -d '{"query": "What is the current Bitcoin price in USD?"}'

# Get Ethereum price in EUR
curl -X POST http://localhost:8080/query \
  -H "Content-Type: application/json" \
  -d '{"query": "Show me Ethereum price in EUR"}'
```

### Example Queries to Try

1. Basic Price Check:
   ```
   What is the current Bitcoin price?
   ```

2. Different Currencies:
   ```
   Show me the Ethereum price in EUR
   What's the Bitcoin price in JPY?
   ```

3. Multiple Cryptocurrencies:
   ```
   Compare Bitcoin and Ethereum prices
   ```

## 4. Understanding Agent Responses

The agent will respond with:
```json
{
    "response": "Current Bitcoin Price: USD 35,420.50\n\nNote: Cryptocurrency prices are highly volatile. This price was fetched at 2025-11-06 10:06:23 UTC.",
    "tool_calls": [
        {
            "name": "get_crypto_price",
            "arguments": {
                "symbol": "bitcoin",
                "currency": "usd"
            },
            "result": {
                "symbol": "bitcoin",
                "currency": "usd",
                "price": 35420.50
            }
        }
    ]
}
```

## 5. Error Handling

The agent handles common errors:
- Invalid cryptocurrency symbols
- Unsupported currencies
- API rate limits
- Network issues

Example error response:
```json
{
    "response": "Sorry, I encountered an error: No price data found for 'invalid_coin'",
    "error": true
}
```

## 6. Best Practices

1. **Rate Limiting**
   - Avoid rapid repeated queries
   - Use caching when appropriate
   - Respect API limits

2. **Error Handling**
   - Always check for error responses
   - Handle timeouts gracefully
   - Provide clear error messages

3. **Data Validation**
   - Verify cryptocurrency symbols
   - Validate currency codes
   - Check price ranges

## Next Steps

1. Experiment with different cryptocurrencies
2. Try various currency combinations
3. Test error scenarios
4. Monitor agent performance

## Troubleshooting

If you encounter issues:
1. Check MCP server connectivity
2. Verify agent pod status
3. Review agent logs
4. Check network policies
