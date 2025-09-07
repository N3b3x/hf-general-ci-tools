# YAML Lint Workflow Guide

<div align="center">

[← Previous: Static Analysis Workflow](static-analysis-workflow.md) | [Next: Example Workflows →](example-workflows.md)

**📝 YAML File Validation**

</div>

---

The YAML Lint workflow validates YAML files in your repository using yamllint to ensure proper formatting and syntax.

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
- Workflow file validation
- Repository-wide YAML checking

**Use Case**: YAML file quality and consistency enforcement

## ⚙️ Inputs

This workflow runs automatically on push and pull requests to main/develop branches. It does not accept external inputs as it's designed to validate all YAML files in the repository.

## 📤 Outputs

| Output | Description |
|--------|-------------|
| Lint results | yamllint output for all YAML files |
| Configuration check | Validation of .yamllint configuration |

## 🚀 Usage Examples

### Automatic Usage

The workflow runs automatically on:
- Push to `main` and `develop` branches
- Pull requests to `main` and `develop` branches
- Manual workflow dispatch

### Manual Trigger

```yaml
# Triggered via workflow_dispatch
name: Manual YAML Lint
on:
  workflow_dispatch:
```

## ⚙️ Configuration

### .yamllint Configuration

Create a `.yamllint` file in your project root:

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
- Adjust line length in `.yamllint` configuration
- Break long lines appropriately
- Use YAML's line continuation features

**Indentation Problems**
- Use consistent 2-space indentation
- Avoid mixing tabs and spaces
- Check for proper nesting

### Debug Mode

Enable debug output by checking the workflow logs in GitHub Actions.

## 📚 Related Workflows

- **[C/C++ Lint](lint-workflow.md)** - Code quality checks
- **[Static Analysis](static-analysis-workflow.md)** - Security analysis
- **[Documentation](docs-workflow.md)** - Documentation generation

## 🔗 Related Resources

- [yamllint Documentation](https://yamllint.readthedocs.io/)
- [YAML Specification](https://yaml.org/spec/)
- [GitHub Actions YAML Reference](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)

---

<div align="center">

[← Previous: Static Analysis Workflow](static-analysis-workflow.md) | [Next: Example Workflows →](example-workflows.md)

**📚 [All Documentation](index.md)** | **🏠 [Main README](../README.md)**

</div>
