#!/bin/bash

# Test script for the fixed version detection logic
# This simulates the GitHub Actions environment

echo "🧪 Testing Fixed Version Detection Script"
echo "=========================================="

# Test 1: Main branch (development)
echo ""
echo "Test 1: Main branch (development)"
echo "--------------------------------"
export GITHUB_REF="refs/heads/main"
export deployment_branch="gh-pages"
export jekyll_config="_config/_config.yml"
export GITHUB_OUTPUT="/tmp/test_output_1"

# Create a mock Jekyll config
mkdir -p _config
echo "baseurl: '/myproject'" > _config/_config.yml

# Run the fixed script
bash fixed-version-detection.sh

echo "Output:"
cat $GITHUB_OUTPUT
echo ""

# Test 2: Release branch (stable)
echo ""
echo "Test 2: Release branch (stable)"
echo "-------------------------------"
export GITHUB_REF="refs/heads/release/v1.2.3"
export GITHUB_OUTPUT="/tmp/test_output_2"

bash fixed-version-detection.sh

echo "Output:"
cat $GITHUB_OUTPUT
echo ""

# Test 3: Tag (stable)
echo ""
echo "Test 3: Tag (stable)"
echo "--------------------"
export GITHUB_REF="refs/tags/v2.0.0"
export GITHUB_OUTPUT="/tmp/test_output_3"

bash fixed-version-detection.sh

echo "Output:"
cat $GITHUB_OUTPUT
echo ""

# Test 4: Other branch (preview)
echo ""
echo "Test 4: Other branch (preview)"
echo "------------------------------"
export GITHUB_REF="refs/heads/feature/new-feature"
export GITHUB_OUTPUT="/tmp/test_output_4"

bash fixed-version-detection.sh

echo "Output:"
cat $GITHUB_OUTPUT
echo ""

# Cleanup
rm -f /tmp/test_output_*
rm -rf _config

echo "✅ All tests completed!"