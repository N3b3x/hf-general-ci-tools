#!/bin/bash
# Simple script to inject API links into Jekyll _config.yml
# This script should be called from the docs.yml workflow

set -e

# Configuration
CONFIG_FILE="${1:-_config/_config.yml}"
VERSION="${2:-development}"
VERSION_TYPE="${3:-development}"
REPO_NAME="${4:-hf-general-ci-tools}"

# Generate baseurl based on version type
if [ "$VERSION_TYPE" = "release" ] || [ "$VERSION_TYPE" = "release-candidate" ]; then
    BASEURL="/$REPO_NAME/$VERSION"
else
    BASEURL="/$REPO_NAME"
fi

# Generate API URL
API_URL="$BASEURL/doxs/index.html"

echo "🔧 Injecting API links into Jekyll configuration..."
echo "📋 Version: $VERSION"
echo "🏷️  Type: $VERSION_TYPE"
echo "🔗 Base URL: $BASEURL"
echo "📖 API URL: $API_URL"
echo "📄 Config file: $CONFIG_FILE"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Error: Config file $CONFIG_FILE not found!"
    exit 1
fi

# Create backup
cp "$CONFIG_FILE" "${CONFIG_FILE}.backup"
echo "💾 Backup created: ${CONFIG_FILE}.backup"

# Create a temporary file for the new config
TEMP_FILE=$(mktemp)

# Process the config file
python3 << EOF
import re
import sys

# Read the config file
with open('$CONFIG_FILE', 'r') as f:
    content = f.read()

# Configuration
api_url = '$API_URL'
baseurl = '$BASEURL'
version = '$VERSION'
version_type = '$VERSION_TYPE'

# Remove existing API Reference entries
content = re.sub(r'  "📖 API Reference":\s*\n\s*-\s*"[^"]*"\s*\n', '', content)
content = re.sub(r'    - title: "📖 API Reference"\s*\n\s*url: [^\n]*\s*\n', '', content)

# Add API Reference to aux_links
aux_links_pattern = r'(aux_links:\s*\n(?:  "[^"]*":\s*\n(?:    - "[^"]*"\s*\n)*)*)'
def add_to_aux_links(match):
    aux_section = match.group(1)
    if '📖 API Reference' not in aux_section:
        # Find the last entry and add after it
        lines = aux_section.split('\n')
        # Add the API reference
        api_entry = f'  "📖 API Reference":\n    - "{api_url}"\n'
        return aux_section + api_entry
    return aux_section

content = re.sub(aux_links_pattern, add_to_aux_links, content, flags=re.MULTILINE)

# Add API Reference to nav_external_links
nav_pattern = r'(nav_external_links:\s*\n(?:    - title: "[^"]*"\s*\n\s*url: [^\n]*\s*\n)*)'
def add_to_nav_links(match):
    nav_section = match.group(1)
    if '📖 API Reference' not in nav_section:
        # Add the API reference
        api_entry = f'    - title: "📖 API Reference"\n      url: {api_url}\n'
        return nav_section + api_entry
    return nav_section

content = re.sub(nav_pattern, add_to_nav_links, content, flags=re.MULTILINE)

# Update baseurl
content = re.sub(r'baseurl: "[^"]*"', f'baseurl: "{baseurl}"', content)

# Update title with version if it's a release
if version_type == "release":
    content = re.sub(r'title: "[^"]*"', f'title: "hf-general-ci-tools - {version}"', content)

# Write the updated content
with open('$TEMP_FILE', 'w') as f:
    f.write(content)

print("✅ Configuration updated successfully")
EOF

# Replace the original file
mv "$TEMP_FILE" "$CONFIG_FILE"

echo "✅ API link injection completed successfully!"
echo "📖 API documentation will be available at: $API_URL"

# Verify the changes
echo ""
echo "🔍 Verifying configuration changes..."
echo "=== aux_links section ==="
grep -A 10 "aux_links:" "$CONFIG_FILE" || echo "No aux_links section found"

echo ""
echo "=== nav_external_links section ==="
grep -A 10 "nav_external_links:" "$CONFIG_FILE" || echo "No nav_external_links section found"

echo ""
echo "=== baseurl ==="
grep "baseurl:" "$CONFIG_FILE"