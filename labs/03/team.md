# Lab 03, Task 7: Team roadmap

Team repository: https://github.com/dis-bahn-wetter/bahn-wetter

## My issue and pull requests

- Issue: https://github.com/dis-bahn-wetter/bahn-wetter/issues/1
- Pull request (merged): https://github.com/dis-bahn-wetter/bahn-wetter/pull/2
- Further pull requests of mine:
  - https://github.com/dis-bahn-wetter/bahn-wetter/pull/9 (plan)
  - https://github.com/dis-bahn-wetter/bahn-wetter/pull/14 (team)
  - https://github.com/dis-bahn-wetter/bahn-wetter/pull/18 (wind and air temperature)

## Pull requests I reviewed

- https://github.com/dis-bahn-wetter/bahn-wetter/pull/4
- https://github.com/dis-bahn-wetter/bahn-wetter/pull/10
- https://github.com/dis-bahn-wetter/bahn-wetter/pull/13
- https://github.com/dis-bahn-wetter/bahn-wetter/pull/17

## git log --oneline --graph -15

```
*   2fa4cf3 (HEAD -> main, origin/main, origin/HEAD) Merge pull request #17 from dis-bahn-wetter/feature/15-ai-usage
|\
| * 08c8bdd Sort AI_USAGE entries by date and unify tool name
| * 6ec57ef Fill AI_USAGE.md with AI use so far
| * da92372 Add AI_USAGE.md to document AI tool use
* |   5ea7844 Merge pull request #18 from dis-bahn-wetter/feature/16-dwd-wind-temp
|\ \
| |/
|/|
| * b7f50a0 (origin/feature/16-dwd-wind-temp) Add wind and air temperature to the DWD data row (closes #16)
|/
*   e8292a4 Merge pull request #14 from dis-bahn-wetter/feature/11-team
|\
| * 279615d (origin/feature/11-team) Add team members and responsibilities (closes #11)
* |   00385fb Merge pull request #13 from dis-bahn-wetter/feature/12-thema
|\ \
| |/
|/|
| * 4cc97be Add topic description to README
|/
*   89cd12b Merge pull request #10 from dis-bahn-wetter/feature/7-forschungsfragen
|\
| * d731484 (origin/feature/7-forschungsfragen) Add research questions to README
* |   f787351 Merge pull request #9 from dis-bahn-wetter/feature/8-plan
|\ \
| |/
|/|
| * 946322a (origin/feature/8-plan) Add project plan until the final presentation (closes #8)
|/
*   97738aa Merge pull request #4 from dis-bahn-wetter/feature/3-db-verspaetungen
|\
```

## Reflection

In my review of PR #13 I commented on the topic description and asked to keep in mind that the DB and DWD data use different time zones, which we have to align before joining them. In PR #17 I requested changes because `AI_USAGE.md` was empty at first and my own AI use was missing; Thomas then added the entries and I approved. My PR #2 was merged first, so I had no conflict myself; Thomas's PR #4 then had a conflict in the data table of `README.md`, which was resolved by keeping both rows and removing the markers. As a team we agree that nobody pushes to `main`: every change goes through a branch and a pull request that needs one approval from a teammate before it is merged.
