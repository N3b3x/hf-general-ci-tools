---
layout: default
title: "🚀 hf-general-ci-tools"
description: "A comprehensive collection of reusable GitHub Actions workflows for modern CI/CD pipelines"
nav_order: 1
permalink: /
---

# 🚀 hf-general-ci-tools

**A comprehensive collection of reusable GitHub Actions workflows for modern CI/CD pipelines**

---

[![Publish Docs](https://github.com/n3b3x/hf-general-ci-tools/actions/workflows/publish-docs.yml/badge.svg)](https://github.com/n3b3x/hf-general-ci-tools/actions/workflows/publish-docs.yml)
[![YAML Lint](https://github.com/n3b3x/hf-general-ci-tools/actions/workflows/yamllint.yml/badge.svg)](https://github.com/n3b3x/hf-general-ci-tools/actions/workflows/yamllint.yml)
[![License](https://img.shields.io/badge/license-GPL%20v3-blue.svg)](LICENSE)
[![GitHub Pages](https://img.shields.io/badge/docs-GitHub%20Pages-blue.svg)](https://n3b3x.github.io/hf-general-ci-tools)

*Streamline your development workflow with battle-tested, production-ready GitHub Actions*

---

## 📋 Overview

This repository provides a curated set of **reusable GitHub Actions workflows** designed to accelerate your CI/CD pipeline setup. Whether you're working on C/C++ projects, documentation, or need comprehensive quality checks, these workflows have you covered.

> **📖 [📚🌐 Live Complete Documentation](https://n3b3x.github.io/hf-general-ci-tools/)** - Interactive guides, examples, and step-by-step tutorials

### ✨ Key Features

- 🔧 **C/C++ Development** - Linting, static analysis, and code quality
- 📚 **Documentation** - Doxygen generation and GitHub Pages deployment
- 🔗 **Link Validation** - Comprehensive link checking for documentation
- 📝 **YAML Validation** - Ensure your workflow files are properly formatted
- 🎯 **Production Ready** - Battle-tested workflows used in real projects
- ⚙️ **Highly Configurable** - Extensive customization options
- 🚀 **Easy Integration** - Drop-in workflows for immediate use

---

## 🔄 Reusable Workflows

> **For other repositories** - These workflows are designed to be called from your own repositories

| Workflow | Description | Features | Quick Start |
|----------|-------------|----------|-------------|
| **[🔧 C/C++ Lint](.github/workflows/c-cpp-lint.yml)** | Code quality and formatting checks | • clang-format<br>• clang-tidy<br>• Configurable rules | [→ Use Now](#-quick-start) |
| **[🛡️ Static Analysis](.github/workflows/c-cpp-static-analysis.yml)** | Security and bug detection | • cppcheck integration<br>• Custom rules<br>• Multiple standards | [→ Use Now](#-quick-start) |
| **[📚 Documentation](.github/workflows/docs.yml)** | Documentation generation & deployment | • Doxygen support<br>• Jekyll sites<br>• GitHub Pages | [→ Use Now](#-quick-start) |
| **[🔗 Link Check](.github/workflows/docs-link-check.yml)** | Documentation link validation | • Lychee integration<br>• Custom configs<br>• Exclude patterns | [→ Use Now](#-quick-start) |
| **[📝 YAML Lint](.github/workflows/yamllint-reusable.yml)** | YAML file validation | • Syntax checking<br>• Style validation<br>• Custom rules | [→ Use Now](#-quick-start) |

---

## 🏠 Repository-Specific Workflows

> **Internal workflows** - These are used by this repository itself.

| Workflow | Purpose | Trigger | Status |
|----------|---------|---------|--------|
| **[📚 Publish Documentation](.github/workflows/publish-docs.yml)** | Builds and deploys this repo's documentation site | Push to main, PRs | ✅ Active |
| **[📝 YAML Lint](.github/workflows/yamllint.yml)** | Validates YAML syntax in this repository | Push, PRs | ✅ Active |

---

## 📚 Documentation

**🌐 [Live Documentation Site](https://n3b3x.github.io/hf-general-ci-tools/)**  
*Published documentation with enhanced navigation and search*

### 📖 Available Guides

| Guide | Description | Target Audience |
|-------|-------------|-----------------|
| **[📋 Documentation Index](docs/index.md)** | Complete overview and navigation | All users |
| **[🔧 C/C++ Lint Guide](docs/lint-workflow.md)** | Code quality and formatting setup | C/C++ developers |
| **[🛡️ Static Analysis Guide](docs/static-analysis-workflow.md)** | Security analysis configuration | Security-focused teams |
| **[📚 Documentation Guide](docs/docs-workflow.md)** | Documentation generation & deployment | Documentation teams |
| **[🔗 Link Check Guide](docs/link-check-workflow.md)** | Link validation setup | Documentation maintainers |
| **[📝 YAML Lint Guide](docs/yamllint-workflow.md)** | YAML validation configuration | DevOps engineers |
| **[💡 Example Workflows](docs/example-workflows.md)** | Complete workflow examples | All users |

---

## 🚀 Quick Start

> **📚 [View Complete Documentation](https://n3b3x.github.io/hf-general-ci-tools/)** - Interactive guides, examples, and configuration templates

### 🎯 Using Reusable Workflows

> **For other repositories** - Copy and customize these examples for your project

#### 🔧 Basic CI Pipeline

```yaml
name: 🚀 CI Pipeline
on:
  push: { branches: [ main ] }
  pull_request: { branches: [ main ] }

jobs:
  # Code quality checks
  lint:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      clang_version: "20"
      style: "file"
      extensions: "c,cpp,h,hpp"

  # Security analysis
  static:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
    with:
      paths: "src include"
      std: "c++17"
      strict: false

  # Documentation generation
  docs:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: "_config/Doxyfile"
      output_dir: "docs/doxygen/html"

  # Link validation
  link-check:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "docs/**,*.md"
```

#### 🎨 Individual Workflow Examples

<details>
<summary><strong>🔧 C/C++ Linting Only</strong></summary>

```yaml
name: Code Quality
on: [push, pull_request]
jobs:
  lint:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      source_dirs: "src/"
      include_patterns: "*.cpp,*.hpp,*.c,*.h"
      clang_version: "20"
      style: "file"
```
</details>

<details>
<summary><strong>📚 Documentation Only</strong></summary>

```yaml
name: Build Docs
on: [push]
jobs:
  docs:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      jekyll_enabled: true
      jekyll_source: "docs"
      deploy_pages: true
      run_link_check: true
```
</details>

<details>
<summary><strong>🔗 Link Checking Only</strong></summary>

```yaml
name: Check Links
on: [push, pull_request]
jobs:
  link-check:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "docs/**,*.md"
      verbose: true
      timeout: "30"
```
</details>

---

## 📋 Prerequisites

### ✅ Required Setup

| Requirement | Description | Example |
|-------------|-------------|---------|
| **GitHub Actions** | Enabled in your repository | Repository Settings → Actions |
| **Project Structure** | Proper C/C++ project layout | `src/`, `include/`, `docs/` |
| **Configuration Files** | Tool-specific configs | `_config/.clang-format`, `_config/.clang-tidy`, `_config/.yamllint` |

### 🏗️ Recommended Project Structure

```
your-awesome-project/
├── .github/workflows/          # Your CI workflows
│   └── ci.yml                  # Main CI pipeline
├── src/                        # Source code
│   ├── main.cpp
│   └── utils/
├── include/                    # Header files
│   └── utils.h
├── docs/                       # Documentation
│   ├── index.md
│   └── api/
├── _config/                   # Centralized lint/documentation configs
│   ├── Doxyfile               # Documentation configuration (run from repo root)
│   ├── .clang-format
│   ├── .clang-tidy
│   ├── .markdownlint.json
│   ├── .markdownlint-rules.md
│   └── .yamllint
├── cpp-ci-test/               # Sample C/C++ sources for CI testing and Doxygen
└── README.md                  # Project documentation
```

---

## 🔗 Related Resources

### 📚 Official Documentation

| Tool | Documentation | Purpose |
|------|---------------|---------|
| **[GitHub Actions](https://docs.github.com/en/actions)** | Official GitHub Actions docs | Workflow syntax and features |
| **[Clang Format](https://clang.llvm.org/docs/ClangFormat.html)** | Code formatting tool | Style configuration |
| **[Cppcheck](https://cppcheck.sourceforge.io/)** | Static analysis tool | Bug and security detection |
| **[Doxygen](https://www.doxygen.nl/)** | Documentation generator | API documentation |
| **[Jekyll](https://jekyllrb.com/)** | Static site generator | Documentation websites |

### 🛠️ Configuration Examples

- **[Configuration Examples](docs/configuration-examples.md)** - Ready-to-use config files
- **[Example Workflows](docs/example-workflows.md)** - Complete workflow examples

---

## 📄 License

**GNU General Public License v3.0** - See the [LICENSE](LICENSE) file for details

---

> **🧪 [Test 404 Page](nonexistent-page)** - (on live documentation) Click this link to test our custom 404 page!

**⭐ Star this repository if you find it helpful!**

[Report Bug](https://github.com/n3b3x/hf-general-ci-tools/issues) • [Request Feature](https://github.com/n3b3x/hf-general-ci-tools/issues) • [Contribute](CONTRIBUTING.md)
