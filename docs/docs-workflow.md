---
layout: default
title: "📚 Documentation Workflow"
description: "Doxygen documentation generation and GitHub Pages deployment"
nav_order: 3
parent: "🔄 Reusable Workflows"
---

# Documentation Workflow Guide

**📖 Doxygen + GitHub Pages Deployment**

---

The Documentation workflow builds Doxygen documentation and optionally deploys it to GitHub Pages
with link checking and artifact management.

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
- Doxygen + Graphviz integration (optimized installation)
- Optional Jekyll static site generation
- Advanced link checking with Lychee
- Markdown linting (markdownlint)
- Spell checking (cspell)
- Modern GitHub Pages deployment
- Concurrency control
- Artifact storage
- **Fast dependency installation** using pre-built binaries

**Use Case**: Automated documentation generation and deployment for C/C++ projects with enhanced presentation

## ⚙️ Inputs

### 📁 Repository Configuration

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `checkout_recursive` | boolean | ❌ | `false` | Checkout submodules recursively (for projects with docs in submodules) |

### 📚 Doxygen Configuration

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `doxygen_config` | string | ❌ | `Doxyfile` | Path to Doxyfile (relative to repo root) |
| `doxygen_fail_on_warnings` | boolean | ❌ | `false` | Treat Doxygen warnings as errors in CI |

### 🔗 Link Checking

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `run_link_check` | boolean | ❌ | `true` | Run documentation link checker |
| `link_check_paths` | string | ❌ | `**/*.md` | Space-separated paths to check for broken links |
| `link_check_config` | string | ❌ | `''` | Path to lychee.toml config file (optional) |
| `verbose` | boolean | ❌ | `false` | Enable verbose output for link checking |

### 📝 Documentation Quality

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `run_markdown_lint` | boolean | ❌ | `false` | Run markdown linting on documentation files |
| `markdown_lint_paths` | string | ❌ | `**/*.md` | Space-separated glob patterns for markdown files to lint |
| `run_spell_check` | boolean | ❌ | `false` | Run spell checking on documentation files |
| `spell_check_paths` | string | ❌ | `**/*.md` | Space-separated glob patterns for files to spell check |
| `spell_check_config` | string | ❌ | `.cspell.json` | Path to cspell configuration file |

### 🌐 Deployment

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `deploy_pages` | boolean | ❌ | `true` | Deploy to GitHub Pages |

### 🎨 Jekyll Configuration

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `jekyll_enabled` | boolean | ❌ | `false` | Enable Jekyll static site generation |
| `jekyll_config` | string | ❌ | `_config.yml` | Comma-separated list of Jekyll configuration files |
| `jekyll_source` | string | ❌ | `docs` | Jekyll source directory containing your site files |
| `jekyll_destination` | string | ❌ | `_site` | Jekyll build destination directory for generated site |
| `jekyll_environment` | string | ❌ | `production` | Jekyll environment (development, production, staging) |

### ⚙️ Jekyll Advanced Options

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `jekyll_safe` | boolean | ❌ | `true` | Run in safe mode (disables custom plugins, used by GitHub Pages) |
| `jekyll_plugins_dir` | string | ❌ | `''` | Comma-separated list of plugin directories |
| `jekyll_layouts_dir` | string | ❌ | `''` | Layout directory |
| `jekyll_verbose` | boolean | ❌ | `false` | Enable verbose output during Jekyll build |
| `jekyll_strict_front_matter` | boolean | ❌ | `true` | Fail build on YAML syntax errors in front matter |
| `jekyll_drafts` | boolean | ❌ | `false` | Include draft posts in the build |
| `jekyll_future` | boolean | ❌ | `false` | Include future-dated posts in the build |
| `jekyll_unpublished` | boolean | ❌ | `false` | Include unpublished posts in the build |
| `jekyll_incremental` | boolean | ❌ | `false` | Enable incremental builds for faster development |
| `jekyll_lsi` | boolean | ❌ | `false` | Enable LSI (Latent Semantic Indexing) for related posts |
| `jekyll_limit_posts` | string | ❌ | `''` | Limit the number of posts to parse and publish |
| `jekyll_profile` | boolean | ❌ | `false` | Enable profiling output to show build performance |
| `jekyll_quiet` | boolean | ❌ | `false` | Suppress normal output during Jekyll build |
| `jekyll_trace` | boolean | ❌ | `false` | Show full backtrace when an error occurs |

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
```

### With Submodule Support

```yaml
jobs:
  docs:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: Doxyfile
      checkout_recursive: true  # Enable submodule checkout
