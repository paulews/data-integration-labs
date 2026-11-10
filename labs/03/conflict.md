# Merge conflict
```text
<<<<<<< HEAD
name,iso3,iso2,numeric
Czech Republic,CZE,CZ,203
Germany,DEU,DE,276
Macedonia,MKD,MK,807
Swaziland,SWZ,SZ,748
Turkey,TUR,TR,792
=======
name,iso3,iso2
Czechia,CZE,CZ
Germany,DEU,DE
North Macedonia,MKD,MK
Eswatini,SWZ,SZ
Türkiye,TUR,TR
>>>>>>> feature/new-names
```

## What a program would see

`cut -d, -f1 countries.csv` shows the first column of the file as Git left it: the lines `<<<<<<< HEAD`, `=======` and `>>>>>>> feature/new-names` as if they were countries, the header `name` twice, and every country twice, once with its old and once with its new name. The rows also have different numbers of columns (4 above `=======`, 3 below). A program that reads this CSV would either stop with an error or quietly load garbage rows.

## History after the merge

```text
*   dffa1bb (HEAD -> main, origin/main, origin/HEAD) Merge branch 'feature/new-names'
|\
| * 083498e Use current country names
* | db1048c Add ISO numeric codes
|/
* 3b421b5 Add ISO2 codes
* 0ec519b Add country mapping table
* 98e809f Add undo notes for Lab 3 Task 4
* 6c8a883 Revert "Break the download URL on purpose"
* 1841f80 Break the download URL on purpose
```

## Questions

**The two branches changed different columns, so why did Git report a conflict?** Git does not know columns, it compares lines. In a CSV file, a row is one line. `feature/new-names` changed the name in four rows, and `main` appended a code to the same rows. So both branches changed the same lines in different ways, and Git cannot decide which version is right.

**Why are *Germany* and the header part of the conflict, although only one branch changed them?** Only `main` changed them (it added the `numeric` column). But Git groups changes that are next to each other into one block. Every line of the file was changed by at least one branch, so the whole file became one conflict, including the lines in between.

**How could our team avoid conflicts like this one in a shared data file?**

- Agree who works on which file, or on which part of it, and tell each other before editing a shared file.
- Keep branches short: pull `main` before you start, commit small changes and merge them soon, so that the others build on the newest version.
- Do not edit data tables by hand. Let a script create them, and change the script instead. Then a conflict is in a few lines of code, not in every row of the data.
- Split large tables, for example one mapping file per source, so that two people rarely touch the same file.