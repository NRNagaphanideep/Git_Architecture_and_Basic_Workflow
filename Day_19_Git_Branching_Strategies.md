# Day 19: Git Branching Strategies and Management

## Table of Contents
- [Overview](#overview)
- [Branching Strategies Comparison](#branching-strategies-comparison)
  - [1. Trunk-Based Development](#1-trunk-based-development)
  - [2. Feature Branching](#2-feature-branching)
  - [3. GitFlow](#3-gitflow)
- [Essential Git Branching Commands](#essential-git-branching-commands)
- [Command Flags Breakdown (-b, -c, -d)](#command-flags-breakdown--b--c--d)
- [Practical Hands-On Workflow](#practical-hands-on-workflow)
- [Interview Questions & Answers](#interview-questions--answers)

---

## Overview

Branching is one of Git's most fundamental capabilities, allowing developers and DevOps engineers to isolate new features, bug fixes, and experiments from the primary production codebase (`main`). Selecting the right branching strategy ensures smooth team collaboration, minimal merge friction, and predictable deployment pipelines.

---

## Branching Strategies Comparison

| Strategy | Ideal Team Size & Speed | Key Workflow Characteristics | Best Suited For |
| :--- | :--- | :--- | :--- |
| **Trunk-Based Development** | Fast-moving, CI/CD mature teams | Short-lived branches merged directly into `main` daily or multiple times a day. | Startups, SaaS platforms, high-velocity DevOps teams |
| **Feature Branching** | Agile teams (Medium to Large) | Dedicated branches created per user story/ticket (`feature/*`). Merged via Pull Requests (PRs) after code review. | Standard software development teams, Scrum/Kanban setups |
| **GitFlow** | Enterprise teams with strict release cycles | Multiple persistent long-lived branches (`main`, `develop`, `feature/*`, `release/*`, `hotfix/*`). | Enterprise software, regulated industries, scheduled release cycles |

### 1. Trunk-Based Development
* **Concept:** Developers work in very short-lived feature branches or commit directly to a shared `main` branch ("trunk").
* **Pros:** Minimizes merge conflicts, enables fast Continuous Integration & Continuous Delivery (CI/CD).
* **Cons:** Requires high automated test coverage and strong team discipline.

### 2. Feature Branching
* **Concept:** Every task or user story receives its own isolated branch (e.g., `feature/login-page`).
* **Pros:** Keeps untested code away from production; allows thorough code reviews via Pull Requests.
* **Cons:** Longer-lived feature branches can accumulate complex merge conflicts over time.

### 3. GitFlow
* **Concept:** A strict, production-oriented model with strict branch roles:
  * `main`: Represents official production-ready release history.
  * `develop`: Serves as an integration branch for ongoing features.
  * `feature/*`: For individual features branching off `develop`.
  * `release/*`: For preparing and polishing new production releases.
  * `hotfix/*`: For emergency fixes directly applied to `main`.

---

## Essential Git Branching Commands

```bash

# List local branches (* indicates currently active branch)
git branch

# Create and switch to a new branch (Legacy Method)
git checkout -b feature/login

# Switch to an existing branch (Modern Preferred Method)
git switch main

# Create and switch to a new branch (Modern Preferred Method)
git switch -c feature/payment

# Safely delete a fully merged local branch
git branch -d feature/login

# Force delete a local branch regardless of merge status
git branch -D feature/experimental


### Command Flags Breakdown (-b, -c, -d)

-b (Branch - used with git checkout): Tells Git to create the branch first before checking it out.

-c (Create - used with git switch): Modern equivalent of -b for the newer git switch interface.

-d (Delete Safe): Deletes a local branch only if its changes have already been safely merged into the target branch.


Interview Questions & Answers
Q1: What is the difference between git checkout -b and git switch -c?
Answer: Both commands perform the exact same task: creating a new branch and immediately switching to it. However, git switch was introduced in Git 2.23 to separate branch management from file restoration (which git checkout previously handled both). git switch -c is the modern, recommended standard.

Q2: Why should feature branches be short-lived in a CI/CD environment?
Answer: Long-lived feature branches drift significantly from the primary codebase (main), leading to severe merge conflicts, difficult code reviews, and delayed integration. Keeping branches short-lived (Trunk-Based approach) promotes continuous integration and faster feedback loops.

Q3: What happens when you run git branch -d on an unmerged branch?
Answer: Git blocks the deletion and throws an error warning that the branch contains unmerged changes. This safety mechanism prevents accidental data loss. To force deletion, you must explicitly use git branch -D.