```

### With Documentation Quality Checks

```yaml
jobs:
  docs:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: Doxyfile
      run_link_check: true
      link_check_paths: "docs/** *.md **/docs/**"
      run_markdown_lint: true
      markdown_lint_paths: "docs/** *.md"
      run_spell_check: true
      spell_check_paths: "docs/** *.md"
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
      jekyll_enabled: true
      jekyll_config: "_config.yml"
      jekyll_source: "docs"
      jekyll_destination: "_site"
      run_link_check: true
      deploy_pages: true
```

### Advanced Jekyll Configuration

```yaml
jobs:
  docs:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: Doxyfile
      jekyll_enabled: true
      jekyll_config: "_config.yml,_config_prod.yml"
      jekyll_source: "docs"
      jekyll_destination: "_site"
      jekyll_environment: "production"
      jekyll_safe: true
      jekyll_verbose: true
      jekyll_strict_front_matter: true
      jekyll_drafts: false
      jekyll_future: false
      jekyll_unpublished: false
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
      run_link_check: false
      deploy_pages: false
```

### Submodule Documentation Projects

```yaml
jobs:
  docs:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      checkout_recursive: true  # Required for submodule-based docs
      doxygen_config: Doxyfile
      jekyll_enabled: true
      jekyll_source: "docs"
      run_link_check: true
      link_check_paths: "docs/** *.md **/docs/**"
```

## ⚙️ Configuration

### Repository Setup

#### **Submodule Checkout**

The workflow supports optional recursive submodule checkout for projects that store documentation in submodules:

```yaml
checkout_recursive: true  # Enable submodule checkout
```

**When to use recursive checkout:**
- Documentation is stored in a separate submodule repository
- Doxygen source files are in submodules
- Jekyll themes or plugins are in submodules
- External documentation dependencies are in submodules

**When NOT to use recursive checkout:**
- All documentation is in the main repository
- No submodules are present
- Performance optimization (recursive checkout is slower)

**Default behavior:** `false` (no submodule checkout)

### Optimized Dependency Installation

The workflow uses optimized installation methods for maximum speed:

- **Doxygen**: `ssciwr/doxygen-install@v1` - Pre-built binaries with caching
- **Graphviz**: `tlylt/install-graphviz@v1` - Pre-built binaries with caching
- **Pre-installation Check**: Uses pre-installed Graphviz if available (instant)
- **Performance**: 75-90% faster than traditional `apt-get` installation

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

The workflow includes advanced link checking using Lychee, which provides comprehensive link validation
for both internal and external links.

```yaml
run_link_check: true  # Enable link checking (default: true)
link_check_paths: "docs/** *.md"  # Paths to check for broken links
```

The Lychee link checker:
- Scans all markdown files in the specified paths
- Uses **space-separated glob patterns** (not comma-separated)
- Validates both internal file references and external URLs
- Supports configurable timeouts and retry attempts
- Excludes private/internal links by default
- Provides detailed reporting with verbose output options

**Path Format Examples:**
- `**/*.md` - All .md files recursively (default)
- `docs/** *.md` - All files in docs/ and all .md files in root (space-separated)
- `README.md docs/**/*.md` - Specific file + all .md files in docs/ (space-separated)
- Uses the modern `lycheeverse/lychee-action@v2` action
- Offers better performance and reliability than traditional link checkers

**Important**: Paths must be **space-separated**, not comma-separated, as required by `lycheeverse/lychee-action@v2`.

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
jekyll_config: "_config.yml"  # Path to Jekyll config
jekyll_source: "docs"  # Source directory
jekyll_destination: "_site"  # Build destination
```

**Jekyll Configuration:**

The workflow automatically creates a minimal `_config.yml` file if one doesn't exist.
For comprehensive Jekyll configuration, see the [Jekyll Guide](jekyll-guide.md).

