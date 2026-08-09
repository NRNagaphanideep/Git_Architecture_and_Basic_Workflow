# Comprehensive Markdown (.md) Syntax Reference Guide
## Table of Contents

1. [Headings](#1-headings)
2. [Text Formatting](#2-text-formatting)
3. [Lists](#3-Lists)
4. [Code Blocks $ Inline Code](#4-code-blocks--inline-code)
5. [Links & Images](#5-links-imagees)
6. [Blockquotes & Callouts](#6-blockquotes--callouts)
7. [Tables](#7-tables)
8. [Task Lists](#8-taks-lists)
9. [Escaping Special Characters](#9-escaping-special-characters)
10.[Horizontal Rules](#10-horizontal-rules)

-----
## 1. Headings
Use '#' followed by a space to create section headings. The number of '#' symbols controls the size (1 to 6).

'''markdown

# Heading 1 (Dcoument Title)
## Heading 2 (Major Sections)
### Heading 3 (Sub-sections)
#### Heading 4 (Minor Sub-sections)
##### Heading 5
###### Heading 6
------

## 2. Text Formatting 
## Enhance readability using symbols for bold, italics, strikethrough and highlighting.

*This text will be italic*
_This text will also be italic_

**This text will be bold**
__This text will also be bold__

***This text will bold and italic***

~~This text will have a strikethrough~~

-----

### 3. Lists

You can create Ordered, unorderd or nestedlists.

__Unordered lists__

Use *,-,or+ followed by a space.

* Linux Basics
* Git & GitHub
    * Branching Strategies
    * Reset vs Revert
* Docker & Containers

__Ordered Lists__

Use numbers followed by a period.

1. Install Git
2. Configure username and email
3. Clone remote repository.

#### 4. Code Blocks & Inline Code

Use backticks(````) to hightlight code snippets.

__Inline Code__

Use single backticks for commands within regular sentences:

Run `git status` to check the current state of your repository.

__Multiline Code Blocks

Use tripe backticks (```) and specify the language name for color syntax highlighting.

```bash
# Bash script example
git checkout -b feature/login
git add .
git commit -m "feat: setup login UI"
git push origin feature/login
```

```python
# Python script example
def calculate_uptime(days):
    hours = day * 24
    return f"Total Uptime: {hours} hours"
print(calculate_uptime(30))
```


##### 5. Links & Images

Format links and render external images easily.

<!-- Links: [Link Text](URL) -->
Visit my GitHub Profile: [NRNagaphanideep](https://github.com/NRNagaphanideep)

<!-- Images: ![Alt Text](Image_URL) -->
![Git logo](https://git-scm.com/images/logos/downloads/Git-Logo-2Color.png)

###### 6 Blockquotes & Callouts

Use > to create blockquotes for tips,notes or warnings.

> **Note:** Always inspect `git status` before executing a reset or commit command.

> **Warning:** `git reset --hard` completely wipes uncommitted working directory changes!>

###### 7 Tables

Organize structured data using pipe | symbols and hyphen- dividers.

| Command | Primary Scope | Preserves Uncommitted Changes? |
| :--- | :--- | :--- |
| `git reset --soft` | Local Commits | Yes (In Staging Area) |
| `git reset --mixed` | Local Commits | Yes (In Working Directory) |
| `git reset --hard` | Local Commits | No (Completely Discarded) |
| `git revert` | Remote/Public Commits | Yes (Creates Inverse Commit) |

###### 8. Task Lists

Create interactive checkboxes in GitHub issue descriptions or markdown files.

- [x] Master Git Reset modes
- [x] Practice Git Stash workflow
- [ ] Learn Branching Strategies (Day 19)
- [ ] Hands-on Merge Conflict Resolution (Day 21)

##### 9. Escaping Special Characters

If you want to display Markdown symbols (like #,*or`) as literal text without triggering formatting, use a backslash \.

\# This is literal text, not a Heading.
\*This is literal text, not italicized.\*

###### 10. Horizontal Rules

Separate major document sections using three or more hyphens --- or asterisks ***

Section Above

---

Section Below

------

