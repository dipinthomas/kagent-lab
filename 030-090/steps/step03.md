# Step 03: Create MCP Server Scaffold

## Overview

In this step, you'll create your first MCP server project using the `kmcp init` command. This will generate a complete project structure with everything you need to start building custom tools.

## Initialize the Project

Run the following command to create a new Python-based MCP server:

```bash
kmcp init python crypto-price-mcp
```

### What Happens

The `kmcp init` command will:
1. Create a new directory called `crypto-price-mcp`
2. Generate the project structure
3. Create configuration files
4. Add a sample "echo" tool
5. Set up dependency management

### Expected Output

You should see output similar to:

```
✅ Successfully initialized MCP server project: crypto-price-mcp
📁 Project type: python
📦 Created project structure
🔧 Generated configuration files
✨ Added sample 'echo' tool

Next steps:
1. cd crypto-price-mcp
2. Review the generated files
3. Run 'kmcp run --project-dir crypto-price-mcp' to start the server
```

## Explore the Project Structure

Navigate into the project directory and examine its structure:

```bash
cd crypto-price-mcp
ls -la
```

### Project Layout

Your project should have the following structure:

```
crypto-price-mcp/
├── kmcp.yaml              # Project configuration
├── pyproject.toml         # Python dependencies
├── uv.lock                # Dependency lock file
├── README.md              # Project documentation
├── src/
│   ├── main.py           # Server entry point
│   ├── core/
│   │   ├── server.py     # MCP server setup
│   │   └── utils.py      # Helper utilities
│   └── tools/
│       ├── __init__.py   # Tool registration
│       └── echo.py       # Sample echo tool
└── tests/
    └── test_echo.py      # Tool tests
```

## Key Files Explained

### 1. `kmcp.yaml`

The main configuration file for your MCP server:

```bash
cat kmcp.yaml
```

This file contains:
- Project metadata (name, version)
- Tool configurations
- Environment variables
- Deployment settings

### 2. `src/main.py`

The entry point for your MCP server:

```bash
cat src/main.py
```

This file:
- Initializes the MCP server
- Registers tools
- Starts the server process

### 3. `src/tools/echo.py`

A sample tool that comes with the scaffold:

```bash
cat src/tools/echo.py
```

This demonstrates:
- How to define a tool
- Tool decorator usage
- Parameter handling
- Return value formatting

## Understanding the Echo Tool

The generated `echo` tool is a simple example that takes a message and echoes it back. Let's examine it:

```python
@mcp.tool()
def echo(message: str) -> str:
    """Echo tool implementation.
    
    Args:
        message: Input message to echo
    
    Returns:
        str: The echoed message
    """
    config = get_tool_config("echo")
    prefix = config.get("prefix", "echo: ")
    return f"{prefix}{message}"
```

**Key Components**:
- `@mcp.tool()`: Decorator that registers the function as an MCP tool
- **Type hints**: Define input and output types
- **Docstring**: Describes the tool (used by AI agents)
- **Configuration**: Tools can read settings from `kmcp.yaml`

## Quiz

**Question**: What is the purpose of the `kmcp.yaml` file in an MCP server project?

**Options**:
- A) It contains the Python source code for tools
- B) It's the main configuration file for the MCP server project
- C) It stores test cases for the tools
- D) It's used only for deployment to Kubernetes


**Answer: B) It's the main configuration file for the MCP server project**

The `kmcp.yaml` file is the central configuration file that contains project metadata, tool configurations, environment variables, and deployment settings. It's used throughout the development lifecycle, not just for deployment.


## Verify Dependencies

Check that all dependencies are properly set up:

```bash
cat pyproject.toml
```

You should see dependencies like:
- `fastmcp`: The MCP server framework
- `pydantic`: For data validation
- Other utility libraries

## Summary

You've successfully created your first MCP server project! The scaffold provides everything you need to start building custom tools.

**Key Takeaways**:
- ✅ `kmcp init` creates a complete project structure
- ✅ The project includes a sample `echo` tool as a reference
- ✅ Configuration is managed through `kmcp.yaml`
- ✅ Tools are defined in `src/tools/` directory
- ✅ The `@mcp.tool()` decorator registers functions as tools

## What's Next?

In the next step, you'll run this MCP server locally and test the echo tool using the MCP Inspector.

---

**Next Step**: [Step 04: Run MCP Server Locally](step04.md)
