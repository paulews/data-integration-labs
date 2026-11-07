# Lab 2: Shell Basics

## 1. Which shell?

```bash
echo $0
bash --version
```

```
/usr/bin/bash
GNU bash, version 5.3.15(2)-release (x86_64-pc-cygwin)
Copyright (C) 2025 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```

Answer: My terminal runs GNU Bash version 5.3.15, which comes with Git Bash (Git for Windows) and is built on a Cygwin-based layer.

---

## 2. Where am I?

```bash
cd ~
pwd
cd ~/Downloads
pwd
cygpath -w "$(pwd)"
```

```
/c/Users/paule
/c/Users/paule/Downloads
C:\Users\paule\Downloads
```

Answer: My home directory is `/c/Users/paule` and my downloads folder is `/c/Users/paule/Downloads`; File Explorer shows the same folder as `C:\Users\paule\Downloads`, so Git Bash only writes the drive letter as `/c/` and uses `/` instead of `\`.

---

## 3. Where do commands come from?

```bash
echo $PATH | tr ":" "\n" | wc -l
echo $PATH | tr ":" "\n" | head -n 1
which curl python3 git
git --version
```

```
37
/c/Users/paule/bin
/ucrt64/bin/curl
/c/Users/paule/AppData/Local/Microsoft/WindowsApps/python3
/ucrt64/bin/git
git version 2.56.0.windows.4
```

Answer: My `PATH` has 37 entries and `/c/Users/paule/bin` is searched first; `curl` and `git` (version 2.56.0) are installed in `/ucrt64/bin` by Git for Windows, while `python3` only points to the Microsoft Store placeholder in `WindowsApps`.

---

## 4. How full is my disk?

```bash
df -h ~
du -sh ~/Downloads
```

```
Filesystem      Size  Used Avail Use% Mounted on
C:              929G  552G  377G  60% /c

19G     /c/Users/paule/Downloads
```

Answer: Drive C: has 377 GB free out of 929 GB (60 % used), and my downloads take up 19 GB.

---

## 5. Stop a runaway process

First window:

```bash
sleep 600
```

Second window:

```bash
ps -ef | grep sleep
kill 365
```

```
paule     365     200 pty0     16:50:46 sleep 600
```

First window after `kill 365`:

```
Terminated                 sleep 600
```

Answer: After `kill 365` the first window showed `Terminated` and the prompt came back. Normally `ps aux | grep sleep` lists two processes because `grep sleep` itself is running at the same moment and its own command line contains the word "sleep"; in Git Bash this second line did not appear, probably because its `ps` shows only program names and not their arguments.
