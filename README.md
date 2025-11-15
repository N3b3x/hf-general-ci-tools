---
layout: default
title: "🚀 hf-general-ci-tools"
description: "A comprehensive Link validation setup | Documentation maintainers |
| **[📝 YAML Linting Tools](docs/ru-yaml-lint.md)** | YAML validation configuration | DevOps engineers |
| **[📦 Release Management](docs/ru-release.md)** | Automated release creation | Release managers |
| **[🚀 CI Workflows & Design](docs/ci-workflows.md)** | Testing philosophy and live examples | All users |ollection of reusable GitHub Actions workflows for modern CI/CD pipelines"
nav_order: 1
permalink: /
---

# 🚀 hf-general-ci-tools

**A comprehensive collection of reusable GitHub Actions workflows for modern CI/CD pipelines**

---

[![Docs Publish CI](https://github.com/n3b3x/hf-general-ci-tools/actions/workflows/ci-docs-publish.yml/badge.svg)](https://github.com/n3b3x/hf-general-ci-tools/actions/workflows/ci-docs-publish.yml)
[![YAML Lint CI](https://github.com/n3b3x/hf-general-ci-tools/actions/workflows/ci-yaml-lint.yml/badge.svg)](https://github.com/n3b3x/hf-general-ci-tools/actions/workflows/ci-yaml-lint.yml)
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
| **[🔧 C/C++ Lint](.github/workflows/ru-cpp-lint.yml)** | Code quality and formatting checks | • clang-format<br>• clang-tidy<br>• Configurable rules | [→ Use Now](#-quick-start) |
| **[🛡️ Static Analysis](.github/workflows/ru-cpp-analysis.yml)** | Security and bug detection | • cppcheck integration<br>• Custom rules<br>• Multiple standards | [→ Use Now](#-quick-start) |
| **[📚 Documentation](.github/workflows/ru-docs-publish.yml)** | Documentation generation & deployment | • Doxygen support<br>• Jekyll sites<br>• GitHub Pages | [→ Use Now](#-quick-start) |
| **[🔗 Link Check](.github/workflows/ru-docs-linkcheck.yml)** | Documentation link validation | • Lychee integration<br>• Custom configs<br>• Exclude patterns | [→ Use Now](#-quick-start) |
| **[📝 YAML Lint](.github/workflows/ru-yaml-lint.yml)** | YAML file validation | • Syntax checking<br>• Style validation<br>• Custom rules | [→ Use Now](#-quick-start) |
| **[� Markdown Lint](.github/workflows/ru-markdown-lint.yml)** | Markdown file validation | • Syntax checking<br>• Style validation<br>• Auto-fix support | [→ Use Now](#-quick-start) |
| **[�📦 Release](.github/workflows/ru-release.yml)** | Automated GitHub releases | • Auto-generated notes<br>• Draft/prerelease support<br>• Tag-based releases | [→ Use Now](#-quick-start) |

---

## 🏠 Repository-Specific Workflows

> **Internal workflows** - These are used by this repository itself.

| Workflow | Purpose | Trigger | Status |
|----------|---------|---------|--------|
| **[📚 Docs Publish CI](.github/workflows/ci-docs-publish.yml)** | Builds and deploys this repo's documentation site | Push to main, PRs | ✅ Active |
| **[📝 YAML Lint CI](.github/workflows/ci-yaml-lint.yml)** | Validates YAML syntax in this repository | Push, PRs | ✅ Active |

---

## 📚 Documentation

**🌐 [Live Documentation Site](https://n3b3x.github.io/hf-general-ci-tools/)**  
*Published documentation with enhanced navigation and search*

### 📖 Available Guides

| Guide | Description | Target Audience |
|-------|-------------|-----------------|
| **[📋 Documentation Index](docs/index.md)** | Complete overview and navigation | All users |
| **[🔧 C/C++ Linting Tools](docs/ru-cpp-lint.md)** | Code quality and formatting setup | C/C++ developers |
| **[� C/C++ Static Analysis](docs/ru-cpp-analysis.md)** | Security analysis configuration | Security-focused teams |
| **[📚 Documentation Publisher](docs/ru-docs-publish.md)** | Documentation generation & deployment | Documentation teams |
| **[🔗 Documentation Link Check](docs/ru-docs-linkcheck.md)** | Link validation setup | Documentation maintainers |
| **[📝 YAML Linting Tools](docs/ru-yaml-lint.md)** | YAML validation configuration | DevOps engineers |
| **[� CI Workflows & Design](docs/ci-workflows.md)** | Testing philosophy and live examples | All users |

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
    uses: n3b3x/hf-general-ci-tools/.github/workflows/ru-cpp-lint.yml@v1
    with:
      clang_version: "20"
      style: "file"
      extensions: "c,cpp,h,hpp"

  # Security analysis
  static:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/ru-cpp-analysis.yml@v1
    with:
      paths: "src include"
      std: "c++17"
      strict: false

  # Documentation generation
  docs:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/ru-docs-publish.yml@v1
    with:
      doxygen_config: "_config/Doxyfile"
      output_dir: "docs/doxygen/html"

  # Link validation
  link-check:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/ru-docs-linkcheck.yml@v1
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
    uses: n3b3x/hf-general-ci-tools/.github/workflows/ru-cpp-lint.yml@v1
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
    uses: n3b3x/hf-general-ci-tools/.github/workflows/ru-docs-publish.yml@v1
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
    uses: n3b3x/hf-general-ci-tools/.github/workflows/ru-docs-linkcheck.yml@v1
    with:
      paths: "docs/**,*.md"
      verbose: true
      timeout: "30"
```
</details>

<details>
<summary><strong>� Markdown Validation Only</strong></summary>

```yaml
name: Docs Quality
on: [push, pull_request]
jobs:
  markdown:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/ru-markdown-lint.yml@v1
    with:
      globs: "docs/**/*.md *.md"
      fix: false
```
</details>

<details>
<summary><strong>�📦 Release Creation Only</strong></summary>

```yaml
name: Release
on:
  push:
    tags: ['v*']
jobs:
  release:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/ru-release.yml@v1
    with:
      draft: false
      prerelease: false
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

- **[Jekyll Integration Guide](docs/jekyll-guide.md)** - Advanced Jekyll configuration for documentation sites
- **[Versioning Guide](docs/versioning-guide.md)** - Multi-version documentation strategies

---

## 📄 License

**GNU General Public License v3.0** - See the [LICENSE](LICENSE) file for details

---

**⭐ Star this repository if you find it helpful!**

[Report Bug](https://github.com/n3b3x/hf-general-ci-tools/issues) • [Request Feature](https://github.com/n3b3x/hf-general-ci-tools/issues) • [Contribute](CONTRIBUTING.md)
