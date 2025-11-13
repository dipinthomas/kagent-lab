# Step 06: Implement Crypto Price Tool

## Overview

Now it's time to replace the template code with actual functionality. You'll implement a tool that fetches real-time cryptocurrency prices from the CoinGecko API.

## The Implementation

We've provided a complete implementation of the `get_crypto_price` tool. Let's examine it before you use it.

### View the Provided Implementation

The implementation file is located at:
```
support-code/crypto_price.py
```

Let's examine the key parts:

```python
import requests
from core.server import mcp
from core.utils import get_tool_config


@mcp.tool()
def get_crypto_price(symbol: str = "bitcoin", currency: str = "usd") -> dict:
    """Fetch the current live price for a cryptocurrency.
    
    Args:
        symbol: Cryptocurrency symbol (e.g., 'bitcoin', 'ethereum', 'cardano')
        currency: Target currency (e.g., 'usd', 'eur', 'gbp')
    
    Returns:
        dict: Price information including symbol, currency, and current price
    """
    url = f"https://api.coingecko.com/api/v3/simple/price?ids={symbol}&vs_currencies={currency}"
    
    try:
        resp = requests.get(url, timeout=10)
        if resp.status_code != 200:
            return {"error": f"Failed to fetch price: HTTP {resp.status_code}"}
        
        data = resp.json()
        price = data.get(symbol, {}).get(currency)
        
        if not price:
            return {"error": f"No price data found for '{symbol}' in '{currency}'"}
        
        return {
            "symbol": symbol,
            "currency": currency.upper(),
            "price": price
        }
    except requests.exceptions.Timeout:
        return {"error": "Request timed out. Please try again."}
    except requests.exceptions.RequestException as e:
        return {"error": f"Request failed: {str(e)}"}
    except Exception as e:
        return {"error": f"Unexpected error: {str(e)}"}
```

## Understanding the Implementation

Let's break down the key components:

### 1. **Imports**
```python
import requests
```
- Uses the `requests` library to make HTTP calls to the CoinGecko API

### 2. **Function Signature**
```python
def get_crypto_price(symbol: str = "bitcoin", currency: str = "usd") -> dict:
```
- **Default parameters**: Makes the tool easy to use (just call it without args for Bitcoin price)
- **Type hints**: Helps with validation and documentation
- **Returns dict**: Structured data that's easy for agents to parse

### 3. **Comprehensive Docstring**
```python
"""Fetch the current live price for a cryptocurrency.
    
Args:
    symbol: Cryptocurrency symbol (e.g., 'bitcoin', 'ethereum', 'cardano')
    currency: Target currency (e.g., 'usd', 'eur', 'gbp')

Returns:
    dict: Price information including symbol, currency, and current price
"""
```
- **Critical for AI agents**: They read this to understand what the tool does
- **Examples included**: Helps agents know valid input values
- **Clear return description**: Agents know what to expect

### 4. **API Integration**
```python
url = f"https://api.coingecko.com/api/v3/simple/price?ids={symbol}&vs_currencies={currency}"
resp = requests.get(url, timeout=10)
```
- Uses CoinGecko's free API (no API key required)
- Includes timeout to prevent hanging
- Constructs URL with user parameters

### 5. **Error Handling**
```python
try:
    # ... API call ...
except requests.exceptions.Timeout:
    return {"error": "Request timed out. Please try again."}
except requests.exceptions.RequestException as e:
    return {"error": f"Request failed: {str(e)}"}
```
- **Graceful degradation**: Returns error messages instead of crashing
- **Specific exceptions**: Different handling for different error types
- **User-friendly messages**: Helps debug issues

### 6. **Response Validation**
```python
if not price:
    return {"error": f"No price data found for '{symbol}' in '{currency}'"}
```
- Checks if the API returned valid data
- Provides helpful error messages

## Quiz

**Question**: Why is it important to include detailed docstrings in MCP tool functions?

**Options**:
- A) Docstrings make the code run faster
- B) AI agents read docstrings to understand what the tool does and how to use it
- C) Docstrings are only for human developers
- D) Docstrings are required by Python syntax


**Answer: B) AI agents read docstrings to understand what the tool does and how to use it**

Docstrings are crucial in MCP tools because AI agents use them to understand the tool's purpose, parameters, and expected outputs. A well-written docstring helps the agent decide when and how to use the tool. This is different from regular code where docstrings are primarily for human developers.


## Replace the Template Code

Now, replace the template implementation with the actual code:

```bash
cp support-code/crypto_price.py crypto-price-mcp/src/tools/crypto_price.py
```

### Verify the Update

Check that the file was updated correctly:

```bash
cat crypto-price-mcp/src/tools/crypto_price.py
```

You should see the complete implementation with:
- ✅ `requests` import
- ✅ `get_crypto_price` function
- ✅ Comprehensive error handling
- ✅ Detailed docstring


## Summary

You've successfully implemented a real-world MCP tool that integrates with an external API. This pattern can be applied to any API or service you want to make available to AI agents.

**Key Takeaways**:
- ✅ MCP tools can integrate with external APIs
- ✅ Error handling is crucial for production tools
- ✅ Detailed docstrings help AI agents use tools correctly
- ✅ Default parameters make tools easier to use
- ✅ Structured return values (dict) are easier to parse

## What's Next?

Now that you've implemented the tool, it's time to test it locally using the MCP Inspector to ensure it works correctly before deployment.

---

**Next Step**: [Step 07: Test Updated MCP Server](step07.md)
