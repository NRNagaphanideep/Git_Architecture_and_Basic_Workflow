Day 21: Conflict Resolution Lab

## 1. Overview & Core Concepts
In software engineering and DevOps workflows, Git conflicts are a natural and frequent occurrence. A **Merge Conflict** happens when Git cannot automatically reconcile differences between two commits across different branches. This typically occurs when the exact same line(s) of code in a file are modified differently in both branches being merged or rebased.

Git is highly automated, but it strictly avoids making assumptions about business logic. When two conflicting changes touch the exact same line, Git pauses the merge process and delegates the resolution to human developers.

---

## 2. Deep Dive: What Causes a Conflict?
- **Overlapping Edits:** Two developers edit line $N$ of file `config.txt` independently.
- **File Deletion vs. Edit:** Developer A deletes `config.txt` while Developer B modifies `config.txt`.
- **Divergent History:** Branch `main` and `feature` have evolved separately, altering shared dependencies or configuration files.

---

## 3. Demystifying Conflict Markers
When Git encounters a conflict, it injects explicit conflict markers into the affected files:

```text
<<<<<<< HEAD
Database Port: 6379
=======
Database Port: 3306
>>>>>>> feature-db
```

### Breakdown of Anatomy:
1. `<<<<<<< HEAD` : Marks the beginning of the conflicting section in the **current working branch** (the branch you are currently on).
2. `=======` : The separator between your current branch changes and the incoming branch changes.
3. `>>>>>>> feature-db` : Marks the end of the conflicting section from the **incoming branch** being merged.

---

## 4. Step-by-Step Lab Simulation & Resolution Workflow

### Phase 1: Environment Setup & Conflict Creation
```bash
# Step 1: Initialize base file on main branch
git switch main
echo "Database Port: 5432" > config.txt
git add config.txt
git commit -m "feat: set default database port"

# Step 2: Create feature branch and modify the port
git switch -c feature-db
echo "Database Port: 3306" > config.txt
git add config.txt
git commit -m "feat: change port to 3306 for MySQL"

# Step 3: Return to main and modify the same line differently
git switch main
echo "Database Port: 6379" > config.txt
git add config.txt
git commit -m "feat: change port to 6379 for Redis"

# Step 4: Trigger the conflict
git merge feature-db
```

### Phase 2: Resolving the Conflict
1. **Communication First:** Developer A and Developer B align via Slack/Teams to agree on the target configuration (`Database Port: 3306`).
2. **Manual Cleanup:** Open `config.txt` in a code editor or CLI (`nano config.txt`). Remove all Git markers (`<<<<<<<`, `=======`, `>>>>>>>`) and keep only the desired state:
   ```text
   Database Port: 3306
   ```
3. **Stage and Finalize Merge:**
   ```bash
   git add config.txt
   git commit -m "fix: resolve merge conflict for database port"
   git push origin main
   ```

---

## 5. Rebase Conflict Handling vs. Merge Conflict Handling
| Feature | Merge Conflict | Rebase Conflict |
| :--- | :--- | :--- |
| **Command triggered** | `git merge <branch>` | `git rebase <target>` |
| **Commit Creation** | Creates an explicit Merge Commit. | Rewrites history; no separate merge commit. |
| **Resolution Command** | `git add <file>` followed by `git commit` | `git add <file>` followed by `git rebase --continue` |
| **Aborting Procedure** | `git merge --abort` | `git rebase --abort` |

---

## 6. Real-World Best Practices to Minimize Conflicts
1. **Pull Frequently:** Integrate changes from `main` into your feature branch daily (`git pull origin main` or `git rebase main`).
2. **Small, Atomic Commits:** Keep feature branches short-lived and single-purposed.
3. **Modular Code Design:** Avoid monolithic single files where multiple engineers work concurrently.
4. **Communication & PR Reviews:** Notify team members prior to making breaking architectural or configuration changes.

---

## 7. Expanded Top 10 Interview Questions & Answers

### Q1: What is a Git merge conflict and why does it occur?
**Answer:** A Git merge conflict is an event that occurs when Git is unable to automatically resolve differences in code between two commits. It most commonly occurs when two different branches modify the exact same line of a file in different ways, or when one branch deletes a file that another branch is modifying.

### Q2: What do `HEAD` and `=======` signify inside conflict markers?
**Answer:** `HEAD` represents the current tip of the checked-out branch (your current working state). Everything between `<<<<<<< HEAD` and `=======` represents your local changes. Everything between `=======` and `>>>>>>> <branch_name>` represents the incoming changes from the branch being merged.

### Q3: How do you abort a merge in progress if you are not ready to resolve conflicts?
**Answer:** You can safely abort an ongoing merge and revert your working directory to the pre-merge state using the command:
`git merge --abort`

### Q4: What is the difference between resolving a conflict during `git merge` vs `git rebase`?
**Answer:** During a `git merge`, once conflicts are staged (`git add`), you finalize the resolution by running `git commit` to create a merge commit. During a `git rebase`, once conflicts are staged, you run `git rebase --continue` without creating a new merge commit, as rebase replays commits sequentially.

### Q5: If two developers have a merge conflict, who is responsible for resolving it?
**Answer:** Typically, the developer who is attempting to merge their branch into the target branch (or the PR author) is responsible. However, best practices dictate that they must communicate with the developer who wrote the conflicting code to decide which logic to preserve.

### Q6: Can a merge conflict happen on branches other than `main`?
**Answer:** Yes. Merge conflicts can occur between any two branches (e.g., `feature-A` into `feature-B`, `release` into `develop`, or `main` into a feature branch) whenever concurrent divergent changes exist.

### Q7: What is the purpose of `git rerere`?
**Answer:** `git rerere` stands for "Reuse Recorded Resolution". It is a feature that allows Git to remember how you resolved a hunk conflict, so the next time it sees the same conflict, Git can resolve it automatically for you.

### Q8: How can VS Code or modern IDEs assist in resolving merge conflicts?
**Answer:** IDEs parse conflict markers automatically and display Inline Action Buttons (such as "Accept Current Change", "Accept Incoming Change", "Accept Both Changes", or "Compare Changes"), allowing developers to resolve conflicts visually with a single click instead of manually editing raw syntax markers.

### Q9: What happens if you run `git add` and `git commit` without removing conflict markers?
**Answer:** Git treats the conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`) as normal text lines. If you commit without removing them, those syntax markers will be committed directly into your codebase, breaking application syntax, compilation, or runtime execution.

### Q10: How do long-lived feature branches increase the risk of severe merge conflicts, and how do you mitigate this?
**Answer:** The longer a feature branch exists isolated from `main`, the more `main` diverges due to other team members' commits. This leads to massive, complex merge conflicts ("Merge Hell"). Mitigation strategies include practicing **Trunk-Based Development**, keeping feature branches short-lived (1-2 days max), and constantly rebasing/merging `main` into the feature branch.

