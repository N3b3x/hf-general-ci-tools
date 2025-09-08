# Contributing to hf-general-ci-tools

Thank you for your interest in contributing to hf-general-ci-tools! This project provides reusable GitHub Actions workflows for common CI/CD tasks, and we welcome contributions from the community.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Types of Contributions](#types-of-contributions)
- [Development Workflow](#development-workflow)
- [Workflow Development Guidelines](#workflow-development-guidelines)
- [Documentation Guidelines](#documentation-guidelines)
- [Testing Guidelines](#testing-guidelines)
- [Pull Request Process](#pull-request-process)
- [Release Process](#release-process)
- [Questions and Support](#questions-and-support)

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct.html). By participating, you are expected to uphold this code.

## Getting Started

### Prerequisites

- Git
- GitHub account
- Basic understanding of GitHub Actions
- YAML knowledge
- Familiarity with CI/CD concepts

### Setting Up Your Development Environment

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/hf-general-ci-tools.git
   cd hf-general-ci-tools
   ```
3. **Add the upstream remote**:
   ```bash
   git remote add upstream https://github.com/n3b3x/hf-general-ci-tools.git
   ```
4. **Create a new branch** for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Types of Contributions

We welcome several types of contributions:

### 🐛 Bug Reports
- Report issues with existing workflows
- Include detailed reproduction steps
- Provide environment information

### ✨ Feature Requests
- Suggest new workflow capabilities
- Propose improvements to existing workflows
- Request additional configuration options

### 🔧 Workflow Improvements
- Fix bugs in existing workflows
- Add new features to workflows
- Optimize workflow performance
- Improve error handling

### 📚 Documentation
- Improve existing documentation
- Add examples and tutorials
- Fix typos and clarify instructions
- Add configuration examples

### 🧪 Testing
- Test workflows in different environments
- Report compatibility issues
- Suggest test improvements

## Development Workflow

### 1. Choose an Issue

- Look for issues labeled `good first issue` for beginners
- Check `help wanted` for more complex tasks
- Comment on the issue to indicate you're working on it

### 2. Make Your Changes

- Follow the [Workflow Development Guidelines](#workflow-development-guidelines)
- Update documentation as needed
- Test your changes thoroughly

### 3. Test Your Changes

- Test workflows in a test repository
- Verify all inputs and outputs work correctly
- Check that error handling works as expected

### 4. Submit a Pull Request

- Follow the [Pull Request Process](#pull-request-process)
- Ensure all checks pass
- Request review from maintainers

## Workflow Development Guidelines

### General Principles

- **Reusability**: Workflows should be designed for use across different repositories
- **Configurability**: Provide sensible defaults but allow extensive customization
- **Reliability**: Include proper error handling and validation
- **Performance**: Optimize for speed and resource usage
- **Security**: Follow GitHub Actions security best practices

### Workflow Structure

```yaml
name: Workflow Name
description: 'Brief description of what this workflow does'

on:
  workflow_call:
    inputs:
      # Define all inputs with descriptions
    outputs:
      # Define outputs if applicable
    secrets:
      # Define required secrets

jobs:
  job-name:
    runs-on: ubuntu-latest
    steps:
      - name: Step name
        # Implementation
```

### Input Guidelines

- **Use descriptive names**: `source_directories` instead of `dirs`
- **Provide clear descriptions**: Explain what each input does
- **Set sensible defaults**: Make workflows work out-of-the-box
- **Validate inputs**: Check for required values and valid formats
- **Use appropriate types**: `string`, `boolean`, `number`, `choice`

### Output Guidelines

- **Define meaningful outputs**: Only include outputs that other workflows might need
- **Use consistent naming**: Follow a clear naming convention
- **Document outputs**: Explain what each output contains

### Error Handling

- **Validate inputs early**: Check for required parameters and valid values
- **Provide clear error messages**: Help users understand what went wrong
- **Use appropriate exit codes**: Follow standard conventions
- **Include troubleshooting hints**: Suggest common solutions

### Security Considerations

- **Minimize permissions**: Only request necessary permissions
- **Use secrets appropriately**: Mark sensitive inputs as secrets
- **Avoid hardcoded values**: Use inputs and environment variables
- **Follow principle of least privilege**: Limit access to what's needed

## Documentation Guidelines

### Workflow Documentation

Each workflow should have:
- **Purpose**: What the workflow does
- **Inputs**: All available inputs with descriptions
- **Outputs**: All outputs with descriptions
- **Examples**: Basic and advanced usage examples
- **Prerequisites**: Required setup and configuration
- **Troubleshooting**: Common issues and solutions

### Documentation Structure

```markdown
# Workflow Name

Brief description of the workflow.

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| input1 | Description | Yes | value |

## Outputs

| Output | Description |
|--------|-------------|
| output1 | Description |

## Examples

### Basic Usage
```yaml
# Example here
```

### Advanced Usage
```yaml
# Example here
```

## Prerequisites

- List prerequisites

## Troubleshooting

### Common Issues

- Issue 1: Solution
- Issue 2: Solution
```

### Code Comments

- **Explain complex logic**: Don't assume readers understand everything
- **Document non-obvious decisions**: Explain why certain choices were made
- **Include examples**: Show how to use complex features
- **Keep comments up-to-date**: Update comments when code changes

## Testing Guidelines

### Testing Your Workflows

1. **Create a test repository** with sample code
2. **Test all input combinations** you can think of
3. **Verify error handling** with invalid inputs
4. **Check performance** with large codebases
5. **Test on different platforms** if applicable

### Test Cases to Consider

- **Valid inputs**: Ensure workflows work with correct inputs
- **Invalid inputs**: Test error handling with bad inputs
- **Edge cases**: Test with empty inputs, very large inputs, etc.
- **Different environments**: Test on different operating systems
- **Integration**: Test workflows work together

### Testing Checklist

- [ ] Workflow runs successfully with valid inputs
- [ ] Error messages are clear and helpful
- [ ] All inputs are properly validated
- [ ] Outputs are correctly set
- [ ] Documentation examples work
- [ ] Performance is acceptable

## Pull Request Process

### Before Submitting

- [ ] Test your changes thoroughly
- [ ] Update documentation if needed
- [ ] Follow the coding guidelines
- [ ] Ensure all checks pass
- [ ] Write a clear description

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Other (please describe)

## Testing
- [ ] Tested locally
- [ ] Tested in test repository
- [ ] All existing tests pass
- [ ] New tests added (if applicable)

## Documentation
- [ ] Documentation updated
- [ ] Examples added/updated
- [ ] README updated (if needed)

## Checklist
- [ ] Code follows project guidelines
- [ ] Self-review completed
- [ ] No breaking changes (or clearly documented)
- [ ] Ready for review
```

### Review Process

1. **Automated checks** must pass
2. **Code review** by maintainers
3. **Testing** in different environments
4. **Documentation review** for completeness
5. **Approval** from at least one maintainer

### After Approval

- **Squash and merge** (preferred) or **merge commit**
- **Delete feature branch** after merge
- **Update version tags** if applicable

## Release Process

### Versioning

We use [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Steps

1. **Update version** in workflow files
2. **Update CHANGELOG.md** with changes
3. **Create release tag** (e.g., `v1.2.3`)
4. **Publish release** on GitHub
5. **Update documentation** if needed

## Questions and Support

### Getting Help

- **GitHub Discussions**: For questions and general discussion
- **GitHub Issues**: For bug reports and feature requests
- **Pull Request Comments**: For specific code-related questions

### Communication Guidelines

- **Be respectful**: Treat everyone with respect
- **Be constructive**: Provide helpful feedback
- **Be patient**: Maintainers are volunteers
- **Be clear**: Explain your questions and suggestions clearly

### Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [YAML Syntax Guide](https://yaml.org/spec/1.2/spec.html)
- [Semantic Versioning](https://semver.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)

## 🙏 Recognition

Contributors will be recognized in:
- **README.md** contributors section
- **Release notes** for significant contributions
- **GitHub contributors** page

## 📄 License

By contributing to this project, you agree that your contributions will be licensed under the same [MIT License](LICENSE) that covers the project.

---

Thank you for contributing to hf-general-ci-tools! Your contributions help make CI/CD more accessible and efficient for everyone. 🚀
