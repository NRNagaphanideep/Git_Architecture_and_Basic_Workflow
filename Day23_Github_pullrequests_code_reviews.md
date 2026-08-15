# Day 23: Git Advanced Workflow — Pull Requests, Code Reviews & Merge Conflicts

---

## 1. Introduction & Workflow Overview

In a professional software development environment, developers rarely push code directly to the main production branch (`main` or `master`). Instead, teams use a **Feature Branch Workflow** combined with **Pull Requests (PRs)**, **Code Reviews**, and **Conflict Resolution** to maintain code quality, security, and stability.

```
+------------------+         +-------------------+         +-------------------+
|  Feature Branch  | ------> |   Pull Request    | ------> |   Code Review &   |
| (dev-a / dev-b)  |  Push   |  (GitHub/GitLab)  |         |   CI/CD Pipeline  |
+------------------+         +-------------------+         +-------------------+
                                                                     |
                                                                     v
+------------------+         +-------------------+         +-------------------+
|   Local Repo     | <------ |    Main Branch    | <------ |   Merge Commit /  |
|  (git pull)      |  Sync   |     (github)      |  Merge  |  Squash & Merge   |
+------------------+         +-------------------+         +-------------------+
```

---

## 2. Pull Requests (PR)

### What is a Pull Request?
A **Pull Request (PR)** (also called a *Merge Request* in GitLab) is a feature offered by web-based Git hosting platforms (GitHub, GitLab, Bitbucket) that informs team members that a developer has completed a feature or bug fix and wishes to merge their changes into a target branch (e.g., `main` or `develop`).

### Why use Pull Requests?
* **Safety & Control:** Prevents direct, unvetted pushes to production code.
* **Collaboration:** Provides a centralized space for team members to discuss code changes, suggest optimizations, and request modifications.
* **Automation (CI/CD):** Triggers automated build, unit test, and security scan pipelines before code is merged.
* **Audit Trail:** Preserves the history of *why* changes were made and *who* approved them.

### Step-by-Step Pull Request Lifecycle
1. **Create a Feature Branch:**
   ```bash
   git checkout -b feature/login-page
   ```
2. **Make & Commit Changes:**
   ```bash
   git add login.js
   git commit -m "feat: implement user login form validation"
   ```
3. **Push Branch to Remote Repository:**
   ```bash
   git push -u origin feature/login-page
   ```
4. **Open a PR on GitHub/GitLab:**
   * Navigate to the repository on the web platform.
   * Click **Compare & pull request**.
   * Add a descriptive title, detail the changes made in the description body, attach screenshots if applicable, and assign reviewers.

5. **Merge Options in GitHub:**
   * **Create a Merge Commit:** Retains all commits from the feature branch and creates a distinct merge commit on `main`. (Preserves detailed history).
   * **Squash and Merge:** Combines all commits from the feature branch into a single commit on `main`. (Keeps `main` history clean and linear).
   * **Rebase and Merge:** Reapplies commits from the feature branch onto `main` one by one without a merge commit. (Linear history).

---

## 3. Code Reviews

### What is a Code Review?
A **Code Review** is a practice where one or more team members (typically Senior Engineers or Team Leads) inspect proposed code changes prior to merging.

### Objectives of Code Review
* **Quality Assurance:** Ensure adherence to coding standards, formatting guidelines, and architectural patterns.
* **Bug Detection:** Identify edge cases, memory leaks, security vulnerabilities, or logic flaws early.
* **Knowledge Sharing:** Helps spread codebase familiarity across the team so no single developer becomes a single point of failure.

### Code Review Workflow & Outcomes
During a code review, reviewers can choose one of three actions:
* **Approve:** The code meets all standards and is ready to merge.
* **Comment:** General questions, minor suggestions, or compliments without blocking the PR.
* **Request Changes:** Critical issues or bugs identified; blocks merging until the author submits updated commits addressing the feedback.

---

## 4. Merge Conflicts

### What is a Merge Conflict?
A **Merge Conflict** occurs when Git is unable to automatically reconcile differences between two commits across different branches. This happens primarily when two developers modify the **same line(s)** of the **same file** differently, or when one developer deletes a file that another developer is attempting to modify.

### How Git Detects Conflicts (3-Way Merge)
Git uses a **3-Way Merge Algorithm** comparing three distinct snapshots:
1. **Base Commit:** The common ancestor commit before the branches diverged.
2. **Current Branch (HEAD):** The local branch state.
3. **Incoming Branch (Target/Main):** The branch being merged in.

* **No Conflict Case:** If Dev A modifies line 10 and Dev B modifies line 200, Git automatically merges both changes without intervention.
* **Conflict Case:** If Dev A changes line 10 to `"Telugu"` and Dev B changes line 10 to `"English"`, Git pauses the merge process and marks the file as conflicted.

### Anatomy of Conflict Markers
When a conflict occurs, Git embeds conflict markers directly into the affected file:

