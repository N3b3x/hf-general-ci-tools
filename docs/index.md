---
layout: default
title: "hf-general-ci-tools"
description: "Reusable GitHub Actions workflows for CI/CD"
nav_order: 1
---

# hf-general-ci-tools

**A collection of reusable GitHub Actions workflows for general CI/CD tasks**

---

## 🔄 Reusable Workflows

**These workflows are designed to be used by other repositories:**

| Workflow | Description | Quick Start |
|----------|-------------|-------------|
| **[C/C++ Lint](lint-workflow.md)** | Code quality checks using clang-format and clang-tidy | [→ Lint Guide](lint-workflow.md) |
| **[Static Analysis](static-analysis-workflow.md)** | Security analysis using cppcheck | [→ Static Analysis Guide](static-analysis-workflow.md) |
| **[Documentation](docs-workflow.md)** | Doxygen documentation generation and GitHub Pages deployment | [→ Docs Guide](docs-workflow.md) |
| **[Link Check](link-check-workflow.md)** | Documentation link validation | [→ Link Check Guide](link-check-workflow.md) |
| **[YAML Lint](yamllint-workflow.md)** | YAML file validation and formatting | [→ YAML Lint Guide](yamllint-workflow.md) |

## 🏠 Repository-Specific Workflows

**These workflows are used internally by this repository:**

| Workflow | Purpose | Trigger |
|----------|---------|---------|
| **[Publish Documentation](https://github.com/n3b3x/hf-general-ci-tools/blob/main/.github/workflows/publish-docs.yml)** | Builds and deploys this repo's documentation site | Push to main, PRs |
| **[YAML Lint](https://github.com/n3b3x/hf-general-ci-tools/blob/main/.github/workflows/yamllint.yml)** | Validates YAML syntax in this repository (uses reusable workflow) | Push, PRs |

## 📚 Documentation

Comprehensive documentation is available for each workflow:

- **[Documentation Index](index.md)** - This page
- **[C/C++ Lint Workflow](lint-workflow.md)** - Code quality checks
- **[Static Analysis Workflow](static-analysis-workflow.md)** - Security analysis
- **[Documentation Workflow](docs-workflow.md)** - Documentation generation
- **[Link Check Workflow](link-check-workflow.md)** - Link validation
- **[YAML Lint Workflow](yamllint-workflow.md)** - YAML validation
- **[Example Workflows](example-workflows.md)** - Real-world usage examples
- **[Configuration Examples](configuration-examples.md)** - Configuration templates

## 🎯 Quick Start

### 1. Choose Your Reusable Workflow

Select the appropriate **reusable workflow** for your needs:

```yaml
# For C/C++ projects
uses: n3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1

# For documentation
uses: n3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1

# For link checking
uses: n3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1

# For YAML validation
uses: n3b3x/hf-general-ci-tools/.github/workflows/yamllint-reusable.yml@v1
```

> **Note:** These are **reusable workflows** designed to be called from other repositories. The repository-specific workflows (like `publish-docs.yml`) are only used internally by this repository.

### 2. Configure Your Workflow

Each workflow supports extensive configuration options. See the individual workflow documentation for details.

### 3. Deploy

The workflows will automatically run on your specified triggers and provide detailed feedback.

## 🔧 Features

- **🔄 Reusable** - Drop-in workflows for common CI tasks
- **⚙️ Configurable** - Extensive input parameters for customization
- **📚 Well Documented** - Comprehensive guides and examples
- **🛡️ Secure** - Follows GitHub Actions security best practices
- **🚀 Fast** - Optimized for performance and reliability

## 📋 Workflow Types

### 🔄 Reusable Workflows
These workflows are designed to be **called from other repositories** using the `uses` keyword:

```yaml
jobs:
  my-job:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      jekyll_enabled: true
      deploy_pages: true
```

### 🏠 Repository-Specific Workflows
These workflows are **only used internally** by this repository:

- **`publish-docs.yml`** - Builds and deploys this repo's documentation site
- **`yamllint.yml`** - Validates YAML syntax in this repository

> **For other repositories:** Only use the **reusable workflows** listed in the "Reusable Workflows" section above.

## 📖 Usage Examples

### Basic C/C++ Linting

```yaml
name: Code Quality
on: [push, pull_request]
jobs:
  lint:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      source_dirs: "src/"
      include_patterns: "*.cpp,*.hpp,*.c,*.h"
```

### Documentation Generation

```yaml
name: Documentation
on: [push]
jobs:
  docs:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      jekyll_enabled: true
      run_link_check: true
      deploy_pages: true
```

### Link Validation

```yaml
name: Link Check
on: [push, pull_request]
jobs:
  links:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "docs/**,*.md"
      verbose: true
```

## 🤝 Contributing

Contributions are welcome! Please see our [Contributing Guidelines](https://github.com/n3b3x/hf-general-ci-tools/blob/main/CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/n3b3x/hf-general-ci-tools/blob/main/LICENSE) file for details.

## 🙏 Acknowledgments

- GitHub Actions team for the excellent CI/CD platform
- The open source community for inspiration and feedback
- All contributors who help improve these workflows

---

**Made with ❤️ by [N3b3x](https://github.com/n3b3x)**

[GitHub](https://github.com/n3b3x/hf-general-ci-tools) • [Issues](https://github.com/n3b3x/hf-general-ci-tools/issues)
