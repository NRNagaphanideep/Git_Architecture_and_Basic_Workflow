# Day 20: Git Merging vs. Rebasing

## Table of Contents
- [Overview](#overview)
- [Git Merging Strategies](#git-merging-strategies)
  - [1. Fast-Forward Merge](#1-fast-forward-merge)
  - [2. 3-Way Merge](#2-3-way-merge)
- [Git Rebasing (`git rebase`)](#git-rebasing-git-rebase)
- [Merging vs. Rebasing Comparison](#merging-vs-rebasing-comparison)
- [The Golden Rule of Rebasing](#the-golden-rule-of-rebasing)
- [Practical Hands-On Workflow](#practical-hands-on-workflow)
- [Interview Questions & Answers](#interview-questions--answers)

---

## Overview

In collaborative software development and DevOps environments, combining work from different feature branches back into the main branch (`main`) is a daily operation. Git provides two primary mechanisms to integrate changes: **Merging** (`git merge`) and **Rebasing** (`git rebase`). Understanding the core differences between these two approaches is essential for maintaining a clear, auditable repository commit history.

---

## Git Merging Strategies

When running `git merge <feature-branch>`, Git determines the integration strategy based on the commit history of both branches.

### 1. Fast-Forward Merge
* **Condition:** The target branch (`main`) has no new commits since the feature branch was created.
* **Mechanism:** Git simply moves the pointer of the target branch forward to the tip of the feature branch.
* **Outcome:** No new merge commit is created; the history remains linear.

### 2. 3-Way Merge
* **Condition:** Both the target branch (`main`) and the feature branch have diverged with new commits on both sides.
* **Mechanism:** Git compares three points in history: the common ancestor commit, the latest commit on `main`, and the latest commit on the feature branch.
* **Outcome:** Git automatically creates a dedicated **Merge Commit** tying the two branches together.

---

## Git Rebasing (`git rebase`)

Rebasing is an alternative integration method where Git takes the commits from a feature branch and "replays" them on top of the latest commit of another branch (e.g., `main`).

* **Mechanism:** Git temporarily detaches the feature branch commits, updates the base of the feature branch to match the head of `main`, and applies each feature commit sequentially.
* **Outcome:** Rewrites the commit history to produce a completely linear, single-branch log with no merge commits.

---

## Merging vs. Rebasing Comparison

| Feature | `git merge` | `git rebase` |
| :--- | :--- | :--- |
| **Commit History** | Preserves true chronological history (Non-linear) | Creates a continuous, straight line (Linear) |
| **Merge Commits** | Generates merge commits on diverged branches | Eliminates merge commits entirely |
| **Safety** | Non-destructive (does not alter existing commit hashes) | Rewrites history (generates new commit SHA-1 hashes) |
| **Conflict Resolution** | Resolves all conflicts at once during the merge commit | Resolves conflicts sequentially, commit-by-commit |

---

## The Golden Rule of Rebasing

> **Never rebase public or shared branches!**

Only rebase local feature branches that exist exclusively on your personal development environment. Rebasing shared branches like `main` or `develop` rewrites history for all team members, causing severe synchronization issues and duplicated commits across the team.

---

## Practical Hands-On Workflow

### Part 1: Fast-Forward Merge Demo
```bash
# 1. Ensure you are on main
git switch main

# 2. Create a demo feature branch
git switch -c ff-demo

# 3. Create a commit
echo "FF change" > ff.txt
git add ff.txt
git commit -m "feat: fast-forward demo commit"

# 4. Merge back into main
git switch main
git merge ff-demo

Part 2: Rebasing Demo

``` bash
# 1. Create a feature branch
git switch -c rebase-demo
echo "Feature work" > feature.txt
git add feature.txt
git commit -m "feat: work on rebase demo"

# 2. Simulate parallel work on main
git switch main
echo "Hotfix on main" > hotfix.txt
git add hotfix.txt
git commit -m "fix: urgent update on main"

# 3. Rebase the feature branch onto main
git switch rebase-demo
git rebase main

# 4. View clean linear commit log
git log --oneline --graph
```
# Interview Questions & Answers
---
__Q1__: What is the main disadvantage of using git rebase over git merge?
__Answer__: git rebase rewrites history by generating new commit hashes for moved commits. If done on shared or public branches, it disrupts the commit history for other developers on the team, causing merge conflicts and commit duplication.

__Q2__: How does a Fast-Forward merge differ from a 3-Way merge?
__Answer__: A Fast-Forward merge occurs when the base branch has no new commits since the feature branch diverged, allowing Git to simply advance the branch pointer without creating a merge commit. A 3-Way merge occurs when both branches have diverged with new commits, requiring Git to create a new merge commit.

__Q3__: When should a DevOps engineer choose git rebase in their workflow?
__Answer__: A developer should use git rebase main on their local, private feature branch to incorporate the latest updates from main before submitting a Pull Request (PR). This ensures a clean, linear, and easily reviewable history.
