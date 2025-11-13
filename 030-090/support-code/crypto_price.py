"""Crypto price tool for MCP server.
"""

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
