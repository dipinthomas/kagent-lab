#!/bin/bash

# Setup script for Lab 010-010: The Power of Kagent
# This script sets up all 4 problems at once (for convenience)
# 
# NOTE: In the actual lab, each problem is set up individually using:
# - setup-problem-1.sh (before Step 1)
# - setup-problem-2.sh (before Step 2)
# - setup-problem-3.sh (before Step 3)
# - setup-problem-4.sh (before Step 4)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up all problems for Lab 010-010"
echo "======================================"
echo ""
echo "This script sets up all 4 problems at once."
echo "In the lab, each problem is set up individually before its troubleshooting step."
echo ""

# Run individual setup scripts
echo "Setting up Problem 1..."
bash ${SCRIPT_DIR}/setup-problem-1.sh

echo ""
echo "Setting up Problem 2..."
bash ${SCRIPT_DIR}/setup-problem-2.sh

echo ""
echo "Setting up Problem 3..."
bash ${SCRIPT_DIR}/setup-problem-3.sh

echo ""
echo "Setting up Problem 4..."
bash ${SCRIPT_DIR}/setup-problem-4.sh

echo ""
echo "======================================"
echo "All problems setup complete!"
echo ""
echo "All 4 broken scenarios are now deployed:"
echo "- Problem 1: Pod CrashLoopBackOff (crashloop-app deployment)"
echo "- Problem 2: Service not routing (broken-service)"
echo "- Problem 3: Resource exhaustion (memory-hungry-app)"
echo "- Problem 4: HPA not scaling (hpa-app)"
echo ""
echo "You can now proceed with the lab steps."

