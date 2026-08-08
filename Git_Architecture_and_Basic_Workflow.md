# Phase 2 - Day 16: Git Core Architecture & Basic Workflow

## 1. Core Concepts & Definitions

### What is Version Control System (VCS)?
A Version Control System (VCS) is a tool that tracks changes to files over time so that you can recall specific versions later, recover lost code, and collaborate safely.

### What is Git?
Git is a **Distributed Version Control System (DVCS)** installed locally on your computer. It tracks changes in your code locally without needing an active internet connection.

### What is GitHub?
GitHub is a **Cloud-based platform** that hosts Git repositories online. It allows developers to backup local Git repositories to the cloud and collaborate with teams remotely.

---

## 2. Git Core Architecture (The 3 Trees / States)

Git manages files through three primary areas:

1. **Working Directory:** The local folder where you create, edit, or delete project files. Files here are either **Untracked** or **Modified**.
2. **Staging Area (Index):** A intermediate holding area (like a shopping cart) where you prepare selected changes before saving them permanently.
3. **Local Repository (`.git`):** Git's local database that permanently stores the committed snapshots (history) of your project.

---

## 3. Fundamental Git Commands

* `git init`: Initializes a new empty Git repository and creates a hidden `.git` folder.
* `git status`: Displays the state of the Working Directory and Staging Area (shows untracked, modified, or staged files).
* `git add <filename>`: Moves a file from the Working Directory to the Staging Area.
* `git add .`: Stages all modified and untracked files in the current directory.
* `git commit -m "message"`: Saves staged snapshots permanently into the Local Repository.
* `git diff`: Shows exact line-by-line differences between the Working Directory and Staging Area / Local Repo (`+` for additions, `-` for deletions).

---

## 4. Conventional Commit Prefixes (Industry Standards)

Using standardized prefixes in commit messages keeps the repository history clean and professional:

* `feat:` (Feature) - Used when adding a new feature or file (e.g., `feat: add login page`).
* `fix:` (Bug Fix) - Used when fixing a bug or error in code (e.g., `fix: resolve crash on click`).
* `docs:` (Documentation) - Used when updating documentation or text files (e.g., `docs: update setup guide`).
* `style:` (Formatting) - Used for formatting, spaces, or CSS changes that do not affect code logic.
* `refactor:` (Code Refactoring) - Restructuring existing code without changing its external behavior.
* `test:` (Testing) - Adding or updating test cases.

---

## 5. Variations of `git log` Explained

| Command | Hash Length | Shows Author/Date? | Shows All Branches? | Displays Visual Graph? | Use Case |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `git log` | Full (40 chars) | Yes | No (Current branch) | No | Detailed audit of commit author and exact timestamp. |
| `git log --oneline` | Short (7 chars) | No | No (Current branch) | No | Quick, compact overview of past commits. |
| `git log --oneline --graph` | Short (7 chars) | No | No (Current branch) | **Yes** | Displays commit history along with branch splitting/merging lines. |
| `git log --oneline --graph --all` | Short (7 chars) | No | **Yes (All branches)** | **Yes** | Complete map of all commits across every branch in the entire repository. |

---

## 6. Key Edge Cases & Learnings

* **Sub-folder Tracking:** If a directory is initialized with `git init`, all nested sub-directories created inside it are automatically tracked by Git without re-initializing.
* **New Projects:** Moving outside the initialized Git repository requires running `git init` in the new folder to start tracking.
* **Selective Staging:** Staging specific files (`git add file1.py`) allows committing completed work while leaving incomplete files safely in the Working Directory.
1. Standard git log (Detailed View)
What it does: Shows every single detail about your commits (Full 40-character SHA hash, Author name, Author email, Date, Time, and the full Commit Message).

When to use: When you need to know who made a change and exactly when it happened.

Drawback: Takes up a massive amount of screen space. Viewing 10 commits requires heavy scrolling.
2. git log --oneline (Condensed View)
What it does: --oneline truncates the 40-character hash into a 7-character short hash, removes the author name and timestamp, and collapses each commit into one single line.

When to use: When you want a quick, clean list of past commits without filling up your screen.
3. git log --oneline --graph (Visual History View)
What it does: Adds a text-based ASCII graph (*, |, /, \) on the left side of the single-line logs.

When to use: When you start working with Branches (which we cover in Days 19–21). It visually shows where branches split off and where they merged back together.
4. git log --oneline --graph --all (Complete Repository Map)
What it does:

--oneline: Keeps it compact.

--graph: Draws the branch lines.

--all: Shows commits across ALL branches, not just the active branch you are currently standing on.

