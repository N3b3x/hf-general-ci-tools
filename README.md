# hf-general-ci-tools

A collection of reusable GitHub Actions workflows for general CI/CD tasks including C/C++ linting, static analysis, documentation generation, and link checking.

## 🚀 Available Workflows

- **[C/C++ Lint](.github/workflows/c-cpp-lint.yml)** - Code quality checks using clang-format and clang-tidy
- **[Static Analysis](.github/workflows/c-cpp-static-analysis.yml)** - Security analysis using cppcheck
- **[Documentation](.github/workflows/docs.yml)** - Doxygen documentation generation and GitHub Pages deployment
- **[Link Check](.github/workflows/docs-link-check.yml)** - Documentation link validation
- **[YAML Lint](.github/workflows/yamllint.yml)** - YAML file validation

## 📚 Documentation

Comprehensive documentation is available in the [docs/](docs/) directory:

- [Documentation Index](docs/index.md) - Overview and navigation
- [C/C++ Lint Workflow](docs/lint-workflow.md) - Code quality checks
- [Static Analysis Workflow](docs/static-analysis-workflow.md) - Security analysis
- [Documentation Workflow](docs/docs-workflow.md) - Documentation generation
- [Link Check Workflow](docs/link-check-workflow.md) - Link validation
- [YAML Lint Workflow](docs/yamllint-workflow.md) - YAML validation
- [Example Workflows](docs/example-workflows.md) - Complete workflow examples

## 🔧 Quick Start

### Basic CI Pipeline

```yaml
name: CI
on:
  push: { branches: [ main ] }
  pull_request: { branches: [ main ] }

jobs:
  lint:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      clang_version: "20"
      style: "file"
      extensions: "c,cpp,h,hpp"

  static:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
    with:
      paths: "src include"
      std: "c++17"
      strict: false

  docs:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/doxygen/html"

  link-check:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "docs/**,*.md"
```

## 📋 Prerequisites

- C/C++ project with proper structure
- GitHub Actions enabled in your repository
- Appropriate configuration files (e.g., `.clang-format`, `.clang-tidy`, `Doxyfile`)

## 🏗️ Project Structure

```
your-project/
├── .github/workflows/          # Your CI workflows
├── src/                        # Source code
├── include/                    # Headers
├── docs/                       # Documentation
├── .clang-format              # Code style configuration
├── .clang-tidy                # Static analysis configuration
├── Doxyfile                   # Documentation configuration
└── .yamllint                  # YAML linting configuration
```

## 🔗 Related Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Clang Format Documentation](https://clang.llvm.org/docs/ClangFormat.html)
- [Cppcheck Documentation](https://cppcheck.sourceforge.io/)
- [Doxygen Documentation](https://www.doxygen.nl/)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
