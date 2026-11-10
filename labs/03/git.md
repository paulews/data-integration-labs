# Lab 3 · Git

## Setup

```bash
git clone https://github.com/paulews/data-integration-labs.git
cd data-integration-labs
ls -a
git status
git remote -v
```

```text
./  ../  .git/  AI_USAGE.md  LICENSE  README.md  labs/

On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean

origin  https://github.com/paulews/data-integration-labs.git (fetch)
origin  https://github.com/paulews/data-integration-labs.git (push)
```

### How many commits, and where did I make them?

```bash
git log --oneline
```

```text
cd6271e (HEAD -> main, origin/main, origin/HEAD) Log AI use for Lab 1 Tasks 6-8
838be43 Complete dataset profile with real DB values (Lab 1 Tasks 5-8)
e5f6fae Add FAIR review of DWD dataset (Lab 1 Task 7)
d7ea708 Complete dataset profile for Lab 1 Task 6
c9fc154 Add data exploration for Lab 1 Task 6
bb4d357 Log AI use for Lab 2 Task 1 and Lab 1 Task 5
02c06f0 Add dataset search for Lab 1 Task 5
0b118af Rename 02/shell.md to labs/02/shell.md
3f2612f Add Lab 2 Task 1 shell answers
39ae7cb Log AI usage for task 4
6278a33 Add open source analysis of pandas
fc84eb1 Log AI usage for task 3
a9af1d6 Finish Markdown cheat sheet
fc8ebd3 Add Text and Lists to cheatsheet
bf8959a Add AI usage documentation
c9429ed Add lab 01 folder
2f99118 Write README
c0fbb1b Add MIT License
7173db5 Initial commit
```

My repository has 19 commits. I made all of them in the browser on GitHub, by creating, editing or uploading files.

### Commit messages written by GitHub

Most messages I wrote myself when committing in the browser. Two were written by GitHub:

| Commit | GitHub's message | Better message |
| --- | --- | --- |
| `7173db5` | Initial commit | Create lab repository with a README stub for the DIS 3.3 labs |
| `0b118af` | Rename 02/shell.md to labs/02/shell.md | Move shell answers into labs/02, where they belong; I uploaded them to the top level by mistake |

### Which e-mail address do my commits carry?

```bash
git log --format="%h %ae %s"
```

```text
cd6271e 166927456+paulews@users.noreply.github.com Log AI use for Lab 1 Tasks 6-8
…
7173db5 166927456+paulews@users.noreply.github.com Initial commit
```

All 19 commits carry my `noreply` address, so my real address is not public. Step 1 (*Keep my email addresses private* and *Block command line pushes that expose my email*) makes sure that future commits from my computer use this address too, and GitHub rejects a push that would publish my real address. It cannot change commits that were already pushed with a real address, because every clone already has them.

### Which files did I change most often?

```bash
git log --name-only --format="" | sort | uniq -c | sort -rn
```

```text
      5 labs/01/dataset.md
      5 AI_USAGE.md
      3 labs/01/cheatsheet.md
      2 README.md
      1 labs/02/shell.md
      1 labs/01/open-source.md
      1 LICENSE
      1 02/shell.md
```

I changed `labs/01/dataset.md` and `AI_USAGE.md` most often, five times each.

### My first commit from my computer

I moved `graph.md` and `git-graph.png` from Task 1 into `labs/03/`, added and committed them together with this file, and pushed.

```bash
git add labs/03
git commit -m "Add commit graph and setup notes for Lab 3 Tasks 1-2"
git status
git push
git status
```

Before the push:

```text
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
```

After the push:

