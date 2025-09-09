---
layout: default
title: "🛡️ Static Analysis Workflow"
description: "Security analysis using cppcheck"
nav_order: 2
parent: "🔄 Reusable Workflows"
---

# Static Analysis Workflow Guide

[← Previous: Link Check Workflow](link-check-workflow.md) | [Next: Example Workflows →](example-workflows.md)

**🔒 Cppcheck Security Analysis**

---

The Static Analysis workflow runs cppcheck via Docker for comprehensive C/C++ code analysis with configurable strictness and artifact generation.

## 📋 Table of Contents

- [Overview](#-overview)
- [Inputs](#-inputs)
- [Outputs](#-outputs)
- [Usage Examples](#-usage-examples)
- [Configuration](#-configuration)
- [Troubleshooting](#-troubleshooting)
- [Related Workflows](#-related-workflows)

## 🎯 Overview

**Purpose**: Security and quality analysis with cppcheck  
**Key Features**: 
- Docker-based cppcheck execution
- XML and text output formats
- Configurable strictness levels
- Artifact storage

**Use Case**: Security scanning and bug detection in C/C++ code

## ⚙️ Inputs

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `paths` | string | ❌ | `src inc examples` | Space-separated directories to analyze |
| `std` | string | ❌ | `c++17` | C++ standard for analysis |
| `strict` | boolean | ❌ | `false` | Fail job if issues found |

## 📤 Outputs

| Output | Description |
|--------|-------------|
| `cppcheck_report.xml` | XML format analysis report |
| `cppcheck_output.txt` | Human-readable output |
| Artifacts | Uploaded reports for review |

## 🚀 Usage Examples

### Basic Usage

```yaml
jobs:
  static:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
    with:
      paths: "src include"
      std: "c++17"
      strict: false
```

### Strict Mode

```yaml
jobs:
  static:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
    with:
      paths: "src include"
      std: "c++20"
      strict: true  # Fail on any issues
```

### Custom Paths

```yaml
jobs:
  static:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
    with:
      paths: "src lib tests"
      std: "c++14"
      strict: false
```

## ⚙️ Configuration

### cppcheck Configuration

The workflow uses these cppcheck options:

```bash
cppcheck \
  --enable=warning,style,performance,portability \
  --suppress=missingIncludeSystem \
  --inline-suppr \
  --std=c++17 \
  --xml \
  --output-file=cppcheck_report.xml
```

### Suppression Files

Create a `.cppcheck-suppressions` file for false positives:

```cpp
// Suppress specific warnings
// unusedFunction:src/legacy.c
// missingInclude:src/third_party.h
```

## 🔧 Troubleshooting

### Common Issues

**Analysis Fails**
- Verify source directories exist
- Check Docker is available
- Ensure paths are space-separated

**Too Many False Positives**
- Use suppression files
- Adjust enabled checks
- Review cppcheck configuration

**Strict Mode Too Restrictive**
- Set `strict: false` for development
- Review issues before enabling strict mode
- Use suppressions for known false positives

## 📚 Related Workflows

- **[C/C++ Lint](lint-workflow.md)** - Code quality checks
- **[Documentation](docs-workflow.md)** - Documentation generation
- **[Link Check](link-check-workflow.md)** - Documentation link validation

## 🔗 Related Resources

- [cppcheck Documentation](https://cppcheck.sourceforge.io/)
- [cppcheck Docker Image](https://github.com/facthunder/cppcheck)
- [Static Analysis Best Practices](https://en.wikipedia.org/wiki/Static_program_analysis)

---

[← Previous: Link Check Workflow](link-check-workflow.md) | [Next: Example Workflows →](example-workflows.md)

**📚 [All Documentation](index.md)** | **🏠 [Main README](../README.md)**

