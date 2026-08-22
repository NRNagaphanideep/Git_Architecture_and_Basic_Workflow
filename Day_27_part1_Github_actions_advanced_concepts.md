Day 27 (Part 1): GitHub Actions Advanced Concepts

## 1. Marketplace Actions (`uses: actions/checkout@v4`)
* **What:** Using pre-built action blocks created by GitHub or the community instead of writing custom shell scripts.
* **Why:** The GitHub Actions runner virtual machine is completely empty by default. It does not contain your repository code.
* **Function:** `actions/checkout@v4` clones/downloads your Git repository code into the runner workspace so subsequent steps can execute tests or build artifacts.

## 2. Matrix Strategy (`strategy.matrix`)
* **What:** Running a single job configuration across multiple OS environments and runtime versions simultaneously (in parallel).
* **Why:** Ensures cross-platform compatibility and multi-version stability without duplicating YAML code.
* **Execution:** GitHub Actions automatically calculates the Cartesian product of the matrix parameters (e.g., 2 OS × 2 Node versions = 4 parallel jobs).

---

## 3. Hands-on Workflow Configurations

### Workflow 1: Checkout Action (`checkout-pipeline.yml`)
```yaml
name: Marketplace Actions Pipeline

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  checkout-and-list-job:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository Code
        uses: actions/checkout@v4

      - name: List Files in Repository
        run: |
          echo "Current Working Directory:"
          pwd
          echo "Files in this repository:"
          ls -la
```
### Workflow 2: Matrix Strategy (matrix-pipeline.yml)
```yaml
name: Matrix Strategy Pipeline

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  multi-env-test:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest]
        node-version: [18, 20]

    runs-on: ${{ matrix.os }}

    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Setup Node.js Version
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}

      - name: Verify OS and Node Version
        run: |
          echo "Running on OS: ${{ matrix.os }}"
          echo "Node version inside container:"
          node -v
```
