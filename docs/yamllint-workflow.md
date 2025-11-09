---
layout: default
title: "📝 YAML Lint Workflow"
description: "YAML file validation and formatting"
nav_order: 5
parent: "🔄 Reusable Workflows"
---

# YAML Lint Workflow Guide

**📝 YAML File Validation**

---

The YAML Lint workflow validates YAML files in your repository using yamllint to ensure proper formatting and syntax.
This is a **reusable workflow** that can be called from other repositories.

## 📋 Table of Contents

- [Overview](#-overview)
- [Inputs](#-inputs)
- [Outputs](#-outputs)
- [Usage Examples](#-usage-examples)
- [Configuration](#-configuration)
- [Troubleshooting](#-troubleshooting)
- [Related Workflows](#-related-workflows)

## 🎯 Overview

**Purpose**: YAML file validation and formatting
**Key Features**:
- yamllint integration
- Configurable rules
- Flexible path specification
- Exclude patterns support
- Strict mode option
- Detailed reporting

**Use Case**: YAML file quality and consistency enforcement

## ⚙️ Inputs

### 📁 File Selection

| Input | Description | Required | Default | Type |
|-------|-------------|----------|---------|------|
| `paths` | Comma-separated list of paths to check | No | `**/*.yml,**/*.yaml` | string |
| `exclude_patterns` | Comma-separated patterns to exclude | No | `.git/**,node_modules/**,venv/**,.venv/**` | string |

### ⚙️ Configuration

| Input | Description | Required | Default | Type |
|-------|-------------|----------|---------|------|
| `config_file` | Path to yamllint configuration file | No | `_config/.yamllint` | string |
| `strict_mode` | Enable strict mode (fail on warnings) | No | `false` | boolean |

## 📤 Outputs

| Output | Description |
|--------|-------------|
| `result` | YAML lint result (success/failure) |
| `files_checked` | Number of files checked |
| `issues_found` | Number of issues found |

## 🚀 Usage Examples

### Basic Usage

```yaml
name: YAML Lint
on: [push, pull_request]
jobs:
  yamllint:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/yamllint-reusable.yml@v1
```

### Advanced Usage

```yaml
name: YAML Lint
on: [push, pull_request]
jobs:
  yamllint:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/yamllint-reusable.yml@v1
    with:
      paths: '.github/workflows/*.yml,docs/*.yml'
      config_file: '_config/.yamllint'
      strict_mode: true
      exclude_patterns: '.git/**,node_modules/**,_site/**'
```

### Workflow-Only Checking

```yaml
name: Workflow YAML Lint
on: [push, pull_request]
jobs:
  yamllint:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/yamllint-reusable.yml@v1
    with:
      paths: '.github/workflows/*.yml'
      strict_mode: true
```

### Comprehensive Configuration

```yaml
name: Complete YAML Lint
on: [push, pull_request]
jobs:
  yamllint:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/yamllint-reusable.yml@v1
    with:
      paths: '.github/workflows/*.yml,docs/*.yml,**/*.yaml'
      config_file: '_config/.yamllint'
      strict_mode: true
      exclude_patterns: '.git/**,node_modules/**,venv/**,.venv/**,_site/**'
```

## ⚙️ Configuration

### `_config/.yamllint` Configuration

Create a `_config/.yamllint` file in your project (relative to the repository root):

```yaml
extends: default

rules:
  line-length:
    max: 120
    level: warning
  indentation:
    spaces: 2
  comments:
    min-spaces-from-content: 1
  document-start:
    present: true
  truthy:
    allowed-values: ['true', 'false', 'on', 'off']
```

### Default Rules

The workflow uses yamllint with these default settings:
- Line length: 120 characters (warning)
- Indentation: 2 spaces
- Document start: Required
- Comments: Proper spacing

## 🔧 Troubleshooting

### Common Issues

**YAML Syntax Errors**
- Check for proper indentation (2 spaces)
- Verify YAML syntax is valid
- Ensure proper document structure

**Line Length Issues**
- Adjust line length in `_config/.yamllint` configuration
- Break long lines appropriately
- Use YAML's line continuation features

**Indentation Problems**
- Use consistent 2-space indentation
- Avoid mixing tabs and spaces
- Check for proper nesting

### Debug Mode

Enable debug output by checking the workflow logs in GitHub Actions.

## 📚 Related Workflows

- **[C/C++ Lint](c-cpp-lint-workflow.md)** - Code quality checks
- **[Static Analysis](c-cpp-static-analysis-workflow.md)** - Security analysis
- **[Documentation](docs-workflow.md)** - Documentation generation

## 🔗 Related Resources

- [yamllint Documentation](https://yamllint.readthedocs.io/)
- [YAML Specification](https://yaml.org/spec/)
- [GitHub Actions YAML Reference](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)

---

[← Previous: Link Check Workflow](docs-link-check-workflow.md)

**📚 [All Documentation](index.md)** | **🏠 [Main README](../README.md)**
