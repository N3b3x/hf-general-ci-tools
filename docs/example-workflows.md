# 🚀 Example Workflows for Consumer Repositories

<div align="center">

![Examples](https://img.shields.io/badge/Examples-Consumer%20Workflows-blue?style=for-the-badge&logo=github)
![Parallel](https://img.shields.io/badge/Parallel-Jobs-green?style=for-the-badge&logo=github-actions)
![CI/CD](https://img.shields.io/badge/CI%2FCD-General%20Tools-orange?style=for-the-badge&logo=github)

**📋 Complete Workflow Examples for General CI Projects**

*Ready-to-use GitHub Actions workflows that leverage all CI tools in parallel*

[← Previous: Static Analysis Workflow](static-analysis-workflow.md) | [Next: Documentation Index →](index.md)

</div>

---

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [🏗️ Basic Workflow](#-basic-workflow)
- [🚀 Advanced Parallel Workflow](#-advanced-parallel-workflow)
- [🔧 Development Workflow](#-development-workflow)
- [📦 Release Workflow](#-release-workflow)
- [🛡️ Security-First Workflow](#-security-first-workflow)
- [📚 Documentation Workflow](#-documentation-workflow)
- [⚡ Performance Optimized](#-performance-optimized)

---

## 🎯 Overview

These example workflows demonstrate how to use the general CI tools in your consumer repositories. Each workflow is designed for different use cases and can be customized to fit your project's needs.

### **Key Features**
- 🔄 **Parallel Execution** - Multiple jobs run simultaneously for maximum efficiency
- 🛡️ **Comprehensive Coverage** - Lint, static analysis, documentation, and link checking
- 📊 **Smart Caching** - Optimized for fast builds and minimal resource usage
- 🎯 **General Purpose** - Designed for C/C++ projects with documentation

---

## 🏗️ Basic Workflow

**Use Case**: Simple projects that need basic CI/CD with lint and documentation checks.

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
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      clang_version: "20"
      style: "file"
      extensions: "c,cpp,h,hpp"

  # Static analysis
  static:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
    with:
      paths: "src include"
      std: "c++17"
      strict: false

  # Check documentation links
  docs-links:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
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
      run_strict_checks:
        description: 'Run strict static analysis'
        required: false
        default: false
        type: boolean
      deploy_docs:
        description: 'Deploy documentation to GitHub Pages'
        required: false
        default: true
        type: boolean

env:
  PROJECT_NAME: "My C++ Project"

jobs:
  # 🔧 Lint C/C++ code
  lint:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      clang_version: "20"
      style: "file"
      tidy_checks: "readability-*,performance-*,modernize-*"
      extensions: "c,cpp,cc,cxx,h,hpp"
      ignore: "build|.git|third_party|vendor"
      files_changed_only: true
      step_summary: true
      file_annotations: true

  # 🔍 Static analysis
  static-analysis:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
    with:
      paths: "src include"
      std: "c++17"
      strict: ${{ github.event.inputs.run_strict_checks == 'true' }}

  # 📚 Build and check documentation
  docs:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/doxygen/html"
      run_link_check: true
      link_check_paths: "docs/**,*.md,**/docs/**"
      run_markdown_lint: true
      markdown_lint_paths: "docs/**,*.md"
      run_spell_check: true
      spell_check_paths: "docs/**,*.md"
      deploy_pages: ${{ github.event.inputs.deploy_docs == 'true' && github.ref == 'refs/heads/main' }}

  # 🔗 Check documentation links
  link-check:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "docs/**,*.md,**/docs/**,README.md"
      fail_on_errors: true

  # 📝 YAML linting
  yaml-lint:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/yamllint.yml@v1

  # 📊 Build summary and notifications
  summary:
    needs: [lint, static-analysis, docs, link-check, yaml-lint]
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
          echo "| 📝 YAML Lint | ${{ needs.yaml-lint.result == 'success' && '✅ Success' || '❌ Failed' }} |" >> $GITHUB_STEP_SUMMARY
```

---

## 🔧 Development Workflow

**Use Case**: Development branches with relaxed checks and faster execution.

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
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      clang_version: "20"
      style: "file"
      extensions: "c,cpp,h,hpp"
      files_changed_only: true
      tidy_checks: "readability-*"  # Only readability checks for dev
      ignore: "build|.git|test"
      step_summary: true
      file_annotations: true

  # Quick static analysis
  static:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
    with:
      paths: "src include"
      std: "c++17"
      strict: false  # Don't fail on issues in dev

  # Quick link check
  link-check:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
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
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      clang_version: "20"
      style: "file"
      extensions: "c,cpp,cc,cxx,h,hpp"
      tidy_checks: "readability-*,performance-*,modernize-*,cert-*"
      ignore: "build|.git|test|third_party"
      files_changed_only: false  # Check all files for release
      step_summary: true
      file_annotations: true

  # Comprehensive static analysis
  static-analysis-release:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
    with:
      paths: "src include"
      std: "c++17"
      strict: true  # Fail on any issues

  # Build and deploy documentation
  docs-release:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/doxygen/html"
      run_link_check: true
      link_check_paths: "docs/**,*.md,**/docs/**"
      run_markdown_lint: true
      markdown_lint_paths: "docs/**,*.md"
      run_spell_check: true
      spell_check_paths: "docs/**,*.md"
      deploy_pages: true

  # Comprehensive link checking
  link-check-release:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "docs/**,*.md,**/docs/**,README.md"
      fail_on_errors: true

  # YAML validation
  yaml-lint-release:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/yamllint.yml@v1

  # Create release
  create-release:
    needs: [lint-release, static-analysis-release, docs-release, link-check-release, yaml-lint-release]
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
            ## 🚀 C++ Project Release ${{ env.RELEASE_VERSION }}
            
            ### 📚 Documentation
            - [Documentation](https://${{ github.repository_owner }}.github.io/${{ github.event.repository.name }}/)
            
            ### ✅ Quality Checks
            - Code linting passed
            - Static analysis completed
            - Documentation links validated
            - YAML files validated
          draft: false
          prerelease: false
```

---

## 🛡️ Security-First Workflow

**Use Case**: Security-critical projects requiring comprehensive security checks.

```yaml
name: 🛡️ Security-First CI

on:
  push:
    branches: [main, security/*]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 2 * * 1'  # Weekly security scan

jobs:
  # Strict static analysis with security focus
  static-analysis-secure:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
    with:
      paths: "src include"
      std: "c++17"
      strict: true  # Fail on any issues

  # Strict linting with security focus
  lint-secure:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      clang_version: "20"
      style: "file"
      extensions: "c,cpp,cc,cxx,h,hpp"
      tidy_checks: "cert-*,cppcoreguidelines-*,readability-*"
      ignore: "build|.git|test|third_party"
      files_changed_only: false
      step_summary: true
      file_annotations: true

  # Documentation with security checks
  docs-secure:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/doxygen/html"
      run_link_check: true
      link_check_paths: "docs/**,*.md,**/docs/**"
      run_markdown_lint: true
      markdown_lint_paths: "docs/**,*.md"
      run_spell_check: true
      spell_check_paths: "docs/**,*.md"
      deploy_pages: ${{ github.ref == 'refs/heads/main' }}

  # Additional security checks
  security-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          scan-ref: '.'
          format: 'sarif'
          output: 'trivy-results.sarif'

      - name: Upload Trivy scan results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: 'trivy-results.sarif'
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
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/doxygen/html"
      run_link_check: true
      link_check_paths: "docs/**,*.md,**/docs/**,README.md"
      run_markdown_lint: true
      markdown_lint_paths: "docs/**,*.md"
      run_spell_check: true
      spell_check_paths: "docs/**,*.md"
      deploy_pages: ${{ github.ref == 'refs/heads/main' }}

  # Comprehensive link checking
  link-check-comprehensive:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "docs/**,*.md,**/docs/**,README.md,**/*.md"
      fail_on_errors: true

  # YAML validation
  yaml-lint:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/yamllint.yml@v1
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
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      clang_version: "20"
      style: "file"
      extensions: "c,cpp,h,hpp"
      files_changed_only: true  # Only check changed files
      lines_changed_only: true  # Only check changed lines
      tidy_checks: "readability-*"  # Minimal checks for speed
      ignore: "build|.git|test|third_party"
      step_summary: true
      file_annotations: true

  # Quick static analysis
  static-fast:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
    with:
      paths: "src include"
      std: "c++17"
      strict: false  # Don't fail on issues for speed

  # Fast link check
  link-check-fast:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "README.md,*.md"  # Only check main docs
      fail_on_errors: false  # Don't fail on broken links for speed

  # Quick YAML validation
  yaml-fast:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/yamllint.yml@v1

  # Performance monitoring
  performance-check:
    runs-on: ubuntu-latest
    steps:
      - name: Check build times
        run: |
          echo "## ⚡ Performance Metrics" >> $GITHUB_STEP_SUMMARY
          echo "Workflow completed in: ${{ github.run_duration }}" >> $GITHUB_STEP_SUMMARY
          echo "Configuration: Optimized for speed" >> $GITHUB_STEP_SUMMARY
```

---

## 🎯 Workflow Selection Guide

| Use Case | Recommended Workflow | Key Features |
|----------|---------------------|--------------|
| **Simple Projects** | Basic Workflow | Lint + Static Analysis + Link Check |
| **Production Projects** | Advanced Parallel | All checks in parallel |
| **Development** | Development Workflow | Relaxed checks, faster execution |
| **Releases** | Release Workflow | Comprehensive + documentation |
| **Security Critical** | Security-First | Security-focused approach |
| **Documentation Heavy** | Documentation Workflow | Doc-focused checks |
| **Large Projects** | Performance Optimized | Maximum speed |

---

## 🔧 Customization Tips

### **Environment Variables**
```yaml
env:
  PROJECT_NAME: "My C++ Project"
  CACHE_VERSION: v1
  BUILD_TIMEOUT: 30
```

### **Conditional Execution**
```yaml
jobs:
  static-analysis:
    if: github.event_name == 'pull_request' || github.ref == 'refs/heads/main'
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
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
    key: dependencies-${{ runner.os }}-${{ hashFiles('**/package-lock.json') }}
```

---

## 📚 Next Steps

1. **Choose your workflow** based on your project needs
2. **Customize the configuration** for your specific setup
3. **Add your project structure** following the requirements
4. **Test locally** using the provided scripts
5. **Monitor and optimize** based on your build times and requirements

For more detailed information, see the individual workflow documentation:
- [C/C++ Lint Workflow](lint-workflow.md)
- [Static Analysis Workflow](static-analysis-workflow.md)
- [Documentation Workflow](docs-workflow.md)
- [Link Check Workflow](link-check-workflow.md)

---

<div align="center">

[← Previous: Static Analysis Workflow](static-analysis-workflow.md) | [Next: Documentation Index →](index.md)

**📚 [All Documentation](index.md)** | **🏠 [Main README](../README.md)**

</div>
