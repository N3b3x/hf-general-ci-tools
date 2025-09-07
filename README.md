# GitHub Actions Workflows

A collection of reusable GitHub Actions workflows for general-purpose CI/CD tasks, including C/C++ linting, static analysis, documentation generation, and link checking.

## 🚀 Available Workflows

This repository provides the following reusable workflows:

| Workflow | Description | File |
|----------|-------------|------|
| **C/C++ Lint** | Code quality checks using clang-format and clang-tidy | `c-cpp-lint.yml` |
| **Static Analysis** | Security and quality analysis using cppcheck | `c-cpp-static-analysis.yml` |
| **Documentation** | Doxygen documentation generation and GitHub Pages deployment | `docs.yml` |
| **Link Check** | Documentation link validation | `docs-link-check.yml` |
| **YAML Lint** | YAML file validation and formatting | `yamllint.yml` |

## 📋 Quick Start

### Basic Usage

```yaml
name: CI Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  # Lint C/C++ code
  lint:
    uses: your-org/github-actions-workflows/.github/workflows/c-cpp-lint.yml@main
    with:
      clang_version: "20"
      extensions: "c,cpp,h,hpp"

  # Run static analysis
  static-analysis:
    uses: your-org/github-actions-workflows/.github/workflows/c-cpp-static-analysis.yml@main
    with:
      paths: "src inc examples"
      strict: false

  # Check documentation links
  link-check:
    uses: your-org/github-actions-workflows/.github/workflows/docs-link-check.yml@main
    with:
      paths: "docs/**,*.md"
```

### Advanced Usage

```yaml
name: Advanced CI Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  # Comprehensive linting
  lint:
    uses: your-org/github-actions-workflows/.github/workflows/c-cpp-lint.yml@main
    with:
      clang_version: "20"
      style: "google"
      tidy_checks: "readability-*,performance-*,modernize-*"
      extensions: "c,cpp,cc,cxx,h,hpp"
      ignore: "build|.git|third_party"
      files_changed_only: true
      thread_comments: true

  # Strict static analysis
  static-analysis:
    uses: your-org/github-actions-workflows/.github/workflows/c-cpp-static-analysis.yml@main
    with:
      paths: "src lib tests"
      std: "c++20"
      strict: true

  # Build and deploy documentation
  docs:
    uses: your-org/github-actions-workflows/.github/workflows/docs.yml@main
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/html"
      run_link_check: true
      run_markdown_lint: true
      run_spell_check: true
      deploy_pages: true

  # Comprehensive link checking
  link-check:
    uses: your-org/github-actions-workflows/.github/workflows/docs-link-check.yml@main
    with:
      paths: "docs/**,*.md,**/docs/**"
      fail_on_errors: true
```

## 📚 Documentation

Detailed documentation for each workflow is available in the [`docs/`](docs/) directory:

- [Documentation Index](docs/index.md) - Overview and navigation
- [C/C++ Lint Workflow](docs/lint-workflow.md) - Code quality checks
- [Static Analysis Workflow](docs/static-analysis-workflow.md) - Security analysis
- [Documentation Workflow](docs/docs-workflow.md) - Doxygen and GitHub Pages
- [Link Check Workflow](docs/link-check-workflow.md) - Link validation
- [Example Workflows](docs/example-workflows.md) - Complete usage examples

## 🔧 Workflow Details

### C/C++ Lint Workflow

**Purpose**: Code quality enforcement using clang-format and clang-tidy  
**Key Features**:
- Configurable clang versions (18, 19, 20)
- Multiple style options (llvm, google, webkit, file)
- PR annotations and comments
- File and line-level filtering
- Performance optimizations for large projects

### Static Analysis Workflow

**Purpose**: Security and quality analysis using cppcheck  
**Key Features**:
- Docker-based cppcheck execution
- XML and text output formats
- Configurable strictness levels
- Artifact storage for reports
- Support for multiple C++ standards

### Documentation Workflow

**Purpose**: Doxygen documentation generation and deployment  
**Key Features**:
- Doxygen + Graphviz integration
- GitHub Pages deployment
- Link checking integration
- Markdown linting and spell checking
- Artifact storage

### Link Check Workflow

**Purpose**: Documentation link validation  
**Key Features**:
- External and internal link checking
- Configurable path patterns
- Detailed error reporting
- Integration with documentation workflows

## 🛠️ Configuration

### Required Files

Some workflows may require configuration files in your repository:

- `.clang-format` - For C/C++ code formatting
- `.clang-tidy` - For static analysis configuration
- `Doxyfile` - For documentation generation
- `.cspell.json` - For spell checking (optional)
- `.markdownlint.json` - For markdown linting (optional)

### Permissions

Some workflows require specific permissions:

```yaml
permissions:
  contents: read          # For most workflows
  contents: write         # For documentation deployment
  pages: write           # For GitHub Pages
  id-token: write        # For GitHub Pages authentication
  pull-requests: write   # For PR comments and annotations
```

## 🔗 Related Projects

- **[N3b3/hf-espidf-ci-tools](https://github.com/N3b3/hf-espidf-ci-tools)** - ESP-IDF specific CI tools and workflows for ESP32 development

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

If you encounter any issues or have questions, please open an issue in this repository.