---
layout: default
title: "🔄 Reusable Workflows"
description: "Reusable GitHub Actions workflows for CI/CD tasks"
nav_order: 3
has_children: true
---

# 🔄 Reusable Workflows

These workflows are designed to be **called from other repositories** using the `uses` keyword. Each workflow provides specific CI/CD functionality that can be integrated into your project's GitHub Actions.

## Available Workflows

- **[🔧 C/C++ Lint Workflow](lint-workflow.md)** - Code quality checks using clang-format and clang-tidy
- **[🛡️ Static Analysis Workflow](static-analysis-workflow.md)** - Security analysis using cppcheck
- **[📚 Documentation Workflow](docs-workflow.md)** - Doxygen documentation generation and GitHub Pages deployment
- **[🔗 Link Check Workflow](link-check-workflow.md)** - Documentation link validation using Lychee
- **[📝 YAML Lint Workflow](yamllint-workflow.md)** - YAML file validation and formatting

## Quick Start

To use any of these workflows in your repository, add them to your `.github/workflows/` directory:

```yaml
name: CI
on: [push, pull_request]
jobs:
  lint:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      source_dirs: "src/"
```

## Features

- **🔄 Reusable** - Drop-in workflows for common CI tasks
- **⚙️ Configurable** - Extensive input parameters for customization
- **📚 Well Documented** - Comprehensive guides and examples
- **🛡️ Secure** - Follows GitHub Actions security best practices
- **🚀 Fast** - Optimized for performance and reliability
