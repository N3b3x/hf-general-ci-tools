#!/bin/bash
# Script to inject API links into Jekyll _config.yml
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

# Function to inject API link into aux_links
inject_aux_links() {
    local config_file="$1"
    local api_url="$2"
    
    if grep -q "aux_links:" "$config_file"; then
        echo "📝 Injecting API link into aux_links section..."
        
        # Remove existing API Reference if present
        sed -i '/"📖 API Reference":/,+1d' "$config_file"
        
        # Add API Reference after the last existing aux link
        if grep -q '"⭐ Star on GitHub":' "$config_file"; then
            sed -i '/"⭐ Star on GitHub":/a\  "📖 API Reference":\n    - "'"$api_url"'"' "$config_file"
        elif grep -q '"🐛 Report Issues":' "$config_file"; then
            sed -i '/"🐛 Report Issues":/a\  "📖 API Reference":\n    - "'"$api_url"'"' "$config_file"
        elif grep -q '"📚 GitHub Repository":' "$config_file"; then
            sed -i '/"📚 GitHub Repository":/a\  "📖 API Reference":\n    - "'"$api_url"'"' "$config_file"
        else
            # Add at the end of aux_links section
            sed -i '/aux_links:/a\  "📖 API Reference":\n    - "'"$api_url"'"' "$config_file"
        fi
        
        echo "✅ API link added to aux_links"
    else
        echo "⚠️  Warning: aux_links section not found in $config_file"
    fi
}

# Function to inject API link into nav_external_links
inject_nav_links() {
    local config_file="$1"
    local api_url="$2"
    
    if grep -q "nav_external_links:" "$config_file"; then
        echo "📝 Injecting API link into nav_external_links section..."
        
        # Remove existing API Reference if present
        sed -i '/- title: "📖 API Reference"/,+1d' "$config_file"
        
        # Add API Reference after the last existing nav link
        if grep -q 'title: "🐛 Issues"' "$config_file"; then
            sed -i '/title: "🐛 Issues"/a\    - title: "📖 API Reference"\n      url: '"$api_url" "$config_file"
        elif grep -q 'title: "📚 GitHub Repository"' "$config_file"; then
            sed -i '/title: "📚 GitHub Repository"/a\    - title: "📖 API Reference"\n      url: '"$api_url" "$config_file"
        else
            # Add at the end of nav_external_links section
            sed -i '/nav_external_links:/a\    - title: "📖 API Reference"\n      url: '"$api_url" "$config_file"
        fi
        
        echo "✅ API link added to nav_external_links"
    else
        echo "⚠️  Warning: nav_external_links section not found in $config_file"
    fi
}

# Function to update baseurl
update_baseurl() {
    local config_file="$1"
    local baseurl="$2"
    
    echo "📝 Updating baseurl to: $baseurl"
    sed -i "s|baseurl: \".*\"|baseurl: \"$baseurl\"|" "$config_file"
    echo "✅ Base URL updated"
}

# Function to update title with version
update_title() {
    local config_file="$1"
    local version="$2"
    local version_type="$3"
    
    if [ "$version_type" = "release" ]; then
        echo "📝 Updating title with version: $version"
        sed -i "s|title: \".*\"|title: \"hf-general-ci-tools - $version\"|" "$config_file"
        echo "✅ Title updated with version"
    fi
}

# Execute injections
inject_aux_links "$CONFIG_FILE" "$API_URL"
inject_nav_links "$CONFIG_FILE" "$API_URL"
update_baseurl "$CONFIG_FILE" "$BASEURL"
update_title "$CONFIG_FILE" "$VERSION" "$VERSION_TYPE"

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

echo ""
echo "✅ API link injection completed successfully!"
echo "📖 API documentation will be available at: $API_URL"