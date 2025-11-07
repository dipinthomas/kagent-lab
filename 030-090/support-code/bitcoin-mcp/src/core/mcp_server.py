from fastapi import FastAPI
from fastmcp import FastMCP
from tools.crypto_price import get_crypto_price

def create_app():
    app = FastAPI(title="Crypto Price MCP Server")
    server = FastMCP(app)
    server.add_tool(
        get_crypto_price,
        name="get_crypto_price",
        description="Get the current price of a cryptocurrency in a specified currency"
    )
    return app
