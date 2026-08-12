omprehensive Git Commands Guide

## 1. Local Workspace Commands
These commands operate exclusively on your local machine. They do not interact with GitHub or any remote server.

### Workspace Setup & Tracking
* **`git init`**  
  Initializes a new, empty Git repository in your current local directory. Creates the hidden `.git` folder.
* **`git status`**  
  Displays the state of your working directory and staging area. Shows untracked, modified, or staged files.
* **`git add <file-name>`**  
  Moves a specific modified or new file to the Staging Area (Index).
* **`git add .`**  
  Moves all new, modified, and deleted files in the current directory to the Staging Area at once.

### Committing & History
* **`git commit -m "commit message"`**  
  Saves a snapshot of your staged files into the local Git repository history with a descriptive message.
* **`git log`**  
  Displays the commit history log, showing Commit IDs (hashes), author info, dates, and messages.
* **`git log --oneline`**  
  Displays a simplified, one-line summary per commit for quicker scanning.

### Branching & Merging
* **`git branch`**  
  Lists all local branches in your repository. The active branch is highlighted with an asterisk (`*`).
* **`git branch <branch-name>`**  
  Creates a new branch at the current commit point without switching to it.
* **`git checkout <branch-name>`** or **`git switch <branch-name>`**  
  Switches your current working workspace to the specified branch.
* **`git checkout -b <branch-name>`** or **`git switch -c <branch-name>`**  
  Creates a new branch and immediately switches to it.
* **`git merge <branch-name>`**  
  Merges changes from the specified branch into your current active branch.

---

## 2. Local to GitHub Commands (Local ➔ GitHub)
These commands connect your local machine to GitHub and push your local commits to the cloud.

### Connecting Local to Remote
* **`git remote add origin <remote-url>`**  
  Links your local repository to a remote GitHub repository URL and assigns it the default nickname `origin`.
* **`git remote -v`**  
  Lists all remote connections along with their URLs for both `fetch` and `push` operations.
* **`git remote set-url origin <new-remote-url>`**  
  Modifies the URL of an existing remote reference (`origin`). Used when switching repositories or updating from HTTPS to SSH.

### Uploading Changes
* **`git push -u origin <branch-name>`**  
  Uploads local commits to the remote repository branch and sets up upstream tracking (`-u`). Upstream tracking allows you to use shorthand `git push` in subsequent updates.
* **`git push`**  
  Uploads local commits to the tracked remote repository branch using existing upstream configuration.
* **`git push --force`**  
  Overwrites the remote repository history with your local branch history. *(Use with caution in collaborative environments).*

---

## 3. GitHub to Local Commands (GitHub ➔ Local)
These commands fetch, download, or sync data from GitHub to your local workspace.

### Downloading & Syncing
* **`git clone <remote-url>`**  
  Downloads an existing remote repository from GitHub to your local machine, initializing a new directory with full commit history.
* **`git fetch`**  
  Downloads new commits, files, and refs from the remote repository without merging them into your local workspace files. Allows safe inspection.
* **`git pull`**  
  Downloads changes from the remote repository and immediately merges them into your current local branch (`git fetch` + `git merge`).

---

## 4. Maintenance & Removal Commands
These commands help clean up workspace state, remove tracking, or resolve conflicts.

### Unlinking & Removing Tracking
* **`git remote remove origin`**  
  Deletes the connection/link to the remote GitHub repository from your local configuration without deleting any code files.
* **`git rm <file-name>`**  
  Removes a file from both your working directory and Git tracking.
* **`git rm -r *`**  
  Recursively removes all files and folders in the current directory from Git tracking.

### Resolving Conflicts & Discarding Changes
* **`git checkout -- <file-name>`**  
  Discards local uncommitted changes in a specific file, reverting it back to the last committed state.
* **`git checkout --ours <file-name>`**  
  During a merge conflict, keeps your local version of the specified file and discards incoming remote changes.
* **`git checkout --theirs <file-name>`**  
  During a merge conflict, keeps the incoming remote version of the specified file and discards local changes.
* **`git merge origin/main --allow-unrelated-histories`**  
  Forces Git to merge two branches that do not share a common commit history (useful when syncing independently initialized repositories).