```text
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

Before the push, my local `main` had one commit that GitHub did not have yet. After the push, both are at the same commit `314e18e`. My avatar is shown next to the commit on GitHub, because it carries my `noreply` address.

## Step by step

`git log --oneline -- .` in `labs/03`:

```text
68ea7a9 (HEAD -> main, origin/main, origin/HEAD) Fix Markdown formatting of the README
d207f71 Explain how to rebuild the raw data
e628ad1 Print a checksum of the downloaded file
11c8575 Explain where to run the script and where the data goes
21d2e6f Ignore raw data in lab 3
03bfe05 Copy the download script from lab 2
667a9b2 Add git status before and after first push
314e18e Add commit graph and setup notes for Lab 3 Tasks 1-2
```

My commit `adb826c Ignore raw data in lab 2` is missing here, because `-- .` only lists commits that changed something in this folder.

`git status --ignored` in `labs/03`:

```text
On branch main
Your branch is up to date with 'origin/main'.

Ignored files:
  (use "git add -f <file>..." to include in what will be committed)
        ../02/data/
        data/

nothing to commit, working tree clean
```

**Why does the `.gitignore` belong in the repository, but `data/raw/` does not?** The `.gitignore` is a small text file that everyone who clones the repository needs: without it, their raw data would show up in `git status` and could be committed by mistake. `data/raw/` is not our work but a copy of the DWD's data. Anyone can download it again with `get_data.sh`, and it changes every day, so every download would create a new version in Git for nothing.

**What does a teammate need to get my raw data?** A clone of the repository, a shell with `curl` and `unzip` (Git Bash has both) and internet access. Then `cd labs/03` and `./get_data.sh`, as the `README.md` explains. Since the DWD moves the *recent* file forward every day, they get a slightly different period than I did. The checksum at the end of the script shows whether two downloads are identical.

## Undo

### 1. Deleted by accident

```bash
rm get_data.sh
git status
git restore get_data.sh
```

```text
Changes not staged for commit:
        deleted:    get_data.sh
```

`git restore` brought the script back from the last commit, still executable. Git can only restore files it has stored in a commit. Everything in `data/raw/` is ignored, so Git has no copy of it: after an `rm` there, only `./get_data.sh` could bring the data back, and the old version of the *recent* file would be gone for good.

### 2. Staged by accident

```bash
echo "just a test" > notes.txt
git add .
git status
git restore --staged notes.txt
git status
rm notes.txt
```

```text
Changes to be committed:
        new file:   notes.txt
```

After `git restore --staged`:

```text
Untracked files:
        notes.txt
```

`git restore --staged` only took the file out of the staging area. It was still on disk (`ls` showed it) until I deleted it with `rm`.

### 3. A typo in the message

```bash
git commit -m "Add a sentnce about the course"
git log --oneline -3
git commit --amend -m "Add a sentence about the course"
git log --oneline -3
```

```text
dc7b301 (HEAD -> main) Add a sentnce about the course
994cba1 (origin/main, origin/HEAD) Add step by step notes for Lab 3 Task 3
68ea7a9 Fix Markdown formatting of the README
```

```text
ecda789 (HEAD -> main) Add a sentence about the course
994cba1 (origin/main, origin/HEAD) Add step by step notes for Lab 3 Task 3
68ea7a9 Fix Markdown formatting of the README
```

The hash changed from `dc7b301` to `ecda789`. The hash is computed from everything in the commit, including its message, so a new message means a new commit. `--amend` does not edit the old commit, it replaces it. That is only safe before a push: once the old commit is on GitHub, others may have built on it, and my history and theirs no longer match. Git would then refuse a normal push.

### 4. A bad commit, already pushed

```bash
git commit -m "Break the download URL on purpose"
git push
./get_data.sh
git revert --no-edit HEAD
./get_data.sh
git push
git log --oneline -3
```

```text
curl: (22) The requested URL returned error: 404
```

```text
6c8a883 (HEAD -> main, origin/main, origin/HEAD) Revert "Break the download URL on purpose"
1841f80 Break the download URL on purpose
ecda789 Add a sentence about the course
```

`git revert` added a new commit that undoes the broken one, and the script downloaded the data again. The broken commit stays in the history. That is the right way for a commit that is already pushed: history only grows, so GitHub and everyone who pulled it stay in sync. `git reset --hard HEAD~1` would move `main` back and throw the commit away on my computer only. GitHub would still have it, my next push would be refused, and with `--force` I would rewrite history that others may already have.

