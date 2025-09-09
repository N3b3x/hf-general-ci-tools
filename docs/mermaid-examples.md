---
layout: default
title: "📊 Mermaid Examples"
description: "Examples of Mermaid diagrams for workflow visualization"
nav_order: 3
parent: "📖 Examples & Guides"
---

# Mermaid Diagram Examples

This page demonstrates how to use Mermaid diagrams in your documentation to visualize workflows, processes, and relationships.

## Workflow Diagrams

### Basic CI/CD Pipeline

```mermaid
graph LR
    A[Code Push] --> B[Build]
    B --> C[Test]
    C --> D[Deploy]
    D --> E[Monitor]
    
    style A fill:#e1f5fe
    style B fill:#f3e5f5
    style C fill:#e8f5e8
    style D fill:#fff3e0
    style E fill:#fce4ec
```

### GitHub Actions Workflow

```mermaid
graph TD
    A[Trigger: Push/PR] --> B[Checkout Code]
    B --> C[Setup Environment]
    C --> D[Install Dependencies]
    D --> E[Run Tests]
    E --> F{Tests Pass?}
    F -->|Yes| G[Build Documentation]
    F -->|No| H[Report Failure]
    G --> I[Deploy to Pages]
    I --> J[Notify Success]
    H --> K[Notify Failure]
    
    style A fill:#e3f2fd
    style F fill:#fff3e0
    style G fill:#e8f5e8
    style H fill:#ffebee
    style I fill:#e8f5e8
    style J fill:#e8f5e8
    style K fill:#ffebee
```

## Best Practices

### 1. Keep Diagrams Simple
- Use clear, descriptive labels
- Avoid overcrowding with too many elements
- Use consistent styling and colors

### 2. Use Appropriate Diagram Types
- **Flowcharts**: For processes and workflows
- **Sequence Diagrams**: For interactions between components
- **Class Diagrams**: For system architecture
- **State Diagrams**: For state transitions
- **Gantt Charts**: For project timelines

### 3. Consistent Styling
- Use the same color scheme throughout your documentation
- Apply consistent node shapes and sizes
- Use meaningful icons and symbols

### 4. Accessibility
- Provide alternative text descriptions for complex diagrams
- Ensure diagrams are readable in both light and dark modes
- Use high contrast colors for better visibility

## Integration with Just the Docs

The Mermaid diagrams are automatically rendered by the Just the Docs theme when you include them in your markdown files. The diagrams will:

- Automatically adapt to your theme's color scheme
- Be responsive and work on mobile devices
- Support both light and dark modes
- Be included in the search functionality

## Troubleshooting

If your Mermaid diagrams are not rendering:

1. Check that the Mermaid CDN script is included
2. Ensure your Mermaid syntax is correct
3. Verify that the diagram is properly enclosed in code blocks with `mermaid` language specification
4. Check the browser console for any JavaScript errors

For more information about Mermaid syntax, visit the [official Mermaid documentation](https://mermaid-js.github.io/mermaid/).

<script src="https://cdn.jsdelivr.net/npm/mermaid@10.6.1/dist/mermaid.min.js"></script>
<script>
  mermaid.initialize({ startOnLoad: true });
</script>
