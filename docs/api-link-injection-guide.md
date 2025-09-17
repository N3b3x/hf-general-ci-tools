---
title: "API Link Injection Guide"
description: "How to dynamically inject API documentation links into Jekyll configuration during deployment"
nav_order: 8
---

# API Link Injection Guide

This guide explains how to modify your `docs.yml` workflow to automatically inject API documentation links into your Jekyll `_config.yml` during deployment, ensuring proper linking based on version type and deployment context.

## Overview

The API link injection system automatically:
- ✅ Detects version type (release, release-candidate, development)
- ✅ Generates appropriate base URLs and API paths
- ✅ Injects API links into both `aux_links` and `nav_external_links` sections
- ✅ Updates baseurl and title based on version context
- ✅ Works with centralized Doxygen documentation in `/doxs/` directory

## Quick Integration

### 1. Add the Injection Script

Add this step to your `docs.yml` workflow after version detection but before Jekyll build:

```yaml
- name: Inject API links into Jekyll config
  run: |
    # Download the injection script
    curl -o inject-api-links.sh https://raw.githubusercontent.com/n3b3x/hf-general-ci-tools/main/docs/inject-api-links.sh
    chmod +x inject-api-links.sh
    
    # Run the injection script
    ./inject-api-links.sh \
      "_config/_config.yml" \
      "${{ needs.version-detection.outputs.version }}" \
      "${{ needs.version-detection.outputs.version_type }}" \
      "${{ github.event.repository.name }}"
```

### 2. Version Detection Outputs

Ensure your version detection step outputs:
- `version`: The detected version (e.g., "v1.2.3", "development")
- `version_type`: The type ("release", "release-candidate", "development")

## Detailed Implementation

### Step-by-Step Integration

#### 1. Modify Your Workflow

Add this job after your version detection:

```yaml
inject-api-links:
  needs: version-detection
  runs-on: ubuntu-latest
  steps:
    - name: Checkout code
      uses: actions/checkout@v4
    
    - name: Download injection script
      run: |
        curl -o inject-api-links.sh https://raw.githubusercontent.com/n3b3x/hf-general-ci-tools/main/docs/inject-api-links.sh
        chmod +x inject-api-links.sh
    
    - name: Inject API links
      run: |
        ./inject-api-links.sh \
          "_config/_config.yml" \
          "${{ needs.version-detection.outputs.version }}" \
          "${{ needs.version-detection.outputs.version_type }}" \
          "${{ github.event.repository.name }}"
    
    - name: Upload modified config
      uses: actions/upload-artifact@v4
      with:
        name: modified-config
        path: _config/_config.yml
```

#### 2. Update Jekyll Build Job

Modify your Jekyll build job to use the modified config:

```yaml
build-jekyll:
  needs: [version-detection, inject-api-links]
  runs-on: ubuntu-latest
  steps:
    - name: Checkout code
      uses: actions/checkout@v4
    
    - name: Download modified config
      uses: actions/download-artifact@v4
      with:
        name: modified-config
        path: _config/
    
    - name: Build Jekyll site
      run: |
        jekyll build --source . --destination _site --config _config/_config.yml
```

## URL Structure

The injection script generates URLs based on version type:

| Version Type | Base URL | API URL |
|--------------|----------|---------|
| **Release** | `/repo-name/v1.2.3` | `/repo-name/v1.2.3/doxs/index.html` |
| **Release Candidate** | `/repo-name/v1.2.3-rc1` | `/repo-name/v1.2.3-rc1/doxs/index.html` |
| **Development** | `/repo-name` | `/repo-name/doxs/index.html` |

## Configuration Changes

The script automatically modifies your `_config.yml`:

### Before Injection:
```yaml
aux_links:
  "📚 GitHub Repository":
    - "https://github.com/n3b3x/hf-general-ci-tools"
  "🐛 Report Issues":
    - "https://github.com/n3b3x/hf-general-ci-tools/issues"
  "⭐ Star on GitHub":
    - "https://github.com/n3b3x/hf-general-ci-tools/stargazers"

nav_external_links:
  - title: "📚 GitHub Repository"
    url: https://github.com/n3b3x/hf-general-ci-tools
  - title: "🐛 Issues"
    url: https://github.com/n3b3x/hf-general-ci-tools/issues
```

