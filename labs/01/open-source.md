## Licence

pandas is licensed under the [BSD 3-Clause License](https://github.com/pandas-dev/pandas/blob/main/LICENSE). 
It is a permissive licence: I may use, change and redistribute the code, even in closed-source software. 
If I copy code into my own project, I must keep the copyright notice and the licence text, and I may not use the names of pandas or its contributors to promote my product without permission.

## What machines see

- **pandas:** The [API](https://api.github.com/repos/pandas-dev/pandas) returns `BSD-3-Clause`, so GitHub found the LICENSE file and matched it to a known licence.
- **My lab repository:** The [API](https://api.github.com/repos/paulews/data-integration-labs) returns `MIT`, because the LICENSE file I added in Task 2 is recognised as well.
- **owid/co2-data:** The [API](https://api.github.com/repos/owid/co2-data) returns `null`: GitHub found no licence file it could read. The licence (CC BY 4.0) is only stated in the [README](https://github.com/owid/co2-data#license), so people can find it, but machines cannot.

## Community files

According to [Community standards](https://github.com/pandas-dev/pandas/community), pandas has all four files: README, LICENSE, CONTRIBUTING and CODE_OF_CONDUCT. 
It also has a security policy, issue templates and a pull request template. Only "Repository admins accept content reports" is not set up.

## People

pandas has [3,897 contributors](https://github.com/pandas-dev/pandas/graphs/contributors) (as of 07.11.2026). 
According to its [governance document](https://pandas.pydata.org/about/governance.html), the Core Team has commit rights and decides by consensus, with input from the community. 
Wes McKinney, the original author, is the BDFL ("Benevolent Dictator for Life"): he can make a final decision, but rarely does.

## Money

pandas is a sponsored project of [NumFOCUS](https://numfocus.org/), a US non-profit foundation that manages donations to pandas and gives fiscal, legal and administrative support ([sponsors page](https://pandas.pydata.org/about/sponsors.html), [NumFOCUS on Open Collective](https://opencollective.com/numfocus)). 
Companies also pay: Nvidia employs a core developer as an institutional partner, and Tidelift and Bodo fund the project as sponsors. The rest of the work is done by volunteers.

## Activity

The latest release is [pandas 3.1.1](https://github.com/pandas-dev/pandas/releases), published on 04.11.2026. 
On 07.11.2026, [1,692 issues](https://github.com/pandas-dev/pandas/issues) and [292 pull requests](https://github.com/pandas-dev/pandas/pulls) were open. With 126 releases so far, the project is very active.

## Your way in

According to the [contributing guide](https://pandas.pydata.org/docs/dev/development/contributing.html), a change gets in like this: find an open issue that is not assigned and has no label such as "Needs Triage", claim it by commenting `/take`, then open a pull request that says `closes #<issue>`. 
Maintainers review it; without a reaction from the author for 14 days it becomes "Stale" and is closed after 7 more days. Contributors may hold at most two issues at a time, and AI-generated contributions must be disclosed.

pandas does not label issues for newcomers: its [contribute page](https://github.com/pandas-dev/pandas/contribute) shows no good first issues, and the guide even links the post "Don't start with good first issues". 
Instead, new contributors find help in the pinned issue [Information for new contributors](https://github.com/pandas-dev/pandas/issues/49275) and in regular meetings for new contributors. The contribute page still links `.github/CONTRIBUTING.md`, which no longer exists.