**Quick Setup:**
```yaml
# Basic Jekyll configuration
title: "My C++ Project Documentation"
description: "Comprehensive documentation for my C++ project"
baseurl: ""  # Set by workflow automatically
url: "https://yourusername.github.io"
theme: minima
markdown: kramdown
highlighter: rouge
```

**Features:**
- Static site generation with customizable themes
- Better GitHub Pages integration
- Enhanced navigation and presentation
- Support for custom layouts and includes
- Automatic baseurl configuration for GitHub Pages
- **Smart configuration validation** with directory-aware checking

**Advanced Jekyll Configuration:**

The workflow supports extensive Jekyll configuration options for fine-tuned control:

```yaml
jekyll_enabled: true
jekyll_config: "_config.yml,_config_prod.yml"  # Multiple config files
jekyll_environment: "production"               # Environment-specific settings
jekyll_safe: true                              # Safe mode (GitHub Pages compatible)
jekyll_verbose: true                           # Verbose output for debugging
jekyll_strict_front_matter: true              # Fail on YAML syntax errors
jekyll_drafts: false                           # Exclude draft posts
jekyll_future: false                           # Exclude future-dated posts
jekyll_unpublished: false                      # Exclude unpublished posts
jekyll_incremental: false                      # Disable incremental builds (CI recommended)
jekyll_lsi: false                              # Disable LSI (resource-intensive)
jekyll_profile: false                          # Disable profiling (reduces build time)
jekyll_quiet: false                            # Enable normal output
jekyll_trace: false                            # Disable full backtrace
```

**CI-Optimized Defaults:**
The workflow automatically applies CI-optimized defaults for better reliability:
- Safe mode enabled (prevents custom plugin issues)
- Incremental builds disabled (prevents stale content)
- Profiling disabled (reduces build time)
- Drafts and future posts excluded (focus on published content)
- Strict front matter validation enabled (ensures content integrity)

### Standalone Link Check

For repositories that only need link checking without documentation generation, use the dedicated link check workflow:

```yaml
jobs:
  link-check:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "docs/** *.md **/docs/**"  # Paths to check (default: **/*.md)
      fail_on_errors: true              # Fail on broken links
      timeout: "10"                     # Timeout per link (seconds)
      retry: "3"                        # Number of retries
      exclude_private: true             # Exclude private links
      exclude_mail: true                # Exclude mailto links
      verbose: false                    # Verbose output
      # Uses lycheeverse/lychee-action@v2 for advanced link checking
```

### 🔍 Jekyll Configuration Validation

The workflow includes intelligent Jekyll configuration validation that:

#### **Smart Directory Detection**
- Reads your `_config.yml` to determine custom directory locations
- Checks directories where they're actually configured (e.g., `_config/_layouts`)
- Falls back to standard locations if custom paths aren't specified
- Reports missing directories as "may be using theme defaults"

#### **File Location Validation**
- Checks common files (`index.md`, `404.html`, `robots.txt`) relative to your config file location
- If `_config.yml` is in `docs/`, files are checked in `docs/` directory
- Prevents false warnings about missing files in wrong locations

#### **Configuration Warnings**
- Detects trailing slashes in `baseurl` and `url` (should be avoided)
- Validates YAML syntax with specific error reporting
- Provides helpful guidance for common configuration issues

**Example Validation Output:**
```
🔍 Validating Jekyll configuration...
✅ Validating config file: _config/_config.yml
  ✅ YAML syntax is valid
✅ Found layouts directory: _config/_layouts
✅ Found includes directory: _config/_includes
⚠️  Directory not found: _config/_sass (may be using theme defaults)
✅ Found file: index.md
✅ Found file: 404.html
✅ Found file: robots.txt
⚠️  File not found: index.html (optional but recommended)
✅ Jekyll configuration validation completed
```

