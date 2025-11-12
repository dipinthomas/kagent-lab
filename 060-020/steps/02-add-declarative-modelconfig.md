# Step 02: Add declarative.modelConfig and stream

## Goal
Extend the YAML with the `spec.declarative` block including `modelConfig` and `stream`.

## Instructions
Append the following under `spec:`:
- `declarative.modelConfig: default-model-config`
- `declarative.stream: true`

## Validation
- YAML includes `spec.declarative.modelConfig` and `spec.declarative.stream`.

## Expected YAML Diff (conceptual)
```yaml
spec:
  declarative:
    modelConfig: default-model-config
    stream: true
```

Proceed to Step 03 after saving.
