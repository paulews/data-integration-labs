\# Lab 3 · Git



\## Setup



```bash

git clone https://github.com/paulews/data-integration-labs.git

cd data-integration-labs

ls -a

git status

git remote -v

```



```text

./  ../  .git/  AI\_USAGE.md  LICENSE  README.md  labs/



On branch main

Your branch is up to date with 'origin/main'.



nothing to commit, working tree clean



origin  https://github.com/paulews/data-integration-labs.git (fetch)

origin  https://github.com/paulews/data-integration-labs.git (push)

```



\### How many commits, and where did I make them?



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



\### Commit messages written by GitHub



Most messages I wrote myself when committing in the browser. Two were written by GitHub:



| Commit | GitHub's message | Better message |

| --- | --- | --- |

| `7173db5` | Initial commit | Create lab repository with a README stub for the DIS 3.3 labs |

| `0b118af` | Rename 02/shell.md to labs/02/shell.md | Move shell answers into labs/02, where they belong; I uploaded them to the top level by mistake |



\### Which e-mail address do my commits carry?



```bash

git log --format="%h %ae %s"

```



```text

cd6271e 166927456+paulews@users.noreply.github.com Log AI use for Lab 1 Tasks 6-8

…

7173db5 166927456+paulews@users.noreply.github.com Initial commit

```



All 19 commits carry my `noreply` address, so my real address is not public. Step 1 (\*Keep my email addresses private\* and \*Block command line pushes that expose my email\*) makes sure that future commits from my computer use this address too, and GitHub rejects a push that would publish my real address. It cannot change commits that were already pushed with a real address, because every clone already has them.



\### Which files did I change most often?



```bash

git log --name-only --format="" | sort | uniq -c | sort -rn

```



```text

&#x20;     5 labs/01/dataset.md

&#x20;     5 AI\_USAGE.md

&#x20;     3 labs/01/cheatsheet.md

&#x20;     2 README.md

&#x20;     1 labs/02/shell.md

&#x20;     1 labs/01/open-source.md

&#x20;     1 LICENSE

&#x20;     1 02/shell.md

```



I changed `labs/01/dataset.md` and `AI\_USAGE.md` most often, five times each.



