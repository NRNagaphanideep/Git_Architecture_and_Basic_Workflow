y 28: GitHub Actions - Reusable Workflows & Custom Composite Actions

## 1. Concept Overview & Comparison

### A. Reusable Workflows (`on: workflow_call`)
* **What:** Reusing entire workflow configurations across multiple repositories or pipelines using the `workflow_call` trigger.
* **Why:** Eliminates code duplication across multiple applications (DRY Principle) and standardizes deployment pipelines centrally.
* **Key Feature:** Accepts parameters (`inputs`) and secrets (`secrets`) passed from the calling workflow.

### B. Custom Composite Actions (`action.yml`)
* **What:** Packaging multiple shell commands or pipeline steps into a single, custom Marketplace-style action.
* **Why:** Simplifies long job steps by grouping repetitive setup commands into a reusable module.
* **Location:** Stored in a subdirectory inside `.github/actions/<action-name>/action.yml`.

| Feature | Reusable Workflows (`workflow_call`) | Composite Actions (`action.yml`) |
| :--- | :--- | :--- |
| **Scope** | Entire Jobs and Workflows | Individual Steps within a single Job |
| **Trigger** | `on: workflow_call` | `runs.using: "composite"` |
| **File Location** | `.github/workflows/*.yml` | `.github/actions/<action-name>/action.yml` |
| **Use Case** | Centralized CI/CD Deployment Pipelines | Grouping repetitive setup/shell commands |

---

## 2. Complete Code Configurations

### Workflow 1: Called Reusable Workflow (`.github/workflows/called-workflow.yml`)
```yaml
name: Reusable Deployment Workflow

on:
  workflow_call:
    inputs:
      target-environment:
        required: true
        type: string

jobs:
  shared-deploy-job:
    runs-on: ubuntu-latest
    steps:
      - name: Display Target Environment
        run: |
          echo "Executing Central Deployment Logic..."
          echo "Deploying Application to: ${{ inputs.target-environment }}"
```
### Workflow 2: Main Caller Workflow (.github/workflows/main-caller-pipeline.yml)

```
name: Main Pipeline Calling Reusable Workflow

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  call-dev-deploy:
    uses: ./.github/workflows/called-workflow.yml
    with:
      target-environment: "Development Environment"

  call-prod-deploy:
    needs: call-dev-deploy
    uses: ./.github/workflows/called-workflow.yml
    with:
      target-environment: "Production Environment"
```

### Custom Action Definition (.github/actions/custom-setup/action.yml)

```

name: "Custom System Setup Action"
description: "Prints system information and sets up custom environment"

runs:
  using: "composite"
  steps:
    - name: Print System Info
      shell: bash
      run: |
        echo "=== Running Composite Action ==="
        echo "Operating System:"
        uname -a

    - name: Show Current Date
      shell: bash
      run: date
```

### Workflow 3: Pipeline Using Composite Action (.github/workflows/composite-pipeline.yml)

```
name: Composite Action Pipeline

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  test-composite-job:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Run Our Custom Composite Action
        uses: ./.github/actions/custom-setup

      - name: Final Step
        run: echo "Composite Action executed successfully!"
```

### 3. Interview Questions & Answers

**Q1:** What is the primary difference between a Reusable Workflow and a Composite Action?

**Answer:** A Reusable Workflow reuses entire jobs and workflows triggered by on: workflow_call. A Composite Action packages multiple individual steps into a single reusable action using runs.using: "composite" within a specific job.

**Q2:** How do you pass inputs to a Reusable Workflow?

**Answer:** You define inputs under on.workflow_call.inputs in the called workflow and supply values using the with: key when invoking the workflow via uses: in the caller pipeline.

**Q3:** What mandatory key must be added to every step in a Composite Action action.yml file?

**Answer:** The shell: parameter (e.g., shell: bash) is compulsory for every run step in a composite action.

**Q4:** How does applying the DRY principle in GitHub Actions help enterprise teams?

**Answer:** It centralizes build and deployment standards, reduces code maintenance, ensures compliance across hundreds of repositories, and allows security fixes to be applied in a single template file.