### After Injection (Release v1.2.3):
```yaml
aux_links:
  "📚 GitHub Repository":
    - "https://github.com/n3b3x/hf-general-ci-tools"
  "🐛 Report Issues":
    - "https://github.com/n3b3x/hf-general-ci-tools/issues"
  "⭐ Star on GitHub":
    - "https://github.com/n3b3x/hf-general-ci-tools/stargazers"
  "📖 API Reference":
    - "/hf-general-ci-tools/v1.2.3/doxs/index.html"

nav_external_links:
  - title: "📚 GitHub Repository"
    url: https://github.com/n3b3x/hf-general-ci-tools
  - title: "🐛 Issues"
    url: https://github.com/n3b3x/hf-general-ci-tools/issues
  - title: "📖 API Reference"
    url: /hf-general-ci-tools/v1.2.3/doxs/index.html
```

## Advanced Configuration

### Custom API Path

To use a different API path (e.g., `/api/` instead of `/doxs/`):

```bash
# Modify the script call
./inject-api-links.sh \
  "_config/_config.yml" \
  "${{ needs.version-detection.outputs.version }}" \
  "${{ needs.version-detection.outputs.version_type }}" \
  "${{ github.event.repository.name }}" \
  "api"  # Custom API directory
```

### Custom Link Text

To customize the link text, modify the script:

```bash
# In the script, change:
"📖 API Reference"
# To:
"🔧 API Docs"
```

## Troubleshooting

### Common Issues

1. **Script not found**: Ensure the script URL is accessible and the download step succeeds
2. **Config file not found**: Verify the path to `_config/_config.yml` is correct
3. **Permission denied**: Make sure the script is executable (`chmod +x`)
4. **Invalid YAML**: The script creates a backup; restore from `${CONFIG_FILE}.backup` if needed

### Debug Mode

Enable debug output by setting environment variable:

```yaml
- name: Inject API links
  env:
    DEBUG: "true"
  run: |
    ./inject-api-links.sh \
      "_config/_config.yml" \
      "${{ needs.version-detection.outputs.version }}" \
      "${{ needs.version-detection.outputs.version_type }}" \
      "${{ github.event.repository.name }}"
```

### Verification

The script outputs verification information:

```
🔧 Injecting API links into Jekyll configuration...
📋 Version: v1.2.3
🏷️  Type: release
🔗 Base URL: /hf-general-ci-tools/v1.2.3
📖 API URL: /hf-general-ci-tools/v1.2.3/doxs/index.html
📄 Config file: _config/_config.yml
💾 Backup created: _config/_config.yml.backup
📝 Injecting API link into aux_links section...
✅ API link added to aux_links
📝 Injecting API link into nav_external_links section...
✅ API link added to nav_external_links
📝 Updating baseurl to: /hf-general-ci-tools/v1.2.3
✅ Base URL updated
📝 Updating title with version: v1.2.3
✅ Title updated with version
✅ API link injection completed successfully!
```

## Integration with Existing Workflows

This injection system is designed to work seamlessly with:
- ✅ **hf-general-ci-tools/docs.yml** - The main documentation workflow
- ✅ **Versioned documentation** - Automatic version detection and URL generation
- ✅ **Doxygen integration** - Works with centralized `/doxs/` directory
- ✅ **GitHub Pages deployment** - Proper baseurl handling for subdirectories

## Benefits

- 🚀 **Automatic**: No manual configuration needed
- 🔄 **Version-aware**: Different URLs for different versions
- 🛡️ **Safe**: Creates backups before modification
- 🔍 **Verifiable**: Provides detailed output and verification
- 🎯 **Flexible**: Works with any Jekyll configuration structure
- 📱 **Responsive**: Updates both navigation and auxiliary links

## Example Complete Workflow

See [`api-injection-example.yml`](api-injection-example.yml) for a complete example workflow that demonstrates the full integration.