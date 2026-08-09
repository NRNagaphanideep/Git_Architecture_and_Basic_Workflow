cat << 'EOF' > Day_17_18_Git_Undoing_and_Stashing.md
# Day 17 & 18: Undoing Changes and Stashing in Git

## Table of Contents
- [Overview](#overview)
- [Core Definitions & Concepts](#core-definitions--concepts)
  - [1. git reset](#1-git-reset)
  - [2. git revert](#2-git-revert)
  - [3. git stash](#3-git-stash)
- [Technical Comparison Table](#technical-comparison-table)
- [Interview Questions & Answers](#interview-questions--answers)
- [Practical Workflow Commands](#practical-workflow-commands)

---

## Overview

This guide covers advanced Git techniques for managing, undoing, and stashing changes within a repository. These commands are essential for Site Reliability Engineers (SREs), DevOps Engineers, and Software Developers who need to navigate complex version control workflows safely.

---

## Core Definitions & Concepts

### 1. git reset

`git reset` is a command used to move the current branch tip (`HEAD`) backward to a specified previous commit. It is primarily used to undo local, unpushed commits or to alter the state of the Staging Area and Working Directory relative to past commits.

#### Reset Modes:

* **`git reset --soft <commit_id>`**
  * **Definition:** Undoes commits up to the specified `<commit_id>`, but leaves all modified files intact in the **Staging Area** (Staged state).
  * **Use Case:** Combining multiple commits, adjusting commit messages, or adding missing files before re-committing.

* **`git reset --mixed <commit_id>` (Default Mode)**
  * **Definition:** Undoes commits and un-stages the changes, leaving modified files intact in the **Working Directory** (Unstaged state).
  * **Use Case:** Un-staging files to review, break up, or selectively re-stage changes.

* **`git reset --hard <commit_id>`**
  * **Definition:** Undoes commits, clears the Staging Area, and completely discards all modifications in the Working Directory, reverting files back to the exact snapshot of the target commit.
  * **Use Case:** Abandoning broken experiments or completely discarding uncommitted work.

---

### 2. git revert

* **Definition:** `git revert` creates a brand-new commit that applies the exact inverse (opposite) changes of a specified previous commit. It does not alter, erase, or rewrite existing Git history.
* **Use Case:** Ideal for undoing changes on shared, public, or remote branches (e.g., `main` or `release`) without breaking team history or causing synchronization conflicts.

---

### 3. git stash

* **Definition:** `git stash` takes the uncommitted modifications from your Working Directory and Staging Area, stores them on a temporary stack, and reverts your working directory back to a clean state matching the `HEAD` commit.

#### Essential Stash Commands:

* `git stash push -u -m "message"`: Saves all tracked and untracked (`-u`) changes onto the stash stack with a descriptive name.
* `git stash list`: Displays a list of all currently stored stash entries.
* `git stash pop`: Re-applies the most recent stash entry (`stash@{0}`) to your working directory and removes it from the stack.
* `git stash apply`: Re-applies a stash entry to your working directory while keeping it stored on the stash stack.
* `git stash drop stash@{n}`: Permanently removes a specific stash entry from the stack.

---

## Technical Comparison Table

| Command | Undo Scope | Staging Area State | Working Directory State | Best Used For |
| :--- | :--- | :--- | :--- | :--- |
| **`git reset --soft`** | Local Commit | Preserved (Staged) | Preserved | Re-committing or fixing commit messages |
| **`git reset --mixed`** | Local Commit | Cleared (Unstaged) | Preserved | Re-evaluating staged files |
| **`git reset --hard`** | Local Commit | Discarded | Discarded | Completely wiping uncommitted work |
| **`git revert`** | Public Commit | Preserved via New Commit | Preserved via New Commit | Safely reverting changes on shared branches |
| **`git stash`** | Temporary State | Stashed to Stack | Restored to Clean `HEAD` | Context-switching without committing incomplete code |

---

## Interview Questions & Answers

### Q1: What is the main difference between `git reset` and `git revert`?
> **Answer:** `git reset` alters the commit history by moving the `HEAD` pointer backward, effectively removing commits from the current branch. It should only be used for local, unpushed changes. Conversely, `git revert` preserves history by creating a new commit that explicitly reverses the changes of a previous commit, making it safe for public/remote branches.

### Q2: What happens when you execute `git reset --hard HEAD~1`?
> **Answer:** It moves the `HEAD` pointer back by one commit, un-stages all changes in the index, and completely discards all modifications in the Working Directory. Any uncommitted work modified in that state is permanently lost unless tracked in a separate stash or commit.

### Q3: Why doesn't a standard `git stash` save newly created files, and how do you include them?
> **Answer:** By default, `git stash` only stores modifications made to already tracked files. To include newly created, untracked files in the stash, you must pass the `-u` or `--include-untracked` flag (e.g., `git stash push -u -m "work in progress"`).

### Q4: How do you recover a commit that was accidentally discarded using `git reset --hard`?
> **Answer:** You can inspect `git reflog`, which records every reference update made to the local repository `HEAD`. Once you locate the commit hash of the lost state, you can restore it using `git reset --hard <commit_hash>` or branch off from it using `git branch recovery-branch <commit_hash>`.

---

## Practical Workflow Commands

```bash
# 1. Soft reset to fix commit message or add missing files
git reset --soft HEAD~1

# 2. Mixed reset to unstage files
git reset --mixed HEAD~1

# 3. Hard reset to discard all local uncommitted changes
git reset --hard HEAD~1

# 4. Safely revert a commit on a shared remote branch
git revert <commit_hash> --no-edit

# 5. Save uncommitted changes including untracked files
git stash push -u -m "wip: feature implementation"

# 6. List and pop stashed items
git stash list
git stash pop

# 7. Drop an unused stash item
git stash drop stash@{0}
