from typing import Dict, Any
from fastmcp import Tool, ToolCall

class Calculator(Tool):
    name = "calculator"
    description = "Perform basic arithmetic operations"
    
    async def execute(self, call: ToolCall) -> Dict[str, Any]:
        """
        Execute arithmetic operations
        
        Arguments:
            operation: One of "add", "subtract", "multiply", "divide"
            a: First number
            b: Second number
            
        Returns:
            Dictionary containing the result and operation details
        """
        op = call.arguments.get("operation")
        a = float(call.arguments.get("a", 0))
        b = float(call.arguments.get("b", 0))
        
        result = 0
        if op == "add":
            result = a + b
        elif op == "subtract":
            result = a - b
        elif op == "multiply":
            result = a * b
        elif op == "divide":
            if b == 0:
                raise ValueError("Cannot divide by zero")
            result = a / b
        else:
            raise ValueError(f"Unknown operation: {op}")
            
        return {
            "result": result,
            "operation": op,
            "a": a,
            "b": b
        }
