#!/bin/bash

# =============================================================================
# Version Detection Logic - FIXED VERSION
# =============================================================================

# Validate required inputs for versioning
if [[ -z "$deployment_branch" ]]; then
  echo "❌ Error: deployment_branch is required for versioned documentation"
  echo "Please specify a deployment branch (e.g., 'gh-pages')"
  exit 1
fi
echo "✅ Versioned documentation with deployment branch: $deployment_branch"

# Auto detection from branch/tag
# FIXED: Use proper variable reference instead of hardcoded string
if [[ "$GITHUB_REF" == "refs/heads/main" ]]; then
  echo "version_name=development" >> $GITHUB_OUTPUT
  echo "version_type=development" >> $GITHUB_OUTPUT
  echo "deploy_strategy=development" >> $GITHUB_OUTPUT
elif [[ "$GITHUB_REF" == refs/heads/release/v* ]]; then
  VERSION=$(echo "$GITHUB_REF" | sed 's|refs/heads/release/||')
  echo "version_name=$VERSION" >> $GITHUB_OUTPUT
  if [[ "$VERSION" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "version_type=stable" >> $GITHUB_OUTPUT
    echo "deploy_strategy=stable" >> $GITHUB_OUTPUT
  elif [[ "$VERSION" =~ ^v[0-9]+\.[0-9]+\.[0-9]+-(rc|beta|alpha)[0-9]*$ ]]; then
    echo "version_type=prerelease" >> $GITHUB_OUTPUT
    echo "deploy_strategy=prerelease" >> $GITHUB_OUTPUT
  else
    echo "version_type=versioned" >> $GITHUB_OUTPUT
    echo "deploy_strategy=versioned" >> $GITHUB_OUTPUT
  fi
elif [[ "$GITHUB_REF" == refs/tags/v* ]]; then
  VERSION=$(echo "$GITHUB_REF" | sed 's|refs/tags/||')
  echo "version_name=$VERSION" >> $GITHUB_OUTPUT
  echo "version_type=stable" >> $GITHUB_OUTPUT
  echo "deploy_strategy=stable" >> $GITHUB_OUTPUT
else
  echo "version_name=preview" >> $GITHUB_OUTPUT
  echo "version_type=preview" >> $GITHUB_OUTPUT
  echo "deploy_strategy=preview" >> $GITHUB_OUTPUT
fi

# =============================================================================
# Doxygen Version Detection (Auto-synchronized with git versioning)
# =============================================================================

# FIXED: Get version_type from the output we just set
VERSION_TYPE=$(grep "version_type=" $GITHUB_OUTPUT | cut -d'=' -f2)
VERSION_NAME=$(grep "version_name=" $GITHUB_OUTPUT | cut -d'=' -f2)

# Auto-synchronize Doxygen version with git-based versioning
# Auto-determine Doxygen version based on git context
if [[ "$VERSION_TYPE" == "development" ]]; then
  # For development, try to get latest tag or use commit hash
  LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "")
  if [[ -n "$LATEST_TAG" ]]; then
    echo "doxygen_version=${LATEST_TAG}-dev" >> $GITHUB_OUTPUT
    echo "doxygen_project_number=${LATEST_TAG}-dev" >> $GITHUB_OUTPUT
  else
    echo "doxygen_version=0.1.0-dev" >> $GITHUB_OUTPUT
    echo "doxygen_project_number=0.1.0-dev" >> $GITHUB_OUTPUT
  fi
elif [[ "$VERSION_TYPE" == "stable" || "$VERSION_TYPE" == "prerelease" ]]; then
  # Stable releases and pre-releases - use version as-is
  echo "doxygen_version=$VERSION_NAME" >> $GITHUB_OUTPUT
  echo "doxygen_project_number=$VERSION_NAME" >> $GITHUB_OUTPUT
else
  # For other cases (preview), try to get version from git or use default
  PREVIEW_VERSION=$(git describe --tags --abbrev=0 2>/dev/null || echo "0.1.0-preview")
  echo "doxygen_version=$PREVIEW_VERSION" >> $GITHUB_OUTPUT
  echo "doxygen_project_number=$PREVIEW_VERSION" >> $GITHUB_OUTPUT
fi

# =============================================================================
# URL and Configuration Generation
# =============================================================================

# Extract base URL from Jekyll config and add version
if [[ -f "$jekyll_config" ]]; then
  BASE_URL=$(grep '^baseurl:' "$jekyll_config" | sed 's/^baseurl: *//' | sed 's/^["'\'']//' | sed 's/["'\'']$//' | sed 's/^ *//' | sed 's/ *$//')

  # Add version to base URL if versioning is enabled
  if [[ -n "$VERSION_NAME" && "$VERSION_TYPE" != "development" && "$VERSION_TYPE" != "preview" ]]; then
    BASE_URL="${BASE_URL}/${VERSION_NAME}"
  fi
else
  BASE_URL=""
fi
echo "base_url=$BASE_URL" >> $GITHUB_OUTPUT

# Generate config file names
# Always use main config as base - versioning is handled dynamically
echo "jekyll_config=$jekyll_config" >> $GITHUB_OUTPUT

# =============================================================================
# Deployment Path Generation (Standardized)
# =============================================================================

# Auto-generate standardized deployment path
if [[ "$VERSION_TYPE" == "development" ]]; then
  echo "deployment_path=development" >> $GITHUB_OUTPUT
elif [[ "$VERSION_TYPE" == "preview" ]]; then
  echo "deployment_path=preview" >> $GITHUB_OUTPUT
else
  echo "deployment_path=$VERSION_NAME" >> $GITHUB_OUTPUT
fi

# =============================================================================
# Output Summary
# =============================================================================

echo "🎯 Version Detection Summary:"
echo "  Version Name: $VERSION_NAME"
echo "  Version Type: $VERSION_TYPE"
echo "  Deploy Strategy: $(grep "deploy_strategy=" $GITHUB_OUTPUT | cut -d'=' -f2)"
echo "  Base URL: $BASE_URL"
echo "  Deployment Path: $(grep "deployment_path=" $GITHUB_OUTPUT | cut -d'=' -f2)"
echo "  Doxygen Version: $(grep "doxygen_version=" $GITHUB_OUTPUT | cut -d'=' -f2)"