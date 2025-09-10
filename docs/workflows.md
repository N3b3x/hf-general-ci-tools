---
layout: default
title: "🔄 Reusable Workflows"
description: "Collection of reusable GitHub Actions workflows for CI/CD tasks"
nav_order: 2
has_children: true
permalink: /workflows/
---

# Reusable Workflows

This section contains all the reusable GitHub Actions workflows available in this repository.

## Available Workflows

- **[C/C++ Lint Workflow](c-cpp-lint-workflow.md)** - Code quality checks using clang-format and clang-tidy
- **[Static Analysis Workflow](c-cpp-static-analysis-workflow.md)** - Security analysis using cppcheck
- **[Documentation Workflow](docs-workflow.md)** - Doxygen documentation generation and GitHub Pages deployment
- **[Link Check Workflow](docs-link-check-workflow.md)** - Documentation link validation using Lychee
- **[YAML Lint Workflow](yamllint-workflow.md)** - YAML file validation and formatting

## Usage

Each workflow is designed to be reusable and can be called from other repositories. See the individual
workflow documentation for detailed usage instructions and parameters.
