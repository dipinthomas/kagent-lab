# Step 05: Add New Tool to MCP Server

## Overview

Now that you've tested the sample echo tool, it's time to add your own custom tool. You'll use the `kmcp add-tool` command to scaffold a new tool for fetching cryptocurrency prices.

## Stop the Running Server

If your MCP server is still running from the previous step:

1. Go to the terminal where `kmcp run` is running
2. Press `Ctrl+C` to stop the server

## Add the Crypto Price Tool

Run the following command to add a new tool:

```bash
kmcp add-tool crypto_price --project-dir crypto-price-mcp
```

### What This Command Does

The `kmcp add-tool` command will:
1. Create a new tool file: `src/tools/crypto_price.py`
2. Generate a template implementation
3. Update `src/tools/__init__.py` to register the new tool
4. Create a test file: `tests/test_crypto_price.py`

### Expected Output

```
✅ Successfully created tool: crypto_price
📁 Generated file: src/tools/crypto_price.py
🔄 Updated tools/__init__.py with new tool import

Next steps:
1. Edit src/tools/crypto_price.py to implement your tool logic
2. Configure any required environment variables in kmcp.yaml
3. Run 'kmcp run --project-dir crypto-price-mcp' to start the server
4. Run 'uv run pytest tests/' to test your tool
```

## Examine the Generated Tool File

Let's look at what was generated:

```bash
cat crypto-price-mcp/src/tools/crypto_price.py
```

### Template Structure

You'll see a template that looks like this:

```python
"""Crypto_price tool for MCP server.
"""

from core.server import mcp
from core.utils import get_tool_config


@mcp.tool()
def crypto_price(message: str) -> str:
    """Crypto_price tool implementation.

    This is a template function. Replace this implementation with your tool logic.

    Args:
        message: Input message (replace with your actual parameters)

    Returns:
        str: Result of the tool operation (replace with your actual return type)
    """
    # Get tool-specific configuration from kmcp.yaml
    config = get_tool_config("crypto_price")

    # TODO: Replace this basic implementation with your tool logic

    # Example: Basic text processing
    prefix = config.get("prefix", "echo: ")
    return f"{prefix}{message}"
```

## Understanding the Template

The generated template includes:

1. **Import statements**: Required modules for MCP tools
2. **Tool decorator**: `@mcp.tool()` registers the function
3. **Function signature**: Defines parameters and return type
4. **Docstring**: Describes the tool (important for AI agents!)
5. **Configuration access**: Shows how to read from `kmcp.yaml`
6. **TODO comment**: Reminder to implement actual logic

## Verify Tool Registration

Check that the tool was added to the imports:

```bash
cat crypto-price-mcp/src/tools/__init__.py
```

You should see both tools imported:

```python
from .echo import echo
from .crypto_price import crypto_price

__all__ = ["echo", "crypto_price"]
```

This ensures both tools are registered when the server starts.

## Check the Test File

A test template was also created:

```bash
cat crypto-price-mcp/tests/test_crypto_price.py
```

This provides a starting point for unit testing your tool.

## Quiz

**Question**: What is the purpose of the `@mcp.tool()` decorator in an MCP server?

**Options**:
- A) It makes the function run faster
- B) It registers the function as an MCP tool that can be called by agents
- C) It adds error handling to the function
- D) It converts the function to asynchronous code


**Answer: B) It registers the function as an MCP tool that can be called by agents**

The `@mcp.tool()` decorator is essential for exposing a Python function as an MCP tool. Without this decorator, the function would just be a regular Python function and wouldn't be discoverable or callable through the MCP protocol.


## Understanding Tool Discovery

When an AI agent connects to your MCP server, it:

1. **Queries available tools** using the MCP protocol
2. **Reads tool metadata** (name, description, parameters)
3. **Understands capabilities** from docstrings
4. **Calls tools** when needed to answer user queries

The `@mcp.tool()` decorator makes all of this possible!

## What's in a Tool Name?

Tool naming conventions:
- **Use snake_case**: `crypto_price`, not `cryptoPrice` or `CryptoPrice`
- **Be descriptive**: The name should indicate what the tool does
- **Keep it concise**: Shorter names are easier for agents to work with
- **Avoid special characters**: Stick to letters, numbers, and underscores

## Summary

You've successfully added a new tool scaffold to your MCP server. The template provides the structure, and in the next step, you'll implement the actual cryptocurrency price lookup logic.

**Key Takeaways**:
- ✅ `kmcp add-tool` generates tool scaffolds automatically
- ✅ Tools are Python functions decorated with `@mcp.tool()`
- ✅ Tool registration happens in `src/tools/__init__.py`
- ✅ Docstrings are crucial for AI agents to understand tool capabilities
- ✅ Test files are generated to encourage testing

## What's Next?

In the next step, you'll replace the template code with actual implementation that fetches real-time cryptocurrency prices from the CoinGecko API.

---

**Next Step**: [Step 06: Implement Crypto Price Tool](step06.md)
