Day 23: GitHub Collaboration – Pull Requests, Code Reviews & Merge Conflicts

## 1. Overview
In a real-world DevOps environment, multiple engineers work on the same codebase simultaneously. Day 23 covers essential GitHub collaboration strategies: creating Pull Requests (PRs), conducting effective Code Reviews, and resolving Merge Conflicts confidently.

---

## 2. Key Concepts & Workflows

### A. Pull Requests (PRs)
A Pull Request is a feature that lets developers notify team members about changes pushed to a GitHub repository branch.
* **Workflow:**
  1. Create a feature branch locally: `git checkout -b feature-branch`
  2. Make changes, commit, and push: `git push -u origin feature-branch`
  3. Navigate to GitHub and click **Compare & pull request**.
  4. Submit the PR for team review before merging into `main`.

### B. Code Reviews
Code reviews ensure code quality, readability, security, and project consistency before changes enter production.
* **Best Practices:**
  * **Clarity:** Ensure code is clean, self-explanatory, and documented.
  * **Maintainability:** Verify adherence to team coding standards.
  * **Constructive Feedback:** Provide actionable suggestions to foster team growth.

### C. Merge Conflicts
A Merge Conflict occurs when Git cannot automatically reconcile differences between two branches—typically when developers modify the exact same line(s) in a file.

#### Resolving Conflicts Step-by-Step (Command Line):
1. **Identify Conflict:** Fetch latest changes from remote `main`:
   ```bash
   git checkout feature-branch
   git pull origin main
2. Locate Markers: Git injects conflict markers into affected files:

`<<<<<<< HEAD (Current Branch Changes)
Your local line update
=======
Remote main branch line update
>>>>>>> origin/main`

3. Resolve: Manually edit the file, choose the correct lines, and delete all Git conflict markers (<<<<<<<, =======, >>>>>>>).

4.Finalize:
git add <resolved-file>
git commit -m "fix: resolve merge conflict between main and feature-branch"
git push origin feature-branch
    
```

## DevOps Interview Questions & Answers

**Q1:** What is the primary difference between a Pull Request (PR) and a Merge Request (MR)?

**Answer:** Functionally, they are identical. "Pull Request" is the term used by GitHub and Bitbucket, whereas "Merge Request" is the terminology used by GitLab. Both represent a request to merge changes from one branch into another after review.

**Q2:** How does Git detect a Merge Conflict in large files (e.g., 1000+ lines)?

**Answer:** Git uses a 3-Way Merge algorithm comparing the Base Commit (common ancestor), Current Branch, and Target Branch. Git only flags a conflict if the exact same line or code block was modified differently in both branches. Changes to separate line ranges in the same file are auto-merged seamlessly.

**Q3:** Can a PR be merged if conflicts exist?

**Answer:** No. GitHub locks the "Merge Pull Request" button until all conflicting files are resolved either via the Web Editor or locally on the command line.

**Q4:** How do modern IDEs like VS Code simplify conflict resolution?

**Answer:** VS Code automatically detects conflict markers and provides 1-click UI options:

Accept Current Change: Retains local branch changes.

Accept Incoming Change: Retains target branch changes.

Accept Both Changes: Merges both sets of lines.

### Summary Checklist

[x] Branch creation and feature implementation

[x] Opening PR on GitHub

[x] Code review process

[x] Resolving merge conflicts step-by-step

[x] Final PR merge to main and branch cleanup


