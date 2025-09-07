# Documentation Index

<div align="center">

[← Previous: Example Workflows](example-workflows.md) | [Next: C/C++ Lint Workflow →](lint-workflow.md)

**📋 Documentation Index and Navigation**

</div>

---

Welcome to the hf-general-ci-tools documentation! This guide provides comprehensive coverage of all reusable CI workflows and how to integrate them into your projects.

## 🚀 Quick Navigation

| Workflow | Description | Quick Start |
|----------|-------------|-------------|
| **[C/C++ Lint](lint-workflow.md)** | C/C++ code quality checks | [→ Lint Guide](lint-workflow.md) |
| **[Static Analysis](static-analysis-workflow.md)** | Cppcheck security analysis | [→ Static Analysis Guide](static-analysis-workflow.md) |
| **[Docs](docs-workflow.md)** | Doxygen + GitHub Pages deployment | [→ Docs Guide](docs-workflow.md) |
| **[Link Check](link-check-workflow.md)** | Documentation link validation | [→ Link Check Guide](link-check-workflow.md) |
| **[YAML Lint](yamllint-workflow.md)** | YAML file validation | [→ YAML Lint Guide](yamllint-workflow.md) |

## 📋 Prerequisites

Before using these workflows, ensure you have:

1. **C/C++ project** with proper structure
2. **GitHub Actions enabled** in your repository
3. **Appropriate configuration files** (e.g., `.clang-format`, `.clang-tidy`, `Doxyfile`)

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

## 🔧 Basic Setup

### 1. Create Your First CI Workflow

```yaml
# .github/workflows/ci.yml
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

## 📚 Workflow Details

### C/C++ Lint Workflow
- **Purpose**: C/C++ code quality enforcement
- **Key Features**: clang-format, clang-tidy, PR annotations
- **Use Case**: Code style consistency and quality checks

[→ Full Lint Guide](lint-workflow.md)

### Static Analysis Workflow
- **Purpose**: Security and quality analysis with cppcheck
- **Key Features**: Docker-based analysis, XML reports, configurable strictness
- **Use Case**: Security scanning and bug detection

[→ Full Static Analysis Guide](static-analysis-workflow.md)

### Documentation Workflow
- **Purpose**: Generate and deploy Doxygen documentation
- **Key Features**: GitHub Pages, link checking, artifact storage
- **Use Case**: Project documentation automation

[→ Full Docs Guide](docs-workflow.md)

### Link Check Workflow
- **Purpose**: Documentation link validation
- **Key Features**: External/internal link checking, anchor validation
- **Use Case**: Documentation integrity

[→ Full Link Check Guide](link-check-workflow.md)

### YAML Lint Workflow
- **Purpose**: YAML file validation and formatting
- **Key Features**: yamllint integration, configurable rules
- **Use Case**: YAML file quality and consistency

[→ Full YAML Lint Guide](yamllint-workflow.md)

## 🔄 Workflow Combinations

### Full CI Pipeline
```yaml
# Combines all workflows for comprehensive CI
jobs:
  lint:     # Code quality
  static:   # Security analysis
  docs:     # Documentation
  links:    # Link checking
  yaml:     # YAML validation
```

### Documentation Pipeline
```yaml
# Documentation generation and deployment
jobs:
  docs:     # Build and deploy docs
  links:    # Check documentation links
```

### Code Quality Pipeline
```yaml
# Code quality focused workflows
jobs:
  lint:     # Code style and quality
  static:   # Static analysis
  yaml:     # YAML validation
```

## 📖 Next Steps

1. **Choose your workflows** based on your project needs
2. **Read the individual guides** for detailed configuration
3. **Customize inputs** to match your project structure
4. **Test with a simple workflow** before adding complexity

## 🔗 Related Resources

- [Main Repository](https://github.com/N3b3x/hf-general-ci-tools)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Clang Format Documentation](https://clang.llvm.org/docs/ClangFormat.html)
- [Cppcheck Documentation](https://cppcheck.sourceforge.io/)
- [Doxygen Documentation](https://www.doxygen.nl/)

---

<div align="center">

[← Previous: Example Workflows](example-workflows.md) | [Next: C/C++ Lint Workflow →](lint-workflow.md)

**📚 [All Documentation](index.md)** | **🏠 [Main README](../README.md)**

</div>
