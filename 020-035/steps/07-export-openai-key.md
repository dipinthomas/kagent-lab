# Step 7: Export OpenAI API key

Set the `OPENAI_API_KEY` environment variable.

```bash
export OPENAI_API_KEY="your-api-key-here"
```

Validation (to be performed):

```bash
# 1) Confirm it is set (without printing the secret)
[ -n "$OPENAI_API_KEY" ] && echo "OPENAI_API_KEY is set" || echo "OPENAI_API_KEY is NOT set"

# 2) (Optional) Show the length only
echo "Length: ${#OPENAI_API_KEY}"
```
