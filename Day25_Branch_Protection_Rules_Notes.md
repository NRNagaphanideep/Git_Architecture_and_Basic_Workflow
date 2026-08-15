# Day 25: GitHub Security — Branch Protection Rules & Repository Security

## 1. Executive Summary & Overview
In enterprise software development, maintaining code integrity on primary production branches (`main` or `master`) is critical. Unrestricted push access can lead to broken builds, unintended deletion of branches, or deployment of unreviewed code. 

Day 25 focuses on implementing **Branch Protection Rules** (and Rulesets) on GitHub. This enforcement guarantees that changes to production branches can only occur through structured **Pull Requests (PRs)** supported by mandatory code reviews, automated checks, and restricted administrative operations.

---

## 2. Core Security Concepts & Enterprise Best Practices

### 2.1 Why Direct Push Restrictions Are Essential
* **Prevent Production Outages:** Prevents unverified or untested code from breaking the production environment.
* **Auditability & Traceability:** Forces code to be documented via PR descriptions, conversation threads, and approval records.
* **History Preservation:** Disables dangerous operations like `git push --force` or branch deletion.

### 2.2 Branch Protection Rule Components
1. **Require Pull Request Before Merging:** Blocks direct CLI pushes (`git push origin main`).
2. **Require Approvals:** Enforces code reviews by peer developers or tech leads before code merge.
3. **Require Status Checks:** Integrates with CI/CD pipelines to ensure automated tests pass prior to merging.
4. **Block Force Pushing & Deletions:** Ensures commit history remains immutable.

---

## 3. Step-by-Step Configuration & Verification

### Step 1: Setting Up Branch Protection Rules (Rulesets)
1. Go to **Settings** $
ightarrow$ **Branches** (or **Rulesets**).
2. Click **Add rule** or **New ruleset**.
3. Set **Target Branch**: Include `main`.
4. Enable Protections:
   * **Require a pull request before merging**
   * **Require approvals** (Minimum required: 1)
5. Change Enforcement Status to **Active** and click **Save changes**.

### Step 2: Testing Direct Push Rejection (Expected CLI Output)
When attempting a direct push to `main` via terminal:
```bash
git checkout main
echo "Direct Change" >> README.md
git add README.md
git commit -m "test: direct push"
git push origin main
```
**Error Output Enforcement:**
```text
remote: error: GH013: Repository rule violations found for refs/heads/main.
remote: - Changes must be made through a pull request.
! [remote rejected] main -> main (push declined due to repository rule violations)
error: failed to push some refs to 'github.com:<username>/<repo>.git'
```

### Step 3: Resolving PR Review Blocks in Single-User Sandbox Environments
When working as the sole owner of a repository, GitHub prevents PR authors from approving their own PRs:
* **Option A (Bypass Enforcement):** Administrators can check **"Do not allow bypassing the above settings"** or use **"Bypass rules and merge"** if enabled.
* **Option B (Temporarily Disable Self-Approval Rule):** In settings, uncheck **"Do not allow bypassing..."** or temporarily reduce approval count to 0 for self-guided testing.

---

## 4. Summary Matrix & Quick Reference Table

| Setting / Feature | Purpose | Target Environment | Behavior When Triggered |
| :--- | :--- | :--- | :--- |
| **Direct Push Restriction** | Blocks direct CLI commits | Production / `main` | Rejects `git push` with error GH013 |
| **Required PR Approvals** | Mandates peer code reviews | All Protected Branches | Disables `Merge Pull Request` button |
| **Block Force Push** | Prevents overwriting history | Production / `main` | Blocks `git push --force` |
| **Require Status Checks** | Ensures CI test pass | CI/CD Pipelines | Blocks PR merge until tests pass |

---

**Interview Questions:**
1. **What are Branch Protection Rules in GitHub?**
   * *Answer:* Rules configured on repository branches to prevent direct commits, mandate Pull Requests, enforce peer reviews, and block destructive operations like force pushes or branch deletions.
2. **What happens when a developer tries `git push origin main` on a protected branch?**
   * *Answer:* GitHub rejects the push with error `GH013: Repository rule violations found`, forcing changes to be made through a feature branch via Pull Request.


