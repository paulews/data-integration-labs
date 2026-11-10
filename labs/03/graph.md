# Lab 3 · Task 1: Predict, then run

Tool: [Visualizing Git](https://git-school.github.io/visualizing-git). The tool calls the main branch `master`; read it as `main`.

## Round 1 · A straight line

```text
git commit -m "Download the data"
git checkout -b clean
git commit -m "Drop empty rows"
git commit -m "Parse dates"
git checkout master
git merge clean
```

**Prediction:** A commit "Download the data" is made. `git checkout -b clean` puts a second branch `clean` on the same commit, and `HEAD` moves to `clean`. The two next commits each point to the one before and only move `clean` forward; `master` stays at "Download the data". After `git checkout master`, `HEAD` is on `master` again. Because `clean` is just ahead of `master` on the same line, `git merge clean` can simply move `master` forward. No commit has two parents.

**Answers:**

1. Did `git merge clean` create a new commit? No.
2. What did the tool answer? "You have performed a fast-forward merge."
3. Where do `master` and `clean` point now? Both point to the same commit, "Parse dates", and `HEAD` is on `master`.

## Round 2 · Two lines meet

```text
git checkout -b plot
git commit -m "Plot cyclists per month"
git checkout master
git commit -m "Describe the data in the README"
git merge plot
git tag v1.0
```

**Prediction:** `git checkout -b plot` creates a branch `plot` on "Parse dates" and moves `HEAD` there. "Plot cyclists per month" is attached to "Parse dates" and moves `plot`. After `git checkout master`, the commit "Describe the data in the README" moves `master`, while `plot` stays behind. Now two lines split from "Parse dates", so `git merge plot` must join them with a new merge commit. `git tag v1.0` puts a fixed label on the commit where `master` is, the merge commit; it stays there when `master` moves on.

**Answers:**

1. Which commit has two parents? The merge commit created by `git merge plot`. Its parents are "Describe the data in the README" (from `master`) and "Plot cyclists per month" (from `plot`).
2. Why was this merge not a fast-forward? After the split, `master` and `plot` each had a new commit of their own, so `master` could not simply be moved forward to `plot` without losing "Describe the data in the README". Git had to create a merge commit.
3. What would a tag like `v1.0` mark in your project? A fixed state of the whole project that we want to find again exactly, for example the state we hand in for a milestone such as our roadmap.

## Round 3 · Two ways back

```text
git commit -m "Delete outliers"
git revert HEAD
git reset HEAD~2
```

**Prediction:** "Delete outliers" is attached to the merge commit and moves `master`. `git revert HEAD` undoes it by adding a new commit on top that does the opposite; `master` moves forward to it. `git reset HEAD~2` moves `master` two commits back, to the merge commit, without creating a new commit.

**Answers:**

1. What did `git revert HEAD` add, and what did `git reset HEAD~2` change? `git revert HEAD` added a new commit that undoes "Delete outliers"; both commits stay in the history. `git reset HEAD~2` added nothing but moved `master` (and `HEAD`) two commits back to the merge commit `v1.0`.
2. Are the dashed commits gone? No. "Delete outliers" and the revert commit still exist, but no branch points to them any more, so they are drawn with dashed lines. They can still be reached by their hash (or through `git reflog`) until Git cleans them up some time later.
3. Which command may you use for commits that you have already pushed, and why? Only `git revert`. It adds a new commit, so the history that others have already pulled stays the same. `git reset` rewrites the history: the reset commits would still exist on GitHub and in the copies of my teammates, so I could only push with `--force` and would break their work.

## Round 4 · Lost and found

```text
git checkout v1.0~1
git commit -m "Try a log scale"
git checkout master
git reflog
git branch logscale b26e937
```

**Prediction:** `v1.0~1` is the first parent of the merge commit, "Describe the data in the README". `git checkout` puts `HEAD` directly on this commit, not on a branch. The new commit "Try a log scale" is attached to it, but no branch moves with it, only `HEAD`. After `git checkout master`, no branch points to "Try a log scale" any more. `git reflog` lists every move of `HEAD`, so the lost commit can be found there.

**Answers:**

1. What does the line above the graph say after `git checkout v1.0~1`? "HEAD: (detached head)". `HEAD` points directly to a commit (`119c913`, "Describe the data in the README") and not to a branch.
2. What happens to *Try a log scale* when you switch back to `master`? No branch points to it, so it is drawn with a dashed line. It still exists, but without its hash I could not find it again.
3. Its hash in `git reflog`: the newest entry says `checkout: moving from b26e937 to master`, and the entry before it is the commit. So *Try a log scale* is `b26e937`, and `git branch logscale b26e937` keeps it on a new branch.

Screenshot of the whole graph: `git-graph.png`.
