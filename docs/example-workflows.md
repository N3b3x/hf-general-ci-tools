---
layout: default
title: "🚀 Example Workflows"
description: "Real-world usage examples for consumer repositories"
nav_order: 2
parent: "Examples & Guides"
---

# 🚀 Example Workflows

**Ready-to-use GitHub Actions workflows that leverage all CI tools in parallel**

---

## 🎯 Overview

These example workflows demonstrate how to use the general CI tools in your consumer repositories.
Each workflow is designed for different use cases and can be customized to fit your project's needs.

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

jobs:
  # C/C++ Linting
  lint:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      clang_version: "20"
      style: "file"
      tidy_checks: "performance-*,modernize-*,readability-*"
      extensions: "c,cpp,cc,cxx,h,hpp"
      ignore: "build|.git|third_party"
      files_changed_only: true

  # Static Analysis
  static-analysis:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
    with:
      paths: "src include examples"
      std: "c++17"
      strict: ${{ github.event.inputs.run_strict_checks == 'true' }}

  # Documentation Generation
  docs:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/doxygen/html"
      run_link_check: true
      link_check_paths: "docs/**,*.md,**/docs/**"
      jekyll_enabled: true
      jekyll_config: "_config.yml,_config_prod.yml"
      jekyll_environment: "production"

  # YAML Linting
  yaml-lint:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/yamllint-reusable.yml@v1
    with:
      paths: "**/*.yml,**/*.yaml"
      strict_mode: false

  # Link Checking
  link-check:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "docs/**,*.md,**/docs/**"
      fail_on_errors: true
      timeout: "30"
```

---

## 🔧 Development Workflow

**Use Case**: Development branches with relaxed checks and draft documentation.

```yaml
name: 🔧 Development CI

on:
  push:
    branches: [develop, feature/*]
  pull_request:
    branches: [develop]

jobs:
  # Quick lint check
  lint:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      clang_version: "20"
      style: "file"
      files_changed_only: true

  # Documentation with drafts
  docs:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/doxygen/html"
      run_link_check: false
      jekyll_enabled: true
      jekyll_config: "_config.yml,_config_dev.yml"
      jekyll_environment: "development"
      jekyll_drafts: true
      jekyll_future: true
```

---

## 📦 Release Workflow

**Use Case**: Release branches with strict checks and production documentation.

```yaml
name: 📦 Release CI

on:
  push:
    branches: [release/*]
  workflow_dispatch:
    inputs:
      release_version:
        description: 'Release version tag'
        required: true
        type: string

jobs:
  # Strict linting
  lint:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      clang_version: "20"
      style: "file"
      tidy_checks: "performance-*,modernize-*,readability-*,bugprone-*"
      extensions: "c,cpp,cc,cxx,h,hpp"
      ignore: "build|.git"
      files_changed_only: false

  # Strict static analysis
  static-analysis:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@v1
    with:
      paths: "src include examples"
      std: "c++17"
      strict: true

  # Production documentation
  docs:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      doxygen_config: "Doxyfile"
      output_dir: "docs/doxygen/html"
      run_link_check: true
      link_check_paths: "docs/**,*.md,**/docs/**"
      jekyll_enabled: true
      jekyll_config: "_config.yml,_config_prod.yml"
      jekyll_environment: "production"

  # Comprehensive link checking
  link-check:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "docs/**,*.md,**/docs/**"
      fail_on_errors: true
      timeout: "60"

  # YAML validation
  yaml-lint:
    uses: N3b3x/hf-general-ci-tools/.github/workflows/yamllint-reusable.yml@v1
    with:
      paths: "**/*.yml,**/*.yaml"
      strict_mode: true
```

---

## 🎯 Workflow Selection Guide

| Use Case | Recommended Workflow | Key Features |
|----------|---------------------|--------------|
| **Simple Projects** | Basic Workflow | Essential linting and link checking |
| **Production Projects** | Advanced Parallel | Comprehensive checks with parallel execution |
| **Development** | Development Workflow | Relaxed checks with draft support |
| **Releases** | Release Workflow | Strict checks with production documentation |

---

## 🔧 Customization Tips

### **Parallel vs Sequential**
- Use parallel jobs for faster execution
- Use sequential jobs when dependencies exist

### **Conditional Execution**
```yaml
# Only run on specific branches
if: github.ref == 'refs/heads/main'

# Only run when files change
if: contains(github.event.head_commit.modified, 'src/')
```

### **Matrix Strategies**
```yaml
strategy:
  matrix:
    clang_version: [18, 19, 20]
    include:
      - clang_version: 20
        std: c++20
      - clang_version: 19
        std: c++17
```

### **Caching**
```yaml
- name: Cache dependencies
  uses: actions/cache@v3
  with:
    path: |
      ~/.cache/ccache
      build/
    key: ${{ runner.os }}-${{ hashFiles('**/CMakeLists.txt') }}
```

---

*For more detailed configuration options, see the individual workflow documentation pages.*