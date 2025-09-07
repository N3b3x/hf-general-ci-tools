# Workflow Index

This document provides a comprehensive overview of all workflows in this repository, clearly distinguishing between **reusable workflows** (for external use) and **internal workflows** (for repository quality assurance).

## 🔄 Reusable Workflows (For External Use)

These workflows are designed to be used by other repositories and provide general-purpose CI/CD functionality.

### 📋 C/C++ Lint Workflow

**File**: `c-cpp-lint.yml`  
**Purpose**: Code quality enforcement and formatting  
**Tools**: clang-format, clang-tidy, markdownlint, cspell, yamllint

```yaml
uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-lint.yml@main
with:
  clang_version: "20"
  extensions: "c,cpp,h,hpp"
  paths: "src inc examples"
  run_markdownlint: true
  run_cspell: true
  run_yamllint: true
```

**Use Cases**:
- C/C++ code formatting and style checking
- Markdown documentation linting
- YAML file validation
- Spell checking for documentation

### 🔍 C/C++ Static Analysis Workflow

**File**: `c-cpp-static-analysis.yml`  
**Purpose**: Advanced static analysis for security and quality  
**Tools**: cppcheck, clang-tidy with custom rules

```yaml
uses: N3B3x/hf-general-ci-tools/.github/workflows/c-cpp-static-analysis.yml@main
with:
  paths: "src inc examples"
  strict: false
  cppcheck_args: "--enable=all --inconclusive"
  clang_tidy_args: "--warnings-as-errors=*"
```

**Use Cases**:
- Security vulnerability detection
- Memory leak detection
- Code quality analysis
- Performance issue identification

### 📚 Documentation Workflow

**File**: `docs.yml`  
**Purpose**: Documentation generation and deployment  
**Tools**: Doxygen, markdownlint, cspell, md-dead-link-check

```yaml
uses: N3B3x/hf-general-ci-tools/.github/workflows/docs.yml@main
with:
  doxygen_config: "Doxyfile"
  output_dir: "docs/html"
  github_pages: true
  run_link_check: true
  link_check_paths: "docs/**,*.md"
```

**Use Cases**:
- Doxygen documentation generation
- GitHub Pages deployment
- Documentation link validation
- Markdown and spell checking

### 🔗 Link Check Workflow

**File**: `docs-link-check.yml`  
**Purpose**: Documentation link validation  
**Tools**: md-dead-link-check

```yaml
uses: N3B3x/hf-general-ci-tools/.github/workflows/docs-link-check.yml@main
with:
  paths: "docs/**,*.md"
  exclude_paths: "docs/examples/**"
  timeout: 30
  follow_redirects: true
```

**Use Cases**:
- Validate internal documentation links
- Check external link availability
- Ensure documentation integrity

## 🏠 Internal Repository Workflows

These workflows are used internally to maintain the quality and consistency of this repository.

### 🧹 Comprehensive Linting Workflow

**File**: `linting.yml`  
**Purpose**: Quality assurance for this repository  
**Tools**: yamllint, markdownlint, markdown-link-check

**Triggers**:
- Push to main/develop branches
- Pull requests
- Manual dispatch

**Quality Checks**:
- YAML file validation using yamllint
- Markdown file linting using markdownlint
- Documentation link validation
- Quality summary reporting

**Configuration**:
- Uses `.yamllint` configuration file
- Uses `.markdownlint.json` configuration file
- Uses `.markdown-link-check.json` configuration file

### 📝 YAML Lint Workflow

**File**: `yamllint.yml`  
**Purpose**: YAML file validation and formatting  
**Tools**: yamllint

**Triggers**:
- Push to main/develop branches
- Pull requests
- Manual dispatch

**Validation**:
- GitHub Actions workflow files
- Configuration files
- All YAML files in the repository

**Configuration**:
- Uses `.yamllint` configuration file
- Line length: 120 characters
- Proper indentation and formatting rules

## 📊 Workflow Comparison

| Aspect | Reusable Workflows | Internal Workflows |
|--------|-------------------|-------------------|
| **Target Users** | External repositories | This repository only |
| **Purpose** | General CI/CD tasks | Quality assurance |
| **Configuration** | Flexible inputs | Fixed standards |
| **Tools** | Multiple specialized tools | Linting and validation |
| **Documentation** | Extensive usage docs | Internal standards |

## 🎯 Usage Guidelines

### For External Users

1. **Choose the right workflow** for your needs
2. **Configure inputs** according to your project structure
3. **Test with simple examples** before full integration
4. **Check documentation** for detailed usage instructions

### For Repository Maintainers

1. **Internal workflows run automatically** on push/PR
2. **Quality standards are enforced** consistently
3. **Configuration files** define the standards
4. **Manual triggers** available for testing

## 🔧 Configuration Files

### Repository Standards

- **`.yamllint`**: YAML linting rules and standards
- **`.markdownlint.json`**: Markdown formatting rules
- **`.markdown-link-check.json`**: Link checking configuration
- **`.cspell.json`**: Spell checking configuration

### Quality Thresholds

- **Line Length**: 250 characters (markdown), 120 characters (YAML)
- **Formatting**: Consistent indentation and structure
- **Links**: All documentation links must be valid
- **Spelling**: Technical terms properly spelled

## 📈 Quality Metrics

The internal workflows provide quality metrics including:

- YAML validation results
- Markdown linting scores
- Link validation status
- Overall quality summary

These metrics help maintain high standards across the repository and ensure consistency in documentation and configuration files.

---

**Navigation**: [← Previous: Link Check Workflow](link-check-workflow.md) | [Next: Documentation Index →](index.md)