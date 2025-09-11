---
layout: default
title: "🔧 Jekyll Configuration Guide"
description: "Complete guide to Jekyll configuration, CI optimization, and workflow examples"
nav_order: 1
parent: "📖 Examples & Guides"
---

# 🔧 Jekyll Configuration Guide

Complete guide to configuring Jekyll with the enhanced documentation workflow, including CI optimization and practical examples.

## 📋 Table of Contents

- [Quick Start](#quick-start)
- [Configuration Files](#configuration-files)
- [Environment vs Configuration](#environment-vs-configuration)
- [CI Optimization](#ci-optimization)
- [Workflow Examples](#workflow-examples)
- [Troubleshooting](#troubleshooting)

## 🚀 Quick Start

### 1. Basic Setup

```yaml
name: Build Documentation
on:
  push:
    branches: [main]

jobs:
  build-docs:
    uses: ./.github/workflows/docs.yml
    with:
      jekyll_enabled: true
      jekyll_config: "_config.yml"
      jekyll_environment: "production"
```

### 2. Multiple Configuration Files

```yaml
# Production build
jekyll_config: "_config.yml,_config_prod.yml"
jekyll_environment: "production"

# Development build
jekyll_config: "_config.yml,_config_dev.yml"
jekyll_environment: "development"

# Staging build
jekyll_config: "_config.yml,_config_staging.yml"
jekyll_environment: "staging"
```

## 📁 Configuration Files

### Standard Naming Convention

Use these standard naming conventions for your Jekyll configuration files:

- `_config.yml` - Base configuration
- `_config_dev.yml` - Development overrides
- `_config_staging.yml` - Staging overrides
- `_config_prod.yml` - Production overrides
- `_config_theme.yml` - Theme-specific settings
- `_config_analytics.yml` - Analytics settings

### Base Configuration (`_config.yml`)

```yaml
# Site settings
title: "My Project Documentation"
description: "Comprehensive documentation for my project"
baseurl: ""  # Set automatically by workflow for GitHub Pages
url: "https://yourusername.github.io"

# Author information
author:
  name: "Your Name"
  email: "your.email@example.com"
  url: "https://github.com/yourusername"

# Build settings
markdown: kramdown
highlighter: rouge
permalink: pretty

# Theme settings
theme: minima
# OR for remote themes:
# remote_theme: just-the-docs/just-the-docs

# Plugins
plugins:
  - jekyll-feed
  - jekyll-sitemap
  - jekyll-seo-tag
  - jekyll-redirect-from
  - jekyll-optional-front-matter

# Collections
collections:
  docs:
    output: true
    permalink: /:collection/:path/

# Navigation
navigation:
  - title: "Home"
    url: "/"
  - title: "Getting Started"
    url: "/getting-started/"
  - title: "API Reference"
    url: "/api/"

# Exclude files
exclude:
  - Gemfile
  - Gemfile.lock
  - node_modules
  - vendor
  - .git
  - .github
  - README.md
  - LICENSE
```

### Environment-Specific Configurations

#### Development (`_config_dev.yml`)

```yaml
# Development URL settings
url: "http://localhost:4000"
baseurl: ""

# Development-specific settings
incremental: true   # Enable incremental builds
future: true        # Show future-dated posts
drafts: true        # Show draft posts
unpublished: true   # Show unpublished posts
verbose: true       # Enable verbose output
profile: true       # Enable profiling
safe: false         # Allow custom plugins

# Development exclusions (less restrictive)
exclude:
  - Gemfile
  - Gemfile.lock
  - node_modules
  - vendor
  - .git
  - .github
  - README.md
  - LICENSE
  - _config_prod.yml
```

#### Production (`_config_prod.yml`)

```yaml
# Production URL settings
url: "https://yourusername.github.io"
baseurl: "/your-repo-name"

# Production optimizations
compress_html:
  clippings: all
  comments: all
  endings: all
  startings: [html, head, body]

# Production-specific settings
incremental: false  # Disable incremental builds
future: false       # Don't publish future-dated posts
drafts: false       # Don't publish draft posts
unpublished: false  # Don't publish unpublished posts
safe: true          # Enable safe mode
verbose: true       # Enable verbose output
profile: false      # Disable profiling
strict_front_matter: true  # Fail on front matter errors
lsi: false          # Disable LSI

# Production exclusions
exclude:
  - Gemfile
  - Gemfile.lock
  - node_modules
  - vendor
  - .git
  - .github
  - README.md
  - LICENSE
  - "*.gem"
  - "*.gemspec"
  - .sass-cache
  - .jekyll-cache
  - .jekyll-metadata
  - _config_dev.yml
  - _config_staging.yml
  - .env*
```

## 🌍 Environment vs Configuration

### Two Independent Concepts

Jekyll has **two separate mechanisms** that work together:

#### 1. `JEKYLL_ENV` - Runtime Environment Variable
- **Purpose**: Controls logic inside Liquid templates
- **Access**: `jekyll.environment` in templates
- **Usage**: Set as environment variable before Jekyll commands

```bash
# Set environment variable
JEKYLL_ENV=production bundle exec jekyll build
JEKYLL_ENV=development bundle exec jekyll build
```

**In Liquid templates:**
```liquid
{% if jekyll.environment == "production" %}
  <script src="analytics.js"></script>
{% endif %}

{% if jekyll.environment == "development" %}
  <div class="debug-banner">Development Mode</div>
{% endif %}
```

#### 2. `--config` - Configuration File Selection
- **Purpose**: Controls which YAML files Jekyll loads
- **Usage**: Comma-separated list of config files
- **Precedence**: Later files override earlier ones

```bash
# Multiple config files
jekyll build --config _config.yml,_config_prod.yml
```

### How They Work Together

**You associate them by convention** in your workflow:

```yaml
# Production build
jekyll_environment: "production"        # Sets JEKYLL_ENV=production
jekyll_config: "_config.yml,_config_prod.yml"  # Loads these configs

# Development build
jekyll_environment: "development"      # Sets JEKYLL_ENV=development
jekyll_config: "_config.yml,_config_dev.yml"  # Loads these configs
```

**Result:**
- **Configs** set structural things (URLs, excludes, plugins, etc.)
- **Environment** lets you branch on behaviors in Liquid templates
- **Association** is your choice - you decide which config goes with which environment

## ⚡ CI Optimization

### Automatic CI Defaults

The workflow automatically applies CI-optimized defaults for Jekyll command-line options:

| Setting | CI Default | Reason |
|---------|------------|--------|
| `incremental` | `false` | Prevents stale content issues |
| `watch` | `false` | Unnecessary in CI environments |
| `serve` | `false` | Not applicable for CI builds |
| `livereload` | `false` | Not applicable for CI builds |
| `safe` | `true` | More secure and predictable |
| `verbose` | `true` | Better debugging in CI |
| `profile` | `false` | Reduces build time |
| `drafts` | `false` | Focus on finalized content |
| `future` | `false` | Prevent future content publishing |
| `unpublished` | `false` | Focus on published content |
| `lsi` | `false` | Resource-intensive, not needed for CI |
| `strict_front_matter` | `true` | Ensure content integrity |

### Override CI Defaults

Users can override CI defaults when needed:

```yaml
# Override CI defaults for development
jekyll_environment: "development"
jekyll_drafts: true      # Override CI default
jekyll_future: true      # Override CI default
jekyll_safe: false       # Override CI default
```

## 🚀 Workflow Examples

### Basic Production Build

```yaml
name: Production Documentation Build
on:
  push:
    branches: [main]

jobs:
  build-docs:
    uses: ./.github/workflows/docs.yml
    with:
      jekyll_enabled: true
      jekyll_config: "_config.yml,_config_prod.yml"
      jekyll_environment: "production"
      # CI defaults automatically applied
```

### Development Build with Overrides

```yaml
name: Development Documentation Build
on:
  push:
    branches: [develop]

jobs:
  build-docs:
    uses: ./.github/workflows/docs.yml
    with:
      jekyll_enabled: true
      jekyll_config: "_config.yml,_config_dev.yml"
      jekyll_environment: "development"
      # Override CI defaults for development
      jekyll_drafts: true
      jekyll_future: true
      jekyll_safe: false
```

### Multi-Environment Build

```yaml
name: Multi-Environment Build
on:
  push:
    branches: [main, develop, staging]
  workflow_dispatch:
    inputs:
      environment:
        description: 'Target environment'
        required: true
        default: 'production'
        type: choice
        options:
          - production
          - staging
          - development

jobs:
  build-docs:
    uses: ./.github/workflows/docs.yml
    with:
      jekyll_enabled: true
      jekyll_environment: ${{ github.event.inputs.environment || 
        (github.ref == 'refs/heads/main' && 'production') || 
        (github.ref == 'refs/heads/staging' && 'staging') || 'development' }}
      jekyll_config: "_config.yml,_config_${{ github.event.inputs.environment || 
        (github.ref == 'refs/heads/main' && 'prod') || 
        (github.ref == 'refs/heads/staging' && 'staging') || 'dev' }}.yml"
```

### Custom Configuration Files

```yaml
name: Custom Config Build
on:
  push:
    branches: [main]

jobs:
  build-docs:
    uses: ./.github/workflows/docs.yml
    with:
      jekyll_enabled: true
      # Any combination of config files
      jekyll_config: "_config.yml,_config_theme.yml,_config_analytics.yml,_config_prod.yml"
      jekyll_environment: "production"
```

## 🔧 Troubleshooting

### Common Issues

#### Configuration Not Found
```
❌ Jekyll config not found, creating minimal _config.yml
```
**Solution**: Ensure your config file exists in the source directory or let the workflow create a minimal one.

#### YAML Syntax Errors
```
❌ YAML syntax error in _config.yml
```
**Solution**: Validate your YAML syntax using online tools or `yq` command.

#### Build Failures
```
❌ Jekyll build failed - no output directory or empty directory
```
**Solution**: Check your configuration, ensure all required files exist, and review build logs.

### Debug Build

```yaml
name: Debug Build
on:
  workflow_dispatch:

jobs:
  build-docs:
    uses: ./.github/workflows/docs.yml
    with:
      jekyll_enabled: true
      jekyll_config: "_config.yml"
      jekyll_environment: "development"
      # Debug options
      jekyll_verbose: true
      jekyll_trace: true
      jekyll_profile: true
      jekyll_strict_front_matter: true
```

### Getting Help

- Check the [Jekyll documentation](https://jekyllrb.com/docs/)
- Review the [GitHub Pages documentation](https://docs.github.com/en/pages)
- Use the workflow's built-in validation
- Enable verbose output for detailed debugging

---

[Next: Example Workflows →](example-workflows.md)

**📚 [All Documentation](index.md)** | **🏠 [Main README](../README.md)**

---

*This guide provides everything you need to configure Jekyll with the enhanced documentation workflow. For more information, see the [main documentation](index.md).*