For detailed validation guidance, see the [Jekyll Configuration Guide](jekyll-guide.md#-configuration-validation).

### GitHub Pages Setup

**Important**: GitHub Pages must be enabled in your repository settings before using this workflow.

1. **Enable GitHub Pages** in your repository settings:
   - Go to **Settings** → **Pages**
   - Set **Source** to "GitHub Actions"
   - Save the settings

2. **Grant permissions** to the workflow:

```yaml
permissions:
  contents: write
  pages: write
  id-token: write
```

3. **Workflow behavior**:
   - If Pages is not enabled, the workflow will continue but skip deployment
   - Documentation will still be built and artifacts uploaded
   - No errors will occur if Pages is not configured

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
- Graphviz is automatically installed via optimized action (no manual setup needed)
- Verify `doxygen_config` path is correct

**Jekyll Configuration Validation Issues**

- **False warnings about missing directories**: Check if your `_config.yml` specifies custom directory
  locations (e.g., `layouts_dir: _config/_layouts`)
- **Files not found warnings**: Ensure common files (`index.md`, `404.html`, `robots.txt`) are in the
  same directory as your `_config.yml`
- **Trailing slash warnings**: Remove trailing slashes from `baseurl` and `url` in your configuration
- **YAML syntax errors**: Use online YAML validators or `yq` to check syntax

**GitHub Pages Not Deploying**
- Check repository permissions
- Verify `deploy_pages: true`
- Ensure workflow runs on main branch (not PRs)
- **Enable GitHub Pages** in repository settings (Settings → Pages → Source: GitHub Actions)
- Check if Pages site exists and is configured properly

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
# Option 1: Using package manager (slower)
sudo apt-get install doxygen graphviz

# Option 2: Using optimized actions (faster, like in CI)
# For local development, you can use the same actions:
# - ssciwr/doxygen-install@v1 for Doxygen
# - tlylt/install-graphviz@v1 for Graphviz

# Generate docs
doxygen Doxyfile

# Check output
ls docs/doxygen/html/
```

## 🔧 Troubleshooting

### Common Configuration Issues

#### **Sed Syntax Errors**

**Problem**: Workflow fails with `sed: -e expression #1, char 44: unterminated 's' command`

**Cause**: Inline comments in configuration files can cause sed syntax errors during processing.

**Solution**: The workflow now automatically handles inline comments safely. If you encounter this error:

1. **Check your `_config.yml`** for inline comments:
   ```yaml
   # This is safe
   title: "My Project"  # This comment is handled automatically
   baseurl: "/my-project"  # GitHub Pages subpath
   ```

2. **The workflow automatically**:
   - Strips inline comments during processing
   - Generates clean configuration files
   - Prevents sed syntax errors

**Example Fix**:
```yaml
# Before (could cause errors in older versions)
baseurl: "/my-project"  # GitHub Pages subpath

# After (handled automatically by current workflow)
baseurl: "/my-project"  # GitHub Pages subpath
# ↑ This comment is now safely stripped during processing
```

#### **YAML Validation Issues**

**Problem**: YAML syntax errors in configuration files

**Solution**: The workflow includes built-in YAML validation:

1. **Automatic validation** - YAML syntax is checked during workflow execution
2. **Clear error messages** - Specific line numbers and error descriptions
3. **Prevention** - Validation runs before configuration processing

**Manual validation**:
```bash
# Install yamllint
pip install yamllint

# Validate your configuration
yamllint _config.yml
```

#### **Configuration Generation Failures**

**Problem**: Version-specific configuration generation fails

**Solution**: The workflow now includes robust configuration processing:

1. **Comment-safe extraction** - Handles inline comments automatically
2. **Clean generation** - Creates `_config_generated.yml` without syntax errors
3. **Error prevention** - Validates configuration before processing

**Check generated configuration**:
```bash
# After workflow runs, check the generated file
cat _config_generated.yml
```

## 📚 Related Workflows

- **[C/C++ Lint](c-cpp-lint-workflow.md)** - Code quality checks
- **[Static Analysis](c-cpp-static-analysis-workflow.md)** - Security analysis
- **[Link Check](docs-link-check-workflow.md)** - Documentation link validation

## 🔗 Related Resources

- [Doxygen Documentation](https://www.doxygen.nl/)
- [GitHub Pages](https://docs.github.com/en/pages)
- [Markdown Link Checking](https://github.com/tcort/markdown-link-check)

---

[← Previous: Static Analysis Workflow](c-cpp-static-analysis-workflow.md) | [Next: Link Check Workflow →](docs-link-check-workflow.md)

**📚 [All Documentation](index.md)** | **🏠 [Main README](../README.md)**

