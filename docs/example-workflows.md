# 🚀 Example Workflows for Consumer Repositories

<div align="center">

![Examples](https://img.shields.io/badge/Examples-Consumer%20Workflows-blue?style=for-the-badge&logo=github)
![Parallel](https://img.shields.io/badge/Parallel-Jobs-green?style=for-the-badge&logo=github-actions)
![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-orange?style=for-the-badge&logo=github)

**📋 Complete Workflow Examples for General Projects**

*Ready-to-use GitHub Actions workflows that leverage all available CI tools in parallel*

[← Previous: Static Analysis Workflow](static-analysis-workflow.md) | [Next: Documentation Index →](index.md)

</div>

---

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [🏗️ Basic Workflow](#️-basic-workflow)
- [🚀 Advanced Parallel Workflow](#-advanced-parallel-workflow)
- [🔧 Development Workflow](#-development-workflow)
- [📦 Release Workflow](#-release-workflow)
- [🛡️ Security-First Workflow](#️-security-first-workflow)
- [📚 Documentation Workflow](#-documentation-workflow)
- [⚡ Performance Optimized](#-performance-optimized)

---

## 🎯 Overview

These example workflows demonstrate how to use the GitHub Actions workflows in your consumer repositories. Each workflow is designed for different use cases and can be customized to fit your project's needs.

### **Key Features**
- 🔄 **Parallel Execution** - Multiple jobs run simultaneously for maximum efficiency
- 🛡️ **Comprehensive Coverage** - Lint, static analysis, documentation, and link checking
- 📊 **Smart Caching** - Optimized for fast builds and minimal resource usage
- 🎯 **General Purpose** - Designed for C/C++ and documentation projects

---

## 🏗️ Basic Workflow

**Use Case**: Simple projects that need basic CI/CD with lint and link checks.

```yaml
name: 🏗️ Basic CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  # Lint C/C++ code
  lint:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@main
    with:
      clang_version: "20"
      extensions: "c,cpp,h,hpp"
      auto_fix: false

  # Check documentation links
  docs-links:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@main
    with:
      paths: "docs/**,*.md,**/docs/**"
```

---

## 🚀 Advanced Parallel Workflow

**Use Case**: Production projects requiring comprehensive CI/CD with all checks running in parallel.

```yaml
name: 🚀 Advanced CI

on:
  push:
    branches: [main, develop, release/*]
  pull_request:
    branches: [main, develop]
  workflow_dispatch:
    inputs:
      run_static_analysis:
        description: 'Run static analysis'
        required: false
        default: true
        type: boolean
      strict_mode:
        description: 'Enable strict mode for all checks'
        required: false
        default: false
        type: boolean

env:
  PROJECT_DIR: src
  DOCS_DIR: docs

jobs:
  # 🔧 Lint code
  lint:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@main
    with:
      clang_version: "20"
      extensions: "c,cpp,cc,cxx,h,hpp"
      style: "file"
      tidy_checks: "readability-*,performance-*,modernize-*"
      ignore: "build|.git|third_party|vendor"
      files_changed_only: true
      step_summary: true
      file_annotations: true

  # 🔍 Static analysis
  static-analysis:
    if: ${{ github.event.inputs.run_static_analysis != 'false' }}
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@main
    with:
      paths: "src inc examples components"
      std: "c++17"
      strict: ${{ github.event.inputs.strict_mode == 'true' }}

  # 📚 Build and check documentation
  docs:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs.yml@main
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/doxygen/html"
      run_link_check: true
      link_check_paths: "docs/**,*.md,**/docs/**"
      run_markdown_lint: true
      run_spell_check: true
      deploy_pages: ${{ github.ref == 'refs/heads/main' }}

  # 🔗 Check documentation links
  link-check:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@main
    with:
      paths: "docs/**,*.md,**/docs/**,README.md"
      fail_on_errors: ${{ github.event.inputs.strict_mode == 'true' }}

  # 📊 Build summary and notifications
  summary:
    needs: [lint, static-analysis, docs, link-check]
    if: always()
    runs-on: ubuntu-latest
    steps:
      - name: Build Summary
        run: |
          echo "## 🚀 Build Summary" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "| Job | Status |" >> $GITHUB_STEP_SUMMARY
          echo "|-----|--------|" >> $GITHUB_STEP_SUMMARY
          echo "| 🔧 Lint | ${{ needs.lint.result == 'success' && '✅ Success' || '❌ Failed' }} |" >> $GITHUB_STEP_SUMMARY
          echo "| 🔍 Static Analysis | ${{ needs.static-analysis.result == 'success' && '✅ Success' || '❌ Failed' }} |" >> $GITHUB_STEP_SUMMARY
          echo "| 📚 Docs | ${{ needs.docs.result == 'success' && '✅ Success' || '❌ Failed' }} |" >> $GITHUB_STEP_SUMMARY
          echo "| 🔗 Link Check | ${{ needs.link-check.result == 'success' && '✅ Success' || '❌ Failed' }} |" >> $GITHUB_STEP_SUMMARY
```

---

## 🔧 Development Workflow

**Use Case**: Development branches with auto-fix and relaxed checks.

```yaml
name: 🔧 Development CI

on:
  push:
    branches: [develop, feature/*, bugfix/*]
  pull_request:
    branches: [develop]

jobs:
  # Lint code with relaxed settings
  lint:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@main
    with:
      clang_version: "20"
      extensions: "c,cpp,cc,cxx,h,hpp"
      files_changed_only: true
      style: "file"
      tidy_checks: "readability-*"  # Only readability checks for dev
      ignore: "build|.git|test"
      thread_comments: true  # Help developers with feedback

  # Quick static analysis (non-strict)
  static-analysis:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@main
    with:
      paths: "src inc"
      std: "c++17"
      strict: false  # Don't fail on issues in dev

  # Quick link check
  link-check:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@main
    with:
      paths: "*.md,README.md"
      fail_on_errors: false  # Don't fail on broken links in dev
```

---

## 📦 Release Workflow

**Use Case**: Release branches with comprehensive checks and documentation publishing.

```yaml
name: 📦 Release CI

on:
  push:
    branches: [release/*, main]
    tags: ['v*']
  workflow_dispatch:
    inputs:
      release_version:
        description: 'Release version (e.g., v1.0.0)'
        required: true
        type: string

env:
  RELEASE_VERSION: ${{ github.event.inputs.release_version || github.ref_name }}

jobs:
  # Strict linting for release
  lint-release:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@main
    with:
      clang_version: "20"
      extensions: "c,cpp,cc,cxx,h,hpp"
      auto_fix: false  # No auto-fix for release
      style: "file"
      tidy_checks: "readability-*,performance-*,modernize-*,cert-*"
      ignore: "build|.git|third_party"
      files_changed_only: false  # Check all files for release

  # Comprehensive static analysis
  static-analysis-release:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@main
    with:
      paths: "src inc examples components"
      std: "c++17"
      strict: true  # Fail on any issues

  # Build and deploy documentation
  docs-release:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs.yml@main
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/doxygen/html"
      run_link_check: true
      run_markdown_lint: true
      run_spell_check: true
      deploy_pages: true

  # Comprehensive link checking
  link-check-release:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@main
    with:
      paths: "docs/**,*.md,**/docs/**,README.md"
      fail_on_errors: true

  # Create release
  create-release:
    needs: [lint-release, static-analysis-release, docs-release, link-check-release]
    if: startsWith(github.ref, 'refs/tags/')
    runs-on: ubuntu-latest
    steps:
      - name: Create Release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: ${{ env.RELEASE_VERSION }}
          release_name: Release ${{ env.RELEASE_VERSION }}
          body: |
            ## 🚀 Release ${{ env.RELEASE_VERSION }}
            
            ### 📚 Documentation
            - [Documentation](https://${{ github.repository_owner }}.github.io/${{ github.event.repository.name }}/)
            
            ### 🔍 Quality Checks
            - Code linting passed
            - Static analysis completed
            - Documentation links validated
            - All checks passed successfully
          draft: false
          prerelease: false
```

---

## 🛡️ Quality-First Workflow

**Use Case**: Quality-critical projects requiring comprehensive code quality checks.

```yaml
name: 🛡️ Quality-First CI

on:
  push:
    branches: [main, quality/*]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 2 * * 1'  # Weekly quality scan

jobs:
  # Static analysis (runs first)
  static-analysis:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@main
    with:
      paths: "src inc examples components"
      std: "c++17"
      strict: true  # Fail on any issues

  # Strict linting with quality focus
  lint-quality:
    needs: static-analysis
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@main
    with:
      clang_version: "20"
      extensions: "c,cpp,cc,cxx,h,hpp"
      auto_fix: false
      style: "file"
      tidy_checks: "cert-*,cppcoreguidelines-*,readability-*,performance-*"
      ignore: "build|.git|third_party"
      files_changed_only: false
      thread_comments: true

  # Comprehensive documentation checks
  docs-quality:
    needs: static-analysis
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs.yml@main
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/doxygen/html"
      run_link_check: true
      run_markdown_lint: true
      run_spell_check: true
      deploy_pages: ${{ github.ref == 'refs/heads/main' }}

  # Additional quality checks
  quality-scan:
    needs: static-analysis
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Run additional quality checks
        run: |
          echo "## 🛡️ Quality Metrics" >> $GITHUB_STEP_SUMMARY
          echo "- Static analysis: ✅ Passed" >> $GITHUB_STEP_SUMMARY
          echo "- Code linting: ✅ Passed" >> $GITHUB_STEP_SUMMARY
          echo "- Documentation: ✅ Passed" >> $GITHUB_STEP_SUMMARY
```

---

## 📚 Documentation Workflow

**Use Case**: Documentation-focused projects with comprehensive doc checks.

```yaml
name: 📚 Documentation CI

on:
  push:
    branches: [main, docs/*]
  pull_request:
    branches: [main]
    paths: ['docs/**', '*.md', 'README.md']

jobs:
  # Build documentation
  docs-build:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs.yml@main
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/doxygen/html"
      run_link_check: true
      link_check_paths: "docs/**,*.md,**/docs/**,README.md"
      run_markdown_lint: true
      run_spell_check: true
      deploy_pages: ${{ github.ref == 'refs/heads/main' }}

  # Comprehensive link checking
  link-check-comprehensive:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@main
    with:
      paths: "docs/**,*.md,**/docs/**,README.md,**/*.md"
      fail_on_errors: true

  # Additional documentation quality checks
  docs-quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Check documentation structure
        run: |
          echo "## 📚 Documentation Quality Check" >> $GITHUB_STEP_SUMMARY
          echo "- Doxygen generation: ✅ Passed" >> $GITHUB_STEP_SUMMARY
          echo "- Link validation: ✅ Passed" >> $GITHUB_STEP_SUMMARY
          echo "- Markdown linting: ✅ Passed" >> $GITHUB_STEP_SUMMARY
          echo "- Spell checking: ✅ Passed" >> $GITHUB_STEP_SUMMARY
```

---

## ⚡ Performance Optimized

**Use Case**: Large projects requiring maximum build performance and minimal resource usage.

```yaml
name: ⚡ Performance CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  CACHE_VERSION: v1

jobs:
  # Parallel linting with minimal checks
  lint-fast:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@main
    with:
      clang_version: "20"
      extensions: "c,cpp,h,hpp"
      auto_fix: true
      files_changed_only: true  # Only check changed files
      lines_changed_only: true  # Only check changed lines
      style: "file"
      tidy_checks: "readability-*"  # Minimal checks for speed
      ignore: "build|.git|third_party|vendor"

  # Quick static analysis
  static-analysis-fast:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@main
    with:
      paths: "src inc"  # Only check main source directories
      std: "c++17"
      strict: false  # Don't fail on issues for speed

  # Fast link check
  link-check-fast:
    uses: N3B3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@main
    with:
      paths: "README.md,*.md"  # Only check main docs
      fail_on_errors: false  # Don't fail on broken links for speed

  # Performance monitoring
  performance-check:
    runs-on: ubuntu-latest
    steps:
      - name: Check build times
        run: |
          echo "## ⚡ Performance Metrics" >> $GITHUB_STEP_SUMMARY
          echo "Workflow completed in: ${{ github.run_duration }}" >> $GITHUB_STEP_SUMMARY
          echo "Optimization: Files changed only, minimal checks" >> $GITHUB_STEP_SUMMARY
```

---

## 🎯 Workflow Selection Guide

| Use Case | Recommended Workflow | Key Features |
|----------|---------------------|--------------|
| **Simple Projects** | Basic Workflow | Lint + Link Check |
| **Production Projects** | Advanced Parallel | All checks in parallel |
| **Development** | Development Workflow | Auto-fix, relaxed checks |
| **Releases** | Release Workflow | Comprehensive + documentation |
| **Quality Critical** | Quality-First | Quality-first approach |
| **Documentation Heavy** | Documentation Workflow | Doc-focused checks |
| **Large Projects** | Performance Optimized | Maximum speed |

---

## 🔧 Customization Tips

### **Environment Variables**
```yaml
env:
  PROJECT_DIR: src
  DOCS_DIR: docs
  CACHE_VERSION: v1
  LINT_TIMEOUT: 30
```

### **Conditional Execution**
```yaml
jobs:
  static-analysis:
    if: github.event_name == 'pull_request' || github.ref == 'refs/heads/main'
    uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@main
```

### **Matrix Strategies**
```yaml
strategy:
  fail-fast: false  # Don't stop on first failure
  max-parallel: 4   # Limit parallel jobs
```

### **Cache Optimization**
```yaml
- name: Cache dependencies
  uses: actions/cache@v4
  with:
    path: ~/.cache
    key: cache-${{ runner.os }}-${{ hashFiles('**/requirements.txt') }}
```

---

## 📚 Next Steps

1. **Choose your workflow** based on your project needs
2. **Customize the configuration** for your specific setup
3. **Add your project structure** following the requirements
4. **Test locally** using the provided scripts
5. **Monitor and optimize** based on your build times and requirements

For more detailed information, see the individual workflow documentation:
- [Lint Workflow](lint-workflow.md)
- [Static Analysis Workflow](static-analysis-workflow.md)
- [Documentation Workflow](docs-workflow.md)
- [Link Check Workflow](link-check-workflow.md)

---

<div align="center">

[← Previous: Static Analysis Workflow](static-analysis-workflow.md) | [Next: Documentation Index →](index.md)

**📚 [All Documentation](index.md)** | **🏠 [Main README](../README.md)**

</div>
