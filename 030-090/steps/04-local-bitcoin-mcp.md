# Step 4: Running Bitcoin Price MCP Server Locally

In this step, we'll run the Bitcoin Price MCP server locally and connect to it using the MCP inspector tool.

## 1. Run the Server

Start the MCP server using the `kmcp` CLI:

```bash

# Run the server
kmcp run --project-dir .
```

Note: Save the Proxy Session Token displayed in the output!

## 2. Connect to Local Inspector

Configure the MCP Inspector tool:

1. Open the MCP Inspector in your browser
2. Configure connection settings:
   - Transport Type: Select "STDIO"
   - Command: Enter "uv"
   - Arguments: Enter "run python src/main.py"
   - Configuration: Enter your Proxy Session Token
3. Click "Connect"

Note: It might take a few seconds to connect. If it fails, verify your settings.

## 3. Connect to MCP Inspector

1. Open the MCP Inspector tool in your browser
2. Configure the connection:
   - Transport Type: Select "STDIO"
   - Command: Enter "uv"
   - Arguments: Enter "run python src/main.py"
   - Configuration: Paste your Proxy Session Token
3. Click "Connect"

## 4. Test the Crypto Price Tool

In the MCP Inspector:

1. Go to the "Tools" tab
2. Click "List Tools"
3. Select the "get_crypto_price" tool
4. Try these example queries:

```json
{
    "symbol": "bitcoin",
    "currency": "usd"
}
```

```json
{
    "symbol": "ethereum",
    "currency": "eur"
}
```

## 5. Understanding the Response

The tool returns:
```json
{
    "symbol": "bitcoin",
    "currency": "usd",
    "price": 35000.42
}
```

- `symbol`: The cryptocurrency requested
- `currency`: The currency for price conversion
- `price`: Current price in the specified currency

## 6. Troubleshooting

If you encounter connection issues:
1. Ensure the server is running (`kmcp run` command)
2. Verify the Proxy Session Token is correct
3. Check that the transport type and command settings match exactly

## Next Steps

Once you're comfortable with local testing:
1. Try different cryptocurrencies and currencies
2. Examine the API responses
3. Proceed to deploying on Kubernetes (Step 5)
