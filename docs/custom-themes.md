---
layout: default
title: "🎨 Custom Themes"
description: "Learn how to customize the appearance of your documentation"
nav_order: 1
parent: "⚡ Advanced Features"
---

# 🎨 Custom Themes

Just the Docs provides excellent theming capabilities. This guide shows you how to create beautiful, custom themes for your documentation.

## 🌈 Built-in Color Schemes

Just the Docs comes with several built-in color schemes:

### Light Theme (Default)
```yaml
color_scheme: light
```

### Dark Theme
```yaml
color_scheme: dark
```

### Auto Theme (Recommended)
```yaml
color_scheme: auto  # Automatically switches based on user preference
```

## 🎨 Creating Custom Color Schemes

### Step 1: Create Color Scheme File

Create a new file: `_sass/color_schemes/custom.scss`

```scss
// Custom color scheme
$body-background-color: #ffffff;
$body-text-color: #1f2937;
$link-color: #2563eb;
$link-color-hover: #1d4ed8;
$link-color-visited: #7c3aed;

// Navigation colors
$nav-child-link-color: #6b7280;
$nav-child-link-color-hover: #2563eb;

// Code colors
$code-background-color: #f3f4f6;
$code-text-color: #1f2937;

// Border colors
$border-color: #e5e7eb;
$border-color-dark: #374151;

// Button colors
$btn-primary-color: #2563eb;
$btn-primary-color-hover: #1d4ed8;
```

### Step 2: Apply Your Custom Theme

Update your `_config.yml`:

```yaml
color_scheme: custom
```

## 🌙 Dark Mode Customization

### Custom Dark Theme
```scss
// _sass/color_schemes/custom-dark.scss
[data-color-scheme="dark"] {
  --body-background-color: #0f172a;
  --body-text-color: #f1f5f9;
  --link-color: #60a5fa;
  --link-color-hover: #93c5fd;
  
  // Code blocks
  --code-background-color: #1e293b;
  --code-text-color: #f1f5f9;
  
  // Navigation
  --nav-child-link-color: #94a3b8;
  --nav-child-link-color-hover: #60a5fa;
}
```

## 🎯 Advanced Customization

### Custom CSS Variables
```scss
// _sass/custom/custom.scss
:root {
  // Primary colors
  --primary-50: #eff6ff;
  --primary-500: #3b82f6;
  --primary-900: #1e3a8a;
  
  // Semantic colors
  --success-color: #10b981;
  --warning-color: #f59e0b;
  --error-color: #ef4444;
  --info-color: #3b82f6;
  
  // Spacing
  --spacing-xs: 0.25rem;
  --spacing-sm: 0.5rem;
  --spacing-md: 1rem;
  --spacing-lg: 1.5rem;
  --spacing-xl: 2rem;
  
  // Typography
  --font-family-sans: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  --font-family-mono: 'JetBrains Mono', 'Fira Code', monospace;
  
  // Border radius
  --border-radius-sm: 0.25rem;
  --border-radius-md: 0.5rem;
  --border-radius-lg: 0.75rem;
}
```

### Custom Components
```scss
// Custom callout styles
.callout {
  border-radius: var(--border-radius-md);
  padding: var(--spacing-md);
  margin: var(--spacing-lg) 0;
  border-left: 4px solid;
  
  &.success {
    background-color: rgba(16, 185, 129, 0.1);
    border-color: var(--success-color);
    color: var(--success-color);
  }
  
  &.warning {
    background-color: rgba(245, 158, 11, 0.1);
    border-color: var(--warning-color);
    color: var(--warning-color);
  }
}
```

## 🎨 Theme Examples

### Professional Blue Theme
```scss
$body-background-color: #ffffff;
$body-text-color: #1e293b;
$link-color: #2563eb;
$link-color-hover: #1d4ed8;
$code-background-color: #f8fafc;
$border-color: #e2e8f0;
```

### Modern Dark Theme
```scss
$body-background-color: #0f172a;
$body-text-color: #f1f5f9;
$link-color: #60a5fa;
$link-color-hover: #93c5fd;
$code-background-color: #1e293b;
$border-color: #334155;
```

### Warm Orange Theme
```scss
$body-background-color: #fffbeb;
$body-text-color: #92400e;
$link-color: #ea580c;
$link-color-hover: #c2410c;
$code-background-color: #fef3c7;
$border-color: #fbbf24;
```

## 🚀 Best Practices

### 1. Use CSS Custom Properties
```scss
:root {
  --primary-color: #2563eb;
  --primary-hover: #1d4ed8;
}

.button {
  background-color: var(--primary-color);
  
  &:hover {
    background-color: var(--primary-hover);
  }
}
```

### 2. Support Both Light and Dark Modes
```scss
:root {
  --text-color: #1f2937;
  --bg-color: #ffffff;
}

[data-color-scheme="dark"] {
  --text-color: #f9fafb;
  --bg-color: #111827;
}
```

### 3. Use Semantic Color Names
```scss
:root {
  --color-success: #10b981;
  --color-warning: #f59e0b;
  --color-error: #ef4444;
  --color-info: #3b82f6;
}
```

### 4. Test Accessibility
Ensure your color combinations meet WCAG contrast requirements:

```scss
// Good contrast ratio
$text-color: #1f2937;  // Dark text
$bg-color: #ffffff;    // Light background

// Poor contrast ratio (avoid)
$text-color: #9ca3af;  // Light text
$bg-color: #f9fafb;    // Very light background
```

## 🎯 Implementation Tips

### 1. Start with the Default Theme
Begin with the built-in themes and gradually customize.

### 2. Use CSS Variables
This makes it easier to maintain and update colors.

### 3. Test on Multiple Devices
Ensure your theme looks good on desktop, tablet, and mobile.

### 4. Consider User Preferences
Use the `auto` color scheme to respect user system preferences.

## 📚 Resources

- [Just the Docs Customization Guide](https://just-the-docs.com/docs/customization/)
- [CSS Custom Properties MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties)
- [WCAG Color Contrast Guidelines](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html)

---

<div class="callout tip">
<strong>💡 Pro Tip:</strong> Start with a simple color scheme and gradually add more sophisticated styling as you become comfortable with the customization options.
</div>
