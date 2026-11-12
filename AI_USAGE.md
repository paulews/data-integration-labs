# AI Usage

## 2026-10-28/29 · Lab 01, Tasks 1–2

- **Tool and model:** Claude (Anthropic), Claude Opus 5.5
- **Prompt:** Asked for step-by-step guidance to set up my GitHub profile README and lab repository, and for draft Markdown for both READMEs.
- **Accepted / changed / rejected:** Used the drafted READMEs as a starting point and changed name, study programme and interests. Claude also drafted this log entry and suggested commit messages. Rejected a Copilot-suggested commit description that did not match my change.
- **How I checked it:** Compared every step with the lab instructions and checked the rendered result in the Preview tab and on my profile page.

## 2026-10-29/31 · Lab 01, Task 3

- **Tool and model:** Claude (Anthropic), Claude Opus 5.5
- **Prompt:** Asked how individual Markdown features work (code blocks, inline code, nested lists, line breaks) and for feedback on my cheat sheet. Claude also wrote a complete draft of the cheat sheet.
- **Accepted / changed / rejected:** Wrote the first entries myself, then used Claude's draft as the basis for the rest and typed it into my file. Claude formulated the pitfalls from the problems I ran into, and pointed out missing parts and errors.
- **How I checked it:** Tested the whole cheat sheet in the CommonMark dingus and on GitHub, set the CommonMark/GitHub labels from what I saw, and checked unclear cases in the dingus HTML tab.

## 2026-11-07 · Lab 01, Task 4

- **Tool and model:** Claude (Anthropic), Claude Opus 5.5
- **Prompt:** Asked which project to choose and where to find each answer, and shared what I found.
- **Accepted / changed / rejected:** I collected most facts myself on GitHub (licence, API results, community files, contributors, latest release, open issues and pull requests, good first issues). For governance, sponsors and the contributing process, Claude pointed me to the pages and summarised them. Claude phrased the sections in English; I accepted the wording.
- **How I checked it:** Opened the governance, sponsors and contributing pages and the co2-data README myself and checked every statement against them.

## 2026-11-07 · Lab 02, Task 1

- **Tool and model:** Claude (Anthropic), Claude Opus 5.5
- **Prompt:** Asked how to read the output of some commands (`ps -ef`, `kill`, `cygpath`) and for feedback on my `shell.md`.
- **Accepted / changed / rejected:** I ran all commands in Git Bash on my own PC, collected the outputs and wrote a first version with all answers. Claude then polished it: code blocks for commands and outputs, my home path in Q2, `git --version` in Q3, and the reason why `grep` usually lists itself in Q5.
- **How I checked it:** All outputs come from my own terminal; I compared every answer with them.

## 2026-11-09 · Lab 01, Task 5

- **Tool and model:** Claude (Anthropic), Claude Opus 5.5
- **Prompt:** Asked where to search for hourly weather data for Cologne, how to read the GovData API answer, and which of my hits is the original source.
- **Accepted / changed / rejected:** I ran all searches myself (GovData, Offene Daten Köln, Google Dataset Search, the API query) and wrote a first version of the section. Claude explained the `title` and `license` fields, pointed out that the EDDK hit on data.europa.eu is probably a forecast and not measured data, gave me the links to the DWD Climate Data Center, and rewrote the section.
- **How I checked it:** Every search term and result in the table is from my own searches; I opened the API answer and the DWD links myself.

## 2026-11-09 · Lab 01, Tasks 6–8

- **Tool and model:** Claude (Anthropic), Claude Opus 5.5
- **Prompt:** Asked how to download and open the DWD data, how to import it correctly into Excel, how to read the DB data with pandas, and for help writing the profile, the FAIR review and the combination plan.
- **Accepted / changed / rejected:** I downloaded the DWD and DB data myself (Git Bash, `curl`), opened the DWD file in Excel and calculated min, max, mean and missing values, read the DB file with pandas, filtered it to Köln Hbf and picked the example values for the key table. I looked up the licence, last update and description file on the DWD website and checked for a DOI and for the dataset on data.europa.eu. Claude explained the commands and the Excel import (decimal point, encoding), pointed out the odd things in the data (`-999`, UTC, Latin-1), and wrote most of the text of Tasks 6–8: the facts table, stars, data dictionary, licence, FAIR table and combination plan. Claude first wrote Task 8 with made-up example times; I replaced them with real DB values. I wrote the verdict of Task 8 myself, Claude made two small changes.
- **How I checked it:** All numbers come from my own Excel sheet and Python session. I compared the facts with the DWD metadata files and the Terms of use. Still to check in the DWD description: the codes of `QN_8` and `WRTR` and which hour `MESS_DATUM` covers. The research questions are a proposal that our group still has to agree on.

## 2026-11-10 · Lab 02, Task 4

- **Tool and model:** Claude (Anthropic), Claude Opus 5.5
- **Prompt:** Asked what `get_data.sh` has to contain, how to unzip the DWD file and print a first look at it, and why my numbers differ from `dataset.md`.
- **Accepted / changed / rejected:** I wrote the header, the URL and the target file myself. Claude completed the script (quotes, a clearer file name, `mkdir`, `curl -fL … || exit 1`, the `SOURCES.txt` line), wrote the block that unpacks the ZIP and prints size, type, lines, columns and first lines, and phrased my three explanations of the differences as the comment at the end. I ran the script, checked `SOURCES.txt` and saved `get_data.txt`.
- **How I checked it:** Ran the script twice in Git Bash and compared its output with my `dataset.md` (13,200 rows, 7 columns, period, size, encoding).

## 2026-11-10 · Lab 03, Tasks 1–6

- **Tool and model:** Claude (Anthropic), Claude Opus 5.5
- **Prompt:** Asked how to do each step and what Git's answers mean, and gave my own short answers to the questions in German.
- **Accepted / changed / rejected:** In Task 1, I made the predictions myself; Claude corrected them and wrote my answers into `graph.md`. I typed and ran every Git command myself, made all commits, branches, the merge and the conflict resolution, had the idea for the new comment in Task 3 (Claude phrased it) and found issue #18 on GitHub. Claude gave me the commands for each step (including the `grep`/`cut` combinations and the loop in Task 6), explained the outputs, and wrote most of the text in `git.md` (Setup, Step by step, Undo), `README.md`, `conflict.md` and `history.md` from my outputs and my short answers. Claude corrected some of my answers, for example why Git groups neighbouring changes into one conflict, and what to note for data without Git.
- **How I checked it:** Every output in the files comes from my own terminal. Claude checked each pushed file on GitHub; twice the Markdown broke when I copied from the preview (`\#`), and I fixed it.


## 2026-11-12 · Lab 03, Task 7

- **Tool and model:** Claude (Anthropic), Claude Opus 5.5
- **Prompt:** Asked how to do each step of the team workflow (issues, branches, pull requests, reviews, merging, cleaning up) and how to fill in `team.md`.
- **Accepted / changed / rejected:** Claude gave me the Git commands and explained the GitHub screens; I ran every command myself and created the issues, branches and pull requests, reviewed my teammates' pull requests and merged my own. Claude phrased the team table, the plan table and the extended DWD row in the team README; the dates, roles and data sources we decided as a team, and I corrected Claude where it had swapped two teammates' datasets. Claude wrote `team.md` from my terminal output and from what happened in our repository, including the reflection.
- **How I checked it:** The links and the `git log` in `team.md` come from our team repository; I checked the DWD wind and temperature files with `curl` (both returned 200) and read the reflection against our pull requests.
