# GitHub Actions Workflows

A collection of reusable GitHub Actions workflows for general-purpose CI/CD tasks, including C/C++ linting, static analysis, documentation generation, and link checking.

## 🚀 Available Workflows

This repository provides both **reusable workflows** for external use and **internal workflows** for repository quality assurance.

### 🔄 **Reusable Workflows** (For External Use)

These workflows are designed to be used by other repositories:

| Workflow | Description | File | Usage |
|----------|-------------|------|-------|
| **C/C++ Lint** | Code quality checks using clang-format and clang-tidy | `c-cpp-lint.yml` | `uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@main` |
| **Static Analysis** | Security and quality analysis using cppcheck | `c-cpp-static-analysis.yml` | `uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@main` |
| **Documentation** | Doxygen documentation generation and GitHub Pages deployment | `docs.yml` | `uses: N3B3x/hf-general-ci-tools/.github/workflows/docs.yml@main` |
| **Link Check** | Documentation link validation | `docs-link-check.yml` | `uses: N3B3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@main` |

### 🏠 **Internal Repository Workflows** (For This Repository)

These workflows are used internally to maintain repository quality:

| Workflow | Description | File | Purpose |
|----------|-------------|------|---------|
| **Comprehensive Linting** | Quality assurance for this repository | `linting.yml` | Ensures all YAML, Markdown files, and links meet quality standards |
| **YAML Lint** | YAML file validation and formatting | `yamllint.yml` | Validates GitHub Actions workflow files and other YAML files |

## 📋 Quick Start

### Using Reusable Workflows

To use these workflows in your own repository, add them to your `.github/workflows/` directory:

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
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@main
    with:
      clang_version: "20"
      extensions: "c,cpp,h,hpp"

  # Run static analysis
  static-analysis:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@main
    with:
      paths: "src inc examples"
      strict: false

  # Check documentation links
  link-check:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@main
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
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@main
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
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@main
    with:
      paths: "src lib tests"
      std: "c++20"
      strict: true

  # Build and deploy documentation
  docs:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs.yml@main
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/html"
      run_link_check: true
      run_markdown_lint: true
      run_spell_check: true
      deploy_pages: true

  # Comprehensive link checking
  link-check:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@main
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

## 🏠 Internal Repository Quality Assurance

This repository uses internal workflows to maintain high quality standards:

### Quality Checks Performed

- **YAML Validation**: All workflow files are validated using yamllint
- **Markdown Linting**: Documentation follows markdownlint standards  
- **Link Validation**: All documentation links are checked for validity
- **Code Quality**: Consistent formatting and style across all files

### Internal Workflow Triggers

- **Push Events**: Quality checks run on every push to main/develop branches
- **Pull Requests**: All PRs are validated before merging
- **Manual Dispatch**: Quality checks can be triggered manually

### Repository Standards

- **Line Length**: 250 characters for markdown, 120 for YAML
- **Formatting**: Consistent indentation and structure
- **Links**: All documentation links must be valid
- **Spelling**: Technical terms and proper nouns are properly spelled

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

## 📊 Workflow Summary

### 🔄 Reusable Workflows (4)
- **c-cpp-lint.yml** - C/C++ code quality and formatting
- **c-cpp-static-analysis.yml** - Security and quality analysis  
- **docs.yml** - Documentation generation and deployment
- **docs-link-check.yml** - Documentation link validation

### 🏠 Internal Workflows (2)
- **linting.yml** - Comprehensive quality assurance
- **yamllint.yml** - YAML file validation

## 🔗 Related Projects

- **[N3B3x/hf-espidf-ci-tools](https://github.com/N3B3x/hf-espidf-ci-tools)** - ESP-IDF specific CI tools and workflows for ESP32 development

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

If you encounter any issues or have questions, please open an issue in this repository.