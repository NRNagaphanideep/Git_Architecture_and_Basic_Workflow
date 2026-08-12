# Day 22: Authentication & Remote Setup – Study Guide

## 1. Core Concepts
- **SSH (Secure Shell):** Cryptographic network protocol used for secure communication between a local machine and remote servers (e.g., GitHub, AWS).
- **Public & Private Keys:** 
  - `id_ed25519` (Private Key): Stored locally on the user's machine, never shared.
  - `id_ed25519.pub` (Public Key): Uploaded to remote servers/GitHub for identity verification.

---

## 2. Step-by-Step Hands-on Setup

### Step 1: Generate SSH Key (Ed25519 Algorithm)
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

### Step 2: Retrieve Public Key & Add to GitHub
```bash
cat ~/.ssh/id_ed25519.pub
```
*Copy the output and add it under **GitHub -> Settings -> SSH and GPG Keys -> New SSH Key**.*

### Step 3: Verify SSH Authentication
```bash
ssh -T git@github.com
```
*Expected Output:* `Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.`

### Step 4: Link Local Repo to Remote GitHub
```bash
git remote add origin git@github.com:<username>/<repo-name>.git
git remote -v  # Verify remote URLs
```

### Step 5: Push Changes to Remote
```bash
git push -u origin main
```
*-u flag sets the upstream tracking branch permanently for local main.*

---

## 3. Remote Commands Deep-Dive
- **`git fetch`:** Downloads new commits from remote without modifying local working directory (100% Safe).
- **`git pull`:** Downloads and immediately merges remote changes into the current working branch (`git fetch` + `git merge`).

---

## 4. Top Interview Questions & Answers

### Q1: Why is Ed25519 preferred over RSA for generating SSH keys?
**Ans:** Ed25519 provides higher security with smaller key sizes, faster performance, and better resilience against cryptographic vulnerabilities compared to traditional RSA.

### Q2: What is the purpose of the `-u` flag in `git push -u origin main`?
**Ans:** The `-u` (or `--set-upstream`) flag establishes a tracking link between local `main` and remote `origin/main`. Future pushes and pulls can be executed with just `git push` or `git pull`.

### Q3: What is the key difference between `git fetch` and `git pull`?
**Ans:** `git fetch` safely downloads remote data into origin branches without altering local code. `git pull` downloads and automatically merges those changes, which can trigger conflicts immediately.

### Q4: What happens if you try to push without configuring an SSH key or token?
**Ans:** GitHub rejects the connection with an authentication error (`Permission denied (publickey)`).

### Q5: How do you change an existing remote URL from HTTPS to SSH?
**Ans:** Execute: `git remote set-url origin git@github.com:<username>/<repo-name>.git`
