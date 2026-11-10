# Lab 3 · Task 6: The history of a dataset

I cloned [datasets/co2-ppm](https://github.com/datasets/co2-ppm) next to my lab repository (`~/dis/co2-ppm`). All questions are about `data/co2-mm-mlo.csv`.

## 1. Versions

```bash
git log --oneline -- data/co2-mm-mlo.csv | wc -l
git log --format="%an" -- data/co2-mm-mlo.csv | sort | uniq -c
git log --format="%ad" --date=format:%Y -- data/co2-mm-mlo.csv | sort | uniq -c
```

```text
48
      1 Joel
      1 Luccas Gomes
     15 Soren Jones
     30 github-actions
      1 subhankar
     10 2015
      4 2016
      2 2017
     10 2024
     11 2025
     11 2026
```

48 commits changed the file. Most came from Soren Jones (2015–2017) and, since 2024, from the bot `github-actions`. From 2018 to 2023, nobody updated the file. The last commit before the gap was `af2c0a6` (13.03.2017), and its newest month was December 2016:

```bash
h=$(git log -1 --before=2018-01-01 --format=%h -- data/co2-mm-mlo.csv)
git show $h:data/co2-mm-mlo.csv | tail -n 2
```

```text
2016-11-01,2016.875,403.53,403.53,405.57,27
2016-12-01,2016.958,404.48,404.48,405.25,29
```

So for almost seven years, anyone who downloaded the file got data that ended in December 2016.

## 2. The day the data disappeared

```bash
git log --format="%h %ad %an %s" --date=short --shortstat -- data/co2-mm-mlo.csv | grep -B2 -E "[0-9]{3,} deletions"
```

```text
0c74626 2026-03-01 github-actions Commit from GitHub Actions (Update Data from NOAA)

 1 file changed, 814 deletions(-)
```

All other commits with many deletions also added about as many lines (reformatting). `0c74626` only deleted. As it left the file:

```bash
git show 0c74626:data/co2-mm-mlo.csv | wc -l
git show 0c74626:data/co2-mm-mlo.csv | head -5
```

```text
1
Date,Decimal Date,Average,Interpolated,Trend,Number of Days
```

On 01.03.2026, my `get_data.sh` would have downloaded a file with only the header and not a single measurement, and without any error, because the file existed. Luccas Gomes repaired it two days later, on 03.03.2026:

```bash
git log --reverse --format="%h %ad %an %s" --date=short 0c74626..main -- data/co2-mm-mlo.csv | head -1
git show 4ae30e8 -- scripts/process.sh
```

```text
4ae30e8 2026-03-03 Luccas Gomes fix: harden NOAA fetch and restore co2-mm-mlo output
```

```diff
-  curl ftp://aftp.cmdl.noaa.gov/products/trends/co2/$file > tmp/$file
+  curl --fail --silent --show-error --location ftp://aftp.cmdl.noaa.gov/products/trends/co2/$file -o tmp/$file
+  if [ ! -s "tmp/$file" ]; then
+    echo "Download failed or empty file: $file" >&2
+    exit 1
+  fi
```

The repair applies the lesson from lab 2, Task 4: use `curl --fail`, so that an error is not saved as data, and stop the script (`exit 1`) instead of carrying on with an empty file.

## 3. Old numbers change

```bash
git show --stat 8c40972
git diff 8c40972~1 8c40972 -- data/co2-mm-mlo.csv | grep -c '^-[0-9]'
git diff 8c40972~1 8c40972 -- data/co2-mm-mlo.csv | grep -c '^+[0-9]'
git diff 8c40972~1 8c40972 -- data/co2-mm-mlo.csv | grep '^-[0-9]' | head -1
git diff --word-diff --word-diff-regex='[^,]+' 8c40972~1 8c40972 -- data/co2-mm-mlo.csv | grep '\[-' | head -5
```

```text
 data/co2-mm-mlo.csv     | 103 +++---
51
52
-1982-12,1982.9583,340.78,341.70,26,0.30,0.11
1982-12,1982.9583,340.78,[-341.70-]{+341.71+},26,0.30,0.11
1993-10,1993.7917,354.23,[-357.60-]{+357.61+},28,0.29,0.11
1995-07,1995.5417,361.78,[-361.10-]{+361.11+},28,0.36,0.13
2020-02,2020.1250,414.32,[-413.40-]{+413.41+},28,0.69,0.25
2020-06,2020.4583,416.58,[-414.15-]{+414.16+},27,0.44,0.16
```

The update of 01.10.2026 added 1 month (52 − 51) and changed 51 existing months. The oldest changed month is December 1982. In each row, the fourth value changed by 0.01. Numbers that I computed from a download in September would no longer match the October file: there is no single "the data", only versions of it.

## 4. A header that no longer fits

```bash
git show 8c40972:data/co2-mm-mlo.csv | head -2
git show af2c0a6:data/co2-mm-mlo.csv | head -2
```

```text
Date,Decimal Date,Average,Interpolated,Trend,Number of Days
1958-03,1958.2027,315.71,314.44,-01,-9.99,-0.99
```

```text
Date,Decimal Date,Average,Interpolated,Trend,Number of Days
1958-03-01,1958.208,315.71,315.71,314.62,-1
```

In 2017, the header had 6 names and a row had 6 values. In October 2026, the header still has 6 names, but a row has 7 values. A program would read the values under the wrong names, and the last value has no name at all. To find since when, I counted names and values in every version:

```bash
for c in $(git log --reverse --format=%h -- data/co2-mm-mlo.csv); do echo "$c $(git show $c:data/co2-mm-mlo.csv | head -1 | tr ',' '\n' | wc -l) $(git show $c:data/co2-mm-mlo.csv | sed -n 2p | tr ',' '\n' | wc -l)"; done
```

```text
...
a864797 6 6
af2c0a6 6 6
ed48c9c 6 7
50dcc34 6 7
...
0c74626 6 0
4ae30e8 6 7
...
8c40972 6 7
52f2be5 6 7
```

It has been that way since `ed48c9c` (13.02.2024, Joel, "Add automatic updates of data"), the commit that handed the updates to the bot. The problem is known: [issue #18](https://github.com/datasets/co2-ppm/issues/18), *co2-mm-gl.csv and co2-mm-mlo.csv have incorrect number of header names vs columns*, opened on 4 May 2026, is still open. A pull request is linked to it, but the newest version (`52f2be5`) still has 6 names and 7 values, so it is not fixed yet.

## 5. Pin your version

```bash
git rev-parse 8c40972
curl -fsSL https://raw.githubusercontent.com/datasets/co2-ppm/8c4097238570147adf6fa97ad357315528dac4c5/data/co2-mm-mlo.csv | tail -n 1
```

```text
8c4097238570147adf6fa97ad357315528dac4c5
2026-08,2026.6250,427.55,429.51,17,0.36,0.17
```

This URL will always return the file as it was on 01.10.2026, ending with August 2026, because it names a commit and not a branch.

```bash
git checkout 0c74626
wc -l data/co2-mm-mlo.csv
git status
git switch main
```

```text
1 data/co2-mm-mlo.csv
HEAD detached at 0c74626
nothing to commit, working tree clean
```

Git calls the state in between **detached HEAD**: `HEAD` points to a commit, not to a branch.

## Which version did we use?

In our project README, we note for each dataset from a Git repository the full commit hash and a raw URL with that hash, as in question 5, so that anyone gets exactly the same file. Data from a portal without Git, such as the DWD weather data, has no hash, so we note the download date (our `SOURCES.txt` logs it automatically) and the checksum that our `get_data.sh` prints, and we keep a copy of the raw file outside Git. With the date and the checksum, we can at least tell whether a new download is the same file as ours.
