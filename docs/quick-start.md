---
layout: page-enhanced
title: "🚀 Quick Start Guide"
description: "Get started with hf-general-ci-tools in minutes"
nav_order: 2
---

# 🚀 Quick Start Guide

Welcome to **hf-general-ci-tools**! This guide will help you get up and running with our reusable GitHub Actions workflows in just a few minutes.

## 📋 Prerequisites

Before you begin, make sure you have:

- ✅ A GitHub repository with your project
- ✅ GitHub Actions enabled in your repository
- ✅ Basic knowledge of YAML syntax
- ✅ A C/C++ project (for linting workflows)

## 🎯 Choose Your Workflow

Select the workflow that best fits your needs:

### 🔧 For C/C++ Projects
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

### 📚 For Documentation
```yaml
name: Documentation
on: [push]
jobs:
  docs:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      jekyll_enabled: true
      deploy_pages: true
```

### 🔗 For Link Checking
```yaml
name: Link Check
on: [push, pull_request]
jobs:
  links:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "docs/**,*.md"
```

## ⚡ Quick Setup (5 minutes)

### Step 1: Create Workflow File

1. Go to your repository on GitHub
2. Navigate to `.github/workflows/`
3. Create a new file (e.g., `ci.yml`)

### Step 2: Add Your Workflow

Copy one of the examples above and customize it for your project.

### Step 3: Commit and Push

```bash
git add .github/workflows/ci.yml
git commit -m "Add CI workflow"
git push
```

### Step 4: Watch It Work! 🎉

Your workflow will automatically run and you'll see the results in the Actions tab.

## 🔧 Common Configurations

### Basic C/C++ Linting
```yaml
name: Basic CI
on: [push, pull_request]
jobs:
  lint:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      source_dirs: "src/"
      include_patterns: "*.cpp,*.hpp"
      clang_format_check: true
      clang_tidy_check: true
```

### Comprehensive CI Pipeline
```yaml
name: Full CI Pipeline
on: [push, pull_request]
jobs:
  lint:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    with:
      source_dirs: "src/"
  
  static-analysis:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/static-analysis.yml@v1
    with:
      source_dirs: "src/"
  
  docs:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/docs.yml@v1
    with:
      jekyll_enabled: true
      deploy_pages: true
  
  link-check:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@v1
    with:
      paths: "docs/**,*.md"
```

## 🎨 Customization Options

### Workflow Inputs
Each workflow supports extensive customization through input parameters:

- **`source_dirs`**: Directories to analyze
- **`include_patterns`**: File patterns to include
- **`exclude_patterns`**: File patterns to exclude
- **`clang_format_check`**: Enable/disable clang-format
- **`clang_tidy_check`**: Enable/disable clang-tidy
- **`cppcheck_enabled`**: Enable/disable cppcheck

### Environment Variables
Set custom environment variables for your workflows:

```yaml
jobs:
  lint:
    uses: n3b3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@v1
    env:
      CUSTOM_VAR: "value"
    with:
      source_dirs: "src/"
```

## 🚨 Troubleshooting

### Common Issues

**❌ Workflow not running?**
- Check that GitHub Actions is enabled
- Verify the workflow file is in `.github/workflows/`
- Ensure the file has a `.yml` or `.yaml` extension

**❌ Permission denied?**
- Make sure the workflow has the necessary permissions
- Check that the repository has the required settings

**❌ Files not found?**
- Verify the `source_dirs` path is correct
- Check that the files match the `include_patterns`

### Getting Help

- 📚 Check the [full documentation](index.md)
- 🐛 [Report issues](https://github.com/n3b3x/hf-general-ci-tools/issues)
- 💬 [Join discussions](https://github.com/n3b3x/hf-general-ci-tools/issues)

## 🎯 Next Steps

Once you have the basics working:

1. **Explore Advanced Features**: Check out our [configuration examples](configuration-examples.md)
2. **See Real Examples**: Browse our [example workflows](example-workflows.md)
3. **Customize Further**: Explore advanced configuration options
4. **Set Up Analytics**: Configure analytics tracking in your `_config.yml`

## 🎉 You're All Set!

Congratulations! You now have a working CI/CD pipeline with hf-general-ci-tools. 

**What's next?**
- Explore the [full documentation](index.md)
- Check out [advanced examples](example-workflows.md)
- [Star our repository](https://github.com/n3b3x/hf-general-ci-tools) if you find it useful!

---

<div class="callout note">
<strong>💡 Pro Tip:</strong> Start with the basic configuration and gradually add more features as you become familiar with the workflows.
</div>
