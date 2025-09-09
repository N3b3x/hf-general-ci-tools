---
layout: mermaid
title: "Mermaid Diagram Examples"
description: "Examples of Mermaid diagrams for workflow visualization"
nav_order: 6
toc: true
related:
  - title: "Documentation Workflow"
    url: "/docs-workflow"
  - title: "Example Workflows"
    url: "/example-workflows"
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

### Documentation Generation Process

```mermaid
flowchart TD
    A[Source Files] --> B{File Type?}
    B -->|Markdown| C[Process Markdown]
    B -->|Doxygen| D[Generate API Docs]
    B -->|Jekyll| E[Build Jekyll Site]
    
    C --> F[Apply Templates]
    D --> F
    E --> F
    
    F --> G[Generate TOC]
    G --> H[Apply Styling]
    H --> I[Optimize Assets]
    I --> J[Deploy to Pages]
    
    style A fill:#e1f5fe
    style B fill:#fff3e0
    style F fill:#f3e5f5
    style J fill:#e8f5e8
```

## Sequence Diagrams

### Documentation Workflow Sequence

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant GH as GitHub
    participant WF as Workflow
    participant Docs as Documentation
    participant Pages as GitHub Pages
    
    Dev->>GH: Push code changes
    GH->>WF: Trigger documentation workflow
    WF->>WF: Check for Doxyfile
    WF->>WF: Install dependencies
    WF->>Docs: Generate documentation
    Docs->>WF: Return generated files
    WF->>Pages: Deploy to GitHub Pages
    Pages->>Dev: Documentation updated
```

## Class Diagrams

### Workflow Configuration Structure

```mermaid
classDiagram
    class WorkflowConfig {
        +String name
        +String description
        +Map inputs
        +List steps
        +Map outputs
        +validate()
        +execute()
    }
    
    class InputParameter {
        +String name
        +String type
        +String description
        +Boolean required
        +String default
    }
    
    class WorkflowStep {
        +String name
        +String action
        +Map parameters
        +Map conditions
        +execute()
    }
    
    WorkflowConfig --> InputParameter : contains
    WorkflowConfig --> WorkflowStep : contains
```

## State Diagrams

### Documentation Build States

```mermaid
stateDiagram-v2
    [*] --> Initializing
    Initializing --> CheckingDependencies
    CheckingDependencies --> InstallingDeps
    InstallingDeps --> BuildingDocs
    BuildingDocs --> TestingLinks
    TestingLinks --> Deploying
    Deploying --> Completed
    Completed --> [*]
    
    CheckingDependencies --> Failed : Dependencies missing
    InstallingDeps --> Failed : Installation error
    BuildingDocs --> Failed : Build error
    TestingLinks --> Failed : Broken links
    Deploying --> Failed : Deployment error
    
    Failed --> [*]
    
    note right of Failed
        All failures are logged
        and reported to user
    end note
```

## Gantt Charts

### Documentation Project Timeline

```mermaid
gantt
    title Documentation Project Timeline
    dateFormat  YYYY-MM-DD
    section Planning
    Requirements gathering    :done,    req, 2024-01-01, 2024-01-07
    Design documentation     :done,    design, 2024-01-08, 2024-01-14
    section Development
    Core workflows          :active,  core, 2024-01-15, 2024-02-15
    Documentation generation :         docs, 2024-02-01, 2024-02-28
    Testing and validation  :         test, 2024-02-15, 2024-03-01
    section Deployment
    Release preparation     :         release, 2024-03-01, 2024-03-07
    Public release          :         public, 2024-03-08, 2024-03-10
```

## Pie Charts

### Workflow Usage Distribution

```mermaid
pie title Workflow Usage Distribution
    "C/C++ Lint" : 35
    "Documentation" : 25
    "Static Analysis" : 20
    "Link Check" : 15
    "YAML Lint" : 5
```

## Git Graphs

### Repository Branch Structure

```mermaid
gitgraph
    commit id: "Initial commit"
    branch develop
    checkout develop
    commit id: "Add workflows"
    commit id: "Add documentation"
    checkout main
    merge develop
    commit id: "Release v1.0"
    branch feature/docs
    checkout feature/docs
    commit id: "Add Mermaid support"
    commit id: "Enhance styling"
    checkout main
    merge feature/docs
    commit id: "Release v1.1"
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

1. Check that the `jekyll-mermaid` plugin is included in your `_config.yml`
2. Ensure your Mermaid syntax is correct
3. Verify that the diagram is properly enclosed in code blocks with `mermaid` language specification
4. Check the browser console for any JavaScript errors

For more information about Mermaid syntax, visit the [official Mermaid documentation](https://mermaid-js.github.io/mermaid/).
