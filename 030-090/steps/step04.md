# Step 04: Run MCP Server Locally

## Overview

Before deploying to Kubernetes, it's essential to test your MCP server locally. In this step, you'll run your server and use the MCP Inspector tool to interact with it.

## Start the MCP Server

From your project directory, run:

```bash
kmcp run --project-dir crypto-price-mcp
```

### Expected Output

You should see output indicating the server has started:

```
🚀 Starting MCP server...
📦 Loading tools from src/tools/
✅ Registered tool: echo
🔌 Server running on stdio transport
⏳ Waiting for connections...
```
This should open the MCP Inspector in your default browser.

![alt text](image.png)
**Note**: The server will continue running in this terminal. Keep it running for the next steps.

## Install MCP Inspector (Might be needed for kodekloud lab)

The MCP Inspector is a web-based tool for testing MCP servers. Install it globally using npm:

```bash
npm install -g @modelcontextprotocol/inspector
```

### What is MCP Inspector?

MCP Inspector is a debugging and testing tool that provides:
- **Visual Interface**: Browse available tools
- **Interactive Testing**: Call tools with custom parameters
- **Response Inspection**: View tool outputs and errors
- **Protocol Debugging**: See the underlying MCP messages

Think of it as Postman for MCP servers!

### Expected Output

```
added 1 package in 2s
```

## Launch MCP Inspector

Open a new terminal window and start the inspector:

```bash
npx @modelcontextprotocol/inspector
```

### Expected Output

```
MCP Inspector running at http://localhost:5173
```

## Connect to Your MCP Server

1. **Open your browser** and navigate to:
   ```
   http://localhost:5173
   ```

2. **You'll see the MCP Inspector interface** with a connection dialog

3. **Configure the connection**:
   - **Transport Type**: Select `stdio`
   - **Command**: Enter the path to your MCP server
     ```
     kmcp run --project-dir crypto-price-mcp
     ```
   
4. **Click "Connect"**

### Connection Success

Once connected, you should see:
- ✅ Connection status: "Connected"
- 📋 Available tools listed in the sidebar
- 🔧 The "echo" tool should be visible

## Test the Echo Tool

Now let's test the sample echo tool:

### Step-by-Step Testing

1. **Navigate to the Tools tab** in the left sidebar

2. **Click "List Tools"** to see all available tools

3. **Select the `echo` tool** from the list

4. **You'll see the tool details**:
   - Tool name: `echo`
   - Description: "Echo tool implementation"
   - Parameters: `message` (string)

5. **Enter a test message**:
   - In the `message` field, type: `Hello from MCP Inspector!`

6. **Click "Run Tool"**

### Expected Result

In the "Tool Result" card, you should see:

```json
{
  "content": [
    {
      "type": "text",
      "text": "echo: Hello from MCP Inspector!"
    }
  ]
}
```
![alt text](image-1.png)
![alt text](image-2.png)

## Understanding the Response

The MCP protocol returns structured responses:
- **content**: Array of response items
- **type**: Content type (text, image, etc.)
- **text**: The actual tool output

## Experiment with Different Inputs

Try testing with different messages:

```
Test 1: "Testing MCP tools"
Test 2: "This is amazing!"
Test 3: "Ready for crypto prices"
```

Each should return with the "echo: " prefix.

## Behind the Scenes

When you run a tool through the inspector:

```
1. Inspector sends MCP request → 
2. Server receives and validates →
3. Tool function executes →
4. Result formatted as MCP response →
5. Inspector displays the result
```

This is the same flow that K-Agent uses when calling your tools!

## Summary

You've successfully run your MCP server locally and tested it using the MCP Inspector. This workflow is crucial for rapid development and debugging.

**Key Takeaways**:
- ✅ `kmcp run` starts the server locally for testing
- ✅ MCP Inspector provides a visual interface for tool testing
- ✅ Tools can be tested interactively before deployment
- ✅ The same protocol is used by AI agents in production

## What's Next?

Now that you know how to test tools locally, you'll add a custom cryptocurrency price lookup tool to your server.

---

**Next Step**: [Step 05: Add New Tool to MCP Server](step05.md)
