y 26: GitHub Actions CI/CD Pipeline Fundamentals

## 1. Overview of GitHub Actions & Architecture
GitHub Actions is a built-in Continuous Integration and Continuous Deployment (CI/CD) platform that allows you to automate your build, test, and deployment pipelines directly within your GitHub repository.

### Core Architecture Components
* **Workflow:** An automated process defined in a YAML file inside `.github/workflows/`.
* **Event (Trigger):** A specific activity that triggers a workflow (e.g., `push`, `pull_request`, schedule).
* **Job:** A set of steps executed on the same runner environment. By default, jobs run in parallel unless dependencies are declared.
* **Step:** An individual task within a job. It can be a shell command (`run`) or an action (`uses`).
* **Runner:** A virtual machine or container hosted by GitHub (or self-hosted) that executes the jobs.

---

## 2. Directory Structure & Syntax Rules
All GitHub Actions workflow files **must** reside in the following directory path:
`.github/workflows/<filename>.yml`

### Essential Formatting Rules
* **Indentation:** Uses 2 spaces for parent-child hierarchy. **Do NOT use Tabs.**
* **Colon Spacing:** Always include a space after colons for standard properties (e.g., `name: Value`).
* **Lists:** Preceded by `- ` (dash followed by a space).

---

## 3. Triggers & Events (`on:`)
Triggers control *when* and *how* a workflow is executed.

* **`push`:** Runs automatically when code is pushed to specified branches.
* **`pull_request`:** Runs when a Pull Request is opened or updated against a branch.
* **`workflow_dispatch`:** Enables a manual "Run workflow" button inside the GitHub UI.

---

## 4. Job Dependencies (`needs:`)
By default, multiple jobs under `jobs:` run **in parallel**. To run jobs sequentially, use the `needs:` property.

* **Single Dependency:** `needs: job_name`
* **Multiple Dependencies:** `needs: [job_1, job_2]`

---

## 5. Contexts & Environment Variables
Contexts are dynamic objects containing information about the workflow run, environment, and user.

### Standard GitHub Context Properties
* `${{ github.actor }}`: The username of the person who triggered the run.
* `${{ github.ref }}`: The branch or tag reference that triggered the run.
* `${{ github.sha }}`: The exact Git commit hash for the triggering push.
* `${{ github.workflow }}`: The name of the running workflow.

### Custom Environment Variables (`env`)
Custom key-value pairs accessible across the workflow or within specific jobs/steps using `${{ env.VARIABLE_NAME }}` or `$VARIABLE_NAME` in shell scripts.

---

## 6. Encrypted Secrets Management
Sensitive data (API keys, SSH keys, passwords) must never be hardcoded into YAML files.

* **Configuration:** Repository Settings $\rightarrow$ Secrets and variables $\rightarrow$ Actions $\rightarrow$ New repository secret.
* **Accessing in YAML:** `${{ secrets.SECRET_NAME }}`
* **Masking:** GitHub Actions automatically masks secret values in console logs with `***`.

---

## 7. Complete Hands-on Code Implementations

### Pipeline 1: Basic Workflow (`first-pipeline.yml`)
```yaml
name: My First DevOps Pipeline

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  workflow_dispatch:

jobs:
  say-hello-job:
    runs-on: ubuntu-latest
    steps:
      - name: Print Welcome Message
        run: echo "Hello Phanideep! Welcome to Day 26 GitHub Actions."

      - name: Show Current Date and Time
        run: date
```
### 8. Common Errors & Troubleshooting Checklist
| Error Scenario | Root Cause | Solution |
| :--- | :--- | :--- |
| **`Invalid workflow file (Line X)`** | Incorrect YAML indentation or missing spaces around colons. | Ensure 2-space indentation hierarchy; check for spaces after colons. |
| **`Unexpected value 'build-job'`** | Job name aligned at column 0 instead of under `jobs:`. | Indent the job name by 2 spaces under `jobs:`. |
| **`Image 'Ubuntu-latest' is not supported`** | Capitalization error in runner image name (`Ubuntu` instead of `ubuntu`). | Change runner target to lower-case: `runs-on: ubuntu-latest`. |
| **`Command not found / Exit Code 127`** | Typo inside shell command within `run:` (e.g., `echoo`). | Fix syntax of underlying Linux shell command inside `run:`. |
| **Secret value prints as `***`** | Normal behavior—GitHub automatically redacts secrets in workflow outputs. | No fix needed. Secret is being handled securely. |

----

### 9.Interview Questions & Answers

**Q1:** Where must GitHub Actions workflow files be stored in a repository?

**Answer:** All workflow files must be saved under the .github/workflows/ directory in .yml or .yaml format.

**Q2:** How do GitHub Actions jobs execute by default, and how can you force sequential execution?

**Answer:** By default, jobs execute in parallel to save build time. To execute jobs sequentially, use the needs: keyword (e.g., needs: build-job).

**Q3:** How do you trigger a GitHub Actions workflow manually from the GitHub UI?

**Answer:** Add the workflow_dispatch: trigger under the on: section in your workflow configuration.

**Q4:** What is the difference between github.actor and github.sha?

**Answer:**
github.actor contains the username of the user who initiated the workflow execution.

github.sha contains the unique 40-character Git commit hash associated with the triggering push or action.

**Q5:** How does GitHub Actions secure sensitive credentials like API tokens or DB passwords?

**Answer:** Credentials are stored in Repository Settings under Encrypted Secrets. Workflows reference them using ${{ secrets.SECRET_NAME }}. GitHub Actions automatically masks these credentials in all logs (***).
