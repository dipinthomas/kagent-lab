from core.mcp_server import create_app
import asyncio

app = create_app()

async def main():
    # Keep the server running
    while True:
        await asyncio.sleep(1)

if __name__ == "__main__":
    asyncio.run(main())
