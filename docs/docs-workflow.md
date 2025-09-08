# Documentation Workflow Guide

<div align="center">

[← Previous: C/C++ Lint Workflow](lint-workflow.md) | [Next: Link Check Workflow →](link-check-workflow.md)

**📖 Doxygen + GitHub Pages Deployment**

</div>

---

The Documentation workflow builds Doxygen documentation and optionally deploys it to GitHub Pages with link checking and artifact management.

## 📋 Table of Contents

- [Overview](#-overview)
- [Inputs](#-inputs)
- [Outputs](#-outputs)
- [Usage Examples](#-usage-examples)
- [Configuration](#-configuration)
- [GitHub Pages Setup](#-github-pages-setup)
- [Troubleshooting](#-troubleshooting)
- [Related Workflows](#-related-workflows)

## 🎯 Overview

**Purpose**: Generate and deploy Doxygen documentation with optional Jekyll integration  
**Key Features**: 
- Doxygen + Graphviz integration
- Optional Jekyll static site generation
- Advanced link checking with Lychee
- Markdown linting (markdownlint)
- Spell checking (cspell)
- Modern GitHub Pages deployment
- Concurrency control
- Artifact storage

**Use Case**: Automated documentation generation and deployment for C/C++ projects with enhanced presentation

## ⚙️ Inputs

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `doxygen_config` | string | ❌ | `Doxyfile` | Path to Doxyfile (relative to repo root) |
| `output_dir` | string | ❌ | `docs/doxygen/html` | Generated HTML directory |
| `run_link_check` | boolean | ❌ | `true` | Run documentation link checker |
| `link_check_paths` | string | ❌ | `docs/**,*.md,**/docs/**` | Comma-separated paths to check for broken links |
| `run_markdown_lint` | boolean | ❌ | `false` | Run markdown linting on documentation files |
| `markdown_lint_paths` | string | ❌ | `**/*.md` | Glob patterns for markdown files to lint |
| `run_spell_check` | boolean | ❌ | `false` | Run spell checking on documentation files |
| `spell_check_paths` | string | ❌ | `**/*.md` | Glob patterns for files to spell check |
| `spell_check_config` | string | ❌ | `.cspell.json` | Path to cspell configuration file |
| `deploy_pages` | boolean | ❌ | `true` | Deploy to GitHub Pages |
| `jekyll_enabled` | boolean | ❌ | `false` | Enable Jekyll static site generation |
| `jekyll_theme` | string | ❌ | `minima` | Jekyll theme to use |
| `jekyll_config` | string | ❌ | `_config.yml` | Path to Jekyll configuration file |
| `jekyll_source` | string | ❌ | `docs` | Jekyll source directory |
| `jekyll_destination` | string | ❌ | `_site` | Jekyll build destination |

## 📤 Outputs

| Output | Description |
|--------|-------------|
| HTML documentation | Generated Doxygen HTML files |
| GitHub Pages | Deployed documentation (if enabled) |
| Artifacts | Uploaded documentation files |

## 🚀 Usage Examples

### Basic Usage

```yaml
jobs:
  docs:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: Doxyfile
      output_dir: docs/doxygen/html
```

### With Documentation Quality Checks

```yaml
jobs:
  docs:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: Doxyfile
      output_dir: docs/doxygen/html
      run_link_check: true
      link_check_paths: "docs/**,*.md,**/docs/**"
      run_markdown_lint: true
      markdown_lint_paths: "docs/**,*.md"
      run_spell_check: true
      spell_check_paths: "docs/**,*.md"
      spell_check_config: ".cspell.json"
      deploy_pages: true
```

### With Jekyll Integration

```yaml
jobs:
  docs:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: Doxyfile
      output_dir: docs/doxygen/html
      jekyll_enabled: true
      jekyll_theme: "minima"
      jekyll_config: "_config.yml"
      jekyll_source: "docs"
      jekyll_destination: "_site"
      run_link_check: true
      deploy_pages: true
```

### Custom Configuration

```yaml
jobs:
  docs:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: docs/Doxyfile.custom
      output_dir: docs/generated/html
      run_link_check: false
      deploy_pages: false
```

## ⚙️ Configuration

### Doxygen Configuration

Create a `Doxyfile` in your project root:

```ini
# Basic Doxygen configuration
PROJECT_NAME           = "My C++ Project"
PROJECT_NUMBER        = 1.0
OUTPUT_DIRECTORY      = docs/doxygen
INPUT                 = src include
FILE_PATTERNS         = *.c *.cpp *.h *.hpp
RECURSIVE             = YES
GENERATE_HTML         = YES
HTML_OUTPUT           = html
GENERATE_LATEX        = NO
EXTRACT_ALL           = YES
EXTRACT_PRIVATE       = YES
EXTRACT_STATIC        = YES
```

### Link Checking with Lychee

The workflow includes advanced link checking using Lychee, which provides comprehensive link validation for both internal and external links.

```yaml
run_link_check: true  # Enable link checking (default: true)
link_check_paths: "docs/**,*.md"  # Paths to check for broken links
```

The Lychee link checker:
- Scans all markdown files in the specified paths
- Validates both internal file references and external URLs
- Supports configurable timeouts and retry attempts
- Excludes private/internal links by default
- Provides detailed reporting with verbose output options
- Uses the modern `lycheeverse/lychee-action@v2` action
- Offers better performance and reliability than traditional link checkers

### Markdown Linting

Optional markdown linting using `markdownlint-cli` to enforce consistent markdown formatting and catch common issues.

```yaml
run_markdown_lint: true  # Enable markdown linting (default: false)
markdown_lint_paths: "**/*.md"  # Glob patterns for files to lint
```

Features:
- Enforces consistent markdown formatting
- Catches common markdown issues
- Configurable via `.markdownlint.json` file
- Ignores `node_modules` by default

### Spell Checking

Optional spell checking using `cspell` to catch spelling errors in documentation.

```yaml
run_spell_check: true  # Enable spell checking (default: false)
spell_check_paths: "**/*.md"  # Glob patterns for files to check
spell_check_config: ".cspell.json"  # Path to cspell config file
```

Features:
- Catches spelling errors in documentation
- Configurable via `.cspell.json` file
- Supports custom dictionaries and ignore patterns
- Works with multiple file types

### Jekyll Integration

Optional Jekyll static site generation for enhanced documentation presentation and better GitHub Pages integration.

```yaml
jekyll_enabled: true  # Enable Jekyll (default: false)
jekyll_theme: "minima"  # Jekyll theme to use
jekyll_config: "_config.yml"  # Path to Jekyll config
jekyll_source: "docs"  # Source directory
jekyll_destination: "_site"  # Build destination
```

**Jekyll Configuration:**
Create a `_config.yml` file in your repository root:

```yaml
# Jekyll configuration
title: "My C++ Project Documentation"
description: "Comprehensive documentation for my C++ project"
baseurl: ""  # Set by workflow automatically
url: "https://yourusername.github.io"

# Theme settings
theme: minima

# Build settings
markdown: kramdown
highlighter: rouge

# Navigation
navigation:
  - title: "Home"
    url: "/"
  - title: "API Reference"
    url: "/doxygen/html/"
```

**Features:**
- Static site generation with customizable themes
- Better GitHub Pages integration
- Enhanced navigation and presentation
- Support for custom layouts and includes
- Automatic baseurl configuration for GitHub Pages

### Standalone Link Check

For repositories that only need link checking without documentation generation, use the dedicated link check workflow:

```yaml
jobs:
  link-check:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "docs/**,*.md,**/docs/**"  # Paths to check
      fail_on_errors: true              # Fail on broken links
      timeout: "10"                     # Timeout per link (seconds)
      retry: "3"                        # Number of retries
      exclude_private: true             # Exclude private links
      exclude_mail: true                # Exclude mailto links
      verbose: false                    # Verbose output
      # Uses lycheeverse/lychee-action@v2 for advanced link checking
```

### GitHub Pages Setup

1. **Enable GitHub Pages** in your repository settings
2. **Set source** to "GitHub Actions"
3. **Grant permissions** to the workflow:

```yaml
permissions:
  contents: write
  pages: write
  id-token: write
```

## 🌐 GitHub Pages Setup

### Repository Settings

1. Go to **Settings** → **Pages**
2. Set **Source** to "GitHub Actions"
3. Ensure **GitHub Actions** has write permissions

### Workflow Permissions

The workflow requires these permissions:

```yaml
permissions:
  contents: write      # Upload artifacts
  pages: write         # Deploy to Pages
  id-token: write      # Authentication
```

### Custom Domain (Optional)

Add a `CNAME` file to your `docs/doxygen/html` directory:

```
docs.yourproject.com
```

## 🔧 Troubleshooting

### Common Issues

**Doxygen Build Fails**
- Verify `Doxyfile` exists and is valid
- Check source directories exist (`src/`, `include/`)
- Ensure Graphviz is installed (handled automatically)
- Verify `doxygen_config` path is correct

**GitHub Pages Not Deploying**
- Check repository permissions
- Verify `deploy_pages: true`
- Ensure workflow runs on main branch (not PRs)

**Link Check Fails**
- Verify link paths are correct in `link_check_paths`
- Check that markdown files exist at specified paths
- Review link checker output for specific broken links

**Markdown Lint Fails**
- Check markdown syntax and formatting
- Review `.markdownlint.json` configuration if present
- Fix linting errors reported by markdownlint

**Spell Check Fails**
- Review spelling errors in documentation
- Add words to `.cspell.json` custom dictionary if needed
- Check `spell_check_config` path is correct

### Debug Mode

Enable debug output:

```yaml
env:
  ACTIONS_STEP_DEBUG: true
```

### Manual Testing

Test Doxygen locally:

```bash
# Install Doxygen and Graphviz
sudo apt-get install doxygen graphviz

# Generate docs
doxygen Doxyfile

# Check output
ls docs/doxygen/html/
```

## 📚 Related Workflows

- **[C/C++ Lint](lint-workflow.md)** - Code quality checks
- **[Static Analysis](static-analysis-workflow.md)** - Security analysis
- **[Link Check](link-check-workflow.md)** - Documentation link validation

## 🔗 Related Resources

- [Doxygen Documentation](https://www.doxygen.nl/)
- [GitHub Pages](https://docs.github.com/en/pages)
- [Markdown Link Checking](https://github.com/tcort/markdown-link-check)

---

<div align="center">

[← Previous: C/C++ Lint Workflow](lint-workflow.md) | [Next: Link Check Workflow →](link-check-workflow.md)

**📚 [All Documentation](index.md)** | **🏠 [Main README](../README.md)**

</div>

