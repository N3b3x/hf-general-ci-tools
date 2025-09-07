# Documentation Index

<div align="center">

[← Previous: Example Workflows](example-workflows.md) | [Next: Lint Workflow →](lint-workflow.md)

**📋 Documentation Index and Navigation**

</div>

---

Welcome to the GitHub Actions Workflows documentation! This guide provides comprehensive coverage of all reusable workflows and how to integrate them into your projects.

## 🚀 Quick Navigation

| Workflow | Description | Quick Start |
|----------|-------------|-------------|
| **[Lint](lint-workflow.md)** | C/C++ code quality checks | [→ Lint Guide](lint-workflow.md) |
| **[Static Analysis](static-analysis-workflow.md)** | Cppcheck security analysis | [→ Static Analysis Guide](static-analysis-workflow.md) |
| **[Docs](docs-workflow.md)** | Doxygen + GitHub Pages deployment | [→ Docs Guide](docs-workflow.md) |
| **[Link Check](link-check-workflow.md)** | Documentation link validation | [→ Link Check Guide](link-check-workflow.md) |

## 📋 Prerequisites

Before using these workflows, ensure you have:

1. **GitHub repository** with GitHub Actions enabled
2. **C/C++ project** (for lint and static analysis workflows)
3. **Documentation files** (for documentation and link check workflows)

## 🔧 Basic Setup

### Create Your First CI Workflow

```yaml
# .github/workflows/ci.yml
name: CI
on:
  push: { branches: [ main ] }
  pull_request: { branches: [ main ] }

jobs:
  lint:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@main
    with:
      clang_version: "20"
      extensions: "c,cpp,h,hpp"

  static-analysis:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@main
    with:
      paths: "src inc examples"
      strict: false

  link-check:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@main
    with:
      paths: "docs/**,*.md"
```

## 📚 Workflow Details

### Linting Workflow
- **Purpose**: C/C++ code quality enforcement
- **Key Features**: clang-format, clang-tidy, PR annotations
- **Use Case**: Code style consistency

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

## 🔄 Workflow Combinations

### Full CI Pipeline
```yaml
# Combines all workflows for comprehensive CI
jobs:
  lint:  # Code quality
  static: # Security analysis
  docs: # Documentation generation
  link-check: # Link validation
```

### Documentation Pipeline
```yaml
# Documentation generation and deployment
jobs:
  docs: # Build and deploy docs
  link-check: # Validate links
```

### Code Quality Pipeline
```yaml
# Code quality focused workflows
jobs:
  lint: # Code style and quality
  static: # Static analysis
```

## 📖 Next Steps

1. **Choose your workflows** based on your project needs
2. **Read the individual guides** for detailed configuration
3. **Customize inputs** to match your project structure
4. **Test with a simple workflow** before adding complexity

## 🔗 Related Resources

- [Main Repository](https://github.com/N3B3x/hf-general-ci-tools)
- [N3B3x/hf-espidf-ci-tools](https://github.com/N3B3x/hf-espidf-ci-tools) - ESP-IDF specific CI tools and workflows
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Clang Documentation](https://clang.llvm.org/)
- [Doxygen Documentation](https://www.doxygen.nl/)

---

<div align="center">

[← Previous: Example Workflows](example-workflows.md) | [Next: Lint Workflow →](lint-workflow.md)

**📚 [All Documentation](index.md)** | **🏠 [Main README](../README.md)**

</div>
