# Step 07: Test Updated MCP Server

## Overview

Before deploying to Kubernetes, let's test your new cryptocurrency price tool locally. This step ensures everything works correctly and helps you understand how the tool behaves.

## Start the Updated MCP Server

From your project directory, run:

```bash
kmcp run --project-dir crypto-price-mcp
```

### Expected Output

You should now see TWO tools registered:

```
🚀 Starting MCP server...
📦 Loading tools from src/tools/
✅ Registered tool: echo
✅ Registered tool: get_crypto_price
🔌 Server running on stdio transport
⏳ Waiting for connections...
```

Notice that both `echo` and `get_crypto_price` are loaded!

## Launch MCP Inspector

If you don't have the inspector running, start it in a new terminal:

```bash
npx @modelcontextprotocol/inspector
```

Open your browser to:
```
http://localhost:5173
```

## Connect to the Server

1. **Configure the connection**:
   - Transport Type: `stdio`
   - Command: `kmcp run --project-dir crypto-price-mcp`

2. **Click "Connect"**

3. **Verify connection**: You should see "Connected" status

## List Available Tools

1. Navigate to the **Tools** tab
2. Click **"List Tools"**
3. You should now see **two tools**:
   - `echo`
   - `get_crypto_price`

## Test the Crypto Price Tool

Let's test the new tool with different scenarios:

### Test 1: Default Parameters (Bitcoin in USD)

1. **Select** `get_crypto_price` from the tools list
2. **Leave parameters empty** (will use defaults)
3. **Click "Run Tool"**

**Expected Result**:
```json
{
  "content": [
    {
      "type": "text",
      "text": "{\"symbol\": \"bitcoin\", \"currency\": \"USD\", \"price\": 43250.50}"
    }
  ]
}
```

The price will be the current live Bitcoin price!

### Test 2: Ethereum Price

1. **Select** `get_crypto_price`
2. **Set parameters**:
   - `symbol`: `ethereum`
   - `currency`: `usd`
3. **Click "Run Tool"**

**Expected Result**:
```json
{
  "symbol": "ethereum",
  "currency": "USD",
  "price": 2280.75
}
```

### Test 3: Bitcoin in EUR

1. **Select** `get_crypto_price`
2. **Set parameters**:
   - `symbol`: `bitcoin`
   - `currency`: `eur`
3. **Click "Run Tool"**

**Expected Result**:
```json
{
  "symbol": "bitcoin",
  "currency": "EUR",
  "price": 39850.25
}
```

### Test 4: Invalid Cryptocurrency

Let's test error handling:

1. **Select** `get_crypto_price`
2. **Set parameters**:
   - `symbol`: `fakecoin`
   - `currency`: `usd`
3. **Click "Run Tool"**

**Expected Result**:
```json
{
  "error": "No price data found for 'fakecoin' in 'usd'"
}
```

Great! The error handling works correctly.

## Understanding the Tool Behavior

### What Just Happened?

When you ran the tool:

1. **MCP Inspector sent a request** to your local server
2. **Server called** `get_crypto_price()` function
3. **Function made HTTP request** to CoinGecko API
4. **API returned** current price data
5. **Function formatted** the response
6. **Server sent response** back to inspector
7. **Inspector displayed** the result

This is exactly how K-Agent will use your tool in production!


## Summary

You've successfully tested your custom MCP tool locally! The tool correctly fetches live cryptocurrency prices and handles errors gracefully.

**Key Takeaways**:
- ✅ Local testing catches issues before deployment
- ✅ MCP Inspector provides interactive tool testing
- ✅ Error handling prevents tool failures from breaking agents
- ✅ Default parameters make tools easier to use
- ✅ The same protocol is used in production

## What's Next?

Now that your tool works locally, it's time to build a container image so you can deploy it to Kubernetes.

---

**Next Step**: [Step 08: Build MCP Server Image](step08.md)
