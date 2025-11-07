import requests
from typing import Dict

from core.server import mcp
from core.utils import get_tool_config


@mcp.tool()
def get_crypto_price(symbol: str = "bitcoin", currency: str = "usd") -> Dict:
    """Get the current price of a cryptocurrency in a specified currency.
    
    Args:
        symbol: The cryptocurrency symbol (e.g., bitcoin, ethereum)
        currency: The currency to get the price in (e.g., usd, eur)
    
    Returns:
        Dict containing the price information or error message
    """
    url = f"https://api.coingecko.com/api/v3/simple/price?ids={symbol}&vs_currencies={currency}"
    resp = requests.get(url)
    if resp.status_code != 200:
        return {"error": f"Failed to fetch price: {resp.status_code}"}
    data = resp.json()
    price = data.get(symbol, {}).get(currency)
    if not price:
        return {"error": f"No price data found for '{symbol}'."}
    return {"symbol": symbol, "currency": currency, "price": price}
