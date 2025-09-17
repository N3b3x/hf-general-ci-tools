# API Link Injection for Jekyll Documentation

This solution provides automatic injection of API documentation links into Jekyll `_config.yml` during the documentation build process, ensuring proper linking based on version type and deployment context.

## 🚀 Quick Start

### 1. Use the Simple Script

The `inject-api-links-simple.sh` script uses Python for reliable YAML processing:

```bash
# Download and run the script
curl -o inject-api-links.sh https://raw.githubusercontent.com/n3b3x/hf-general-ci-tools/main/docs/inject-api-links-simple.sh
chmod +x inject-api-links.sh

# Run the injection
./inject-api-links.sh \
  "_config/_config.yml" \
  "$VERSION" \
  "$VERSION_TYPE" \
  "$REPO_NAME"
```

### 2. Integration with docs.yml Workflow

Add this step to your `docs.yml` workflow:

```yaml
- name: Inject API links into Jekyll config
  run: |
    # Download the injection script
    curl -o inject-api-links.sh https://raw.githubusercontent.com/n3b3x/hf-general-ci-tools/main/docs/inject-api-links-simple.sh
    chmod +x inject-api-links.sh
    
    # Run the injection script
    ./inject-api-links.sh \
      "_config/_config.yml" \
      "${{ needs.version-detection.outputs.version }}" \
      "${{ needs.version-detection.outputs.version_type }}" \
      "${{ github.event.repository.name }}"
```

## 📋 What It Does

### Automatic URL Generation

| Version Type | Base URL | API URL |
|--------------|----------|---------|
| **Release** | `/repo-name/v1.2.3` | `/repo-name/v1.2.3/doxs/index.html` |
| **Release Candidate** | `/repo-name/v1.2.3-rc1` | `/repo-name/v1.2.3-rc1/doxs/index.html` |
| **Development** | `/repo-name` | `/repo-name/doxs/index.html` |

### Configuration Updates

The script automatically:

1. **Injects API links** into both `aux_links` and `nav_external_links` sections
2. **Updates baseurl** to match the version context
3. **Updates title** with version information for releases
4. **Creates backups** before making changes
5. **Validates** the configuration after injection

### Example Output

**Before injection:**
```yaml
aux_links:
  "📚 GitHub Repository":
    - "https://github.com/n3b3x/hf-general-ci-tools"
  "🐛 Report Issues":
    - "https://github.com/n3b3x/hf-general-ci-tools/issues"
  "⭐ Star on GitHub":
    - "https://github.com/n3b3x/hf-general-ci-tools/stargazers"
```

**After injection (Release v1.2.3):**
```yaml
aux_links:
  "📚 GitHub Repository":
    - "https://github.com/n3b3x/hf-general-ci-tools"
  "🐛 Report Issues":
    - "https://github.com/n3b3x/hf-general-ci-tools/issues"
  "⭐ Star on GitHub":
    - "https://github.com/n3b3x/hf-general-ci-tools/stargazers"
  "📖 API Reference":
    - "/hf-general-ci-tools/v1.2.3/doxs/index.html"
```

## 🔧 Technical Details

### Script Features

- ✅ **Python-based**: Reliable YAML processing using regex
- ✅ **Safe**: Creates backups before modification
- ✅ **Version-aware**: Different URLs for different version types
- ✅ **Robust**: Handles existing API links gracefully
- ✅ **Verifiable**: Provides detailed output and verification

### Dependencies

- `python3` (available in GitHub Actions Ubuntu runners)
- `curl` (for downloading the script)
- Standard Unix tools (`chmod`, `grep`)

### Error Handling

- Validates config file exists
- Creates backups before modification
- Provides detailed error messages
- Verifies changes after injection

## 📁 Files Created

1. **`inject-api-links-simple.sh`** - Main injection script (Python-based)
2. **`inject-api-links.sh`** - Alternative script (Bash/sed-based)
3. **`api-injection-example.yml`** - Complete workflow example
4. **`api-link-injection-guide.md`** - Detailed integration guide

## 🎯 Benefits

- 🚀 **Automatic**: No manual configuration needed
- 🔄 **Version-aware**: Different URLs for different versions
- 🛡️ **Safe**: Creates backups before modification
- 🔍 **Verifiable**: Provides detailed output and verification
- 🎯 **Flexible**: Works with any Jekyll configuration structure
- 📱 **Responsive**: Updates both navigation and auxiliary links

## 🔗 Integration Points

This solution integrates seamlessly with:
- ✅ **hf-general-ci-tools/docs.yml** - The main documentation workflow
- ✅ **Versioned documentation** - Automatic version detection and URL generation
- ✅ **Doxygen integration** - Works with centralized `/doxs/` directory
- ✅ **GitHub Pages deployment** - Proper baseurl handling for subdirectories

## 📖 Usage Examples

### Development Build
```bash
./inject-api-links-simple.sh "_config/_config.yml" "development" "development" "my-repo"
# Result: /my-repo/doxs/index.html
```

### Release Build
```bash
./inject-api-links-simple.sh "_config/_config.yml" "v1.2.3" "release" "my-repo"
# Result: /my-repo/v1.2.3/doxs/index.html
```

### Release Candidate Build
```bash
./inject-api-links-simple.sh "_config/_config.yml" "v1.2.3-rc1" "release-candidate" "my-repo"
# Result: /my-repo/v1.2.3-rc1/doxs/index.html
```

## 🚨 Important Notes

1. **Backup Creation**: Always creates a backup before modification
2. **Idempotent**: Safe to run multiple times
3. **Version Detection**: Requires proper version detection in your workflow
4. **Doxygen Output**: Assumes Doxygen generates docs in `/doxs/` directory
5. **Python Dependency**: Requires Python 3 (available in GitHub Actions)

## 🔍 Troubleshooting

### Common Issues

1. **Script not found**: Ensure the download URL is accessible
2. **Permission denied**: Make sure the script is executable
3. **Config file not found**: Verify the path to `_config/_config.yml`
4. **Python not found**: Ensure Python 3 is available in the environment

### Debug Mode

The script provides detailed output by default. For additional debugging, check the backup file if issues occur:

```bash
# Restore from backup if needed
cp _config/_config.yml.backup _config/_config.yml
```

## 📚 Related Documentation

- [API Link Injection Guide](api-link-injection-guide.md) - Detailed integration guide
- [Complete Workflow Example](api-injection-example.yml) - Full workflow implementation
- [Versioning Guide](versioning-guide.md) - Version management documentation
- [Docs Workflow](docs-workflow.md) - Main documentation workflow

---

**Ready to use!** This solution provides everything needed to automatically inject API documentation links into your Jekyll configuration during the build process.