```text
<<<<<<< HEAD (Current Branch - e.g., dev-b)
Dev-B Line: We are learning Git conflicts with English explanation
=======
Dev-A Line: We are learning Git conflicts with Telugu explanation
>>>>>>> origin/main (Incoming Branch - e.g., main)
```

* **`<<<<<<< HEAD`**: Start of your local branch changes.
* **`=======`**: Divider separating local and incoming changes.
* **`>>>>>>> origin/main`**: End of the incoming branch changes.

---

## 5. Real-Time Hands-On Scenario: Simulating & Resolving Conflicts

Here is a full step-by-step reproduction of creating and resolving a merge conflict via the command line:

### Step 1: Base Setup (`main` branch)
```bash
git checkout main
echo "Original Line: We are learning Git workflow" > conflict_test.txt
git add conflict_test.txt
git commit -m "docs: add base conflict test file"
git push origin main
```

### Step 2: Dev-A Changes (`dev-a` branch)
```bash
git checkout -b dev-a
echo "Dev-A Line: We are learning Git conflicts with Telugu explanation" > conflict_test.txt
git add conflict_test.txt
git commit -m "feat: update text by Dev-A"
git push -u origin dev-a
```
*(Dev-A opens a PR and merges it into `main` on GitHub).*

### Step 3: Dev-B Changes (`dev-b` branch)
```bash
git checkout main
git checkout -b dev-b
echo "Dev-B Line: We are learning Git conflicts with English explanation" > conflict_test.txt
git add conflict_test.txt
git commit -m "feat: update text by Dev-B"
git push -u origin dev-b
```
*(Dev-B tries to merge PR into `main` on GitHub, but GitHub reports: "This branch has conflicts that must be resolved").*

### Step 4: Resolving Conflict Locally on `dev-b`
```bash
git checkout dev-b
git config pull.rebase false
git pull origin main
```
*Output:*
```text
Auto-merging conflict_test.txt
CONFLICT (content): Merge conflict in conflict_test.txt
Automatic merge failed; fix conflicts and then commit the result.
```

### Step 5: Fix Conflict & Push
Edit `conflict_test.txt` to contain the final combined/desired version:
```bash
echo "Dev-A & Dev-B Lines: We are learning Git conflicts with Telugu and English explanation" > conflict_test.txt
git add conflict_test.txt
git commit -m "fix: resolve merge conflict between dev-a and dev-b"
git push origin dev-b
```
*(GitHub automatically updates the PR to show a green "Merge pull request" button).*

### Step 6: Final Cleanup
```bash
git checkout main
git pull origin main
git branch -d dev-a dev-b
```

---

## 6. Resolving Conflicts in Modern IDEs (VS Code)

In enterprise projects with large files (1000+ lines), manually reading conflict markers is simplified using IDE tools like VS Code. 

When opening a conflicted file, VS Code provides inline action buttons above the conflict block:
* **Accept Current Change:** Keeps your local branch code (`HEAD`).
* **Accept Incoming Change:** Keeps the target branch code (`origin/main`).
* **Accept Both Changes:** Retains both code blocks sequentially.
* **Compare Changes:** Opens a side-by-side diff view to compare the 3-way merge details.

---

## 7. Frequently Asked Interview Questions & Answers

### Q1: What is the difference between `git merge` and `git rebase`?
* **Answer:** Both integrate changes from one branch into another.
  * **`git merge`** creates a non-destructive merge commit preserving exact history and commit chronology.
  * **`git rebase`** moves the feature branch commits onto the tip of the target branch, creating a linear history. (Never rebase shared/public branches).

### Q2: What happens if two developers work on the same file, but different lines?
* **Answer:** Git automatically merges the file using its 3-way merge algorithm. No manual merge conflict resolution is required.

### Q3: How do you handle a Merge Conflict during a PR in a real project?
* **Answer:**
  1. Pull the latest target branch changes into your feature branch (`git checkout feature-branch && git pull origin main`).
  2. Locate conflicted files highlighted by Git/IDE.
  3. Discuss with the co-developer if unsure about code logic.
  4. Select/edit the correct code, remove Git markers (`<<<<<<<`, `=======`, `>>>>>>>`).
  5. Stage the resolved files (`git add <file>`), commit the merge (`git commit`), and push to the remote branch (`git push origin feature-branch`).

### Q4: What is the difference between "Squash and Merge" vs "Create a Merge Commit"?
* **Answer:** 
  * **"Create a Merge Commit"** retains every individual commit from the feature branch into the target branch along with a merge commit.
  * **"Squash and Merge"** condenses all feature branch commits into a single unified commit on the target branch, simplifying history logs.

### Q5: How do you prevent Merge Conflicts in large teams?
* **Answer:**
  * Pull from `main`/`develop` frequently (`git pull`).
  * Keep feature branches short-lived and focused on small tasks.
  * Communicate with team members when working on shared modules or core files.
  * Establish clear modular software architecture to minimize overlapping code edits.

