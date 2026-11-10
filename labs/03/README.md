# Lab 3 · Version control with Git

## What is in this folder

| File | Content |
|---|---|
| `graph.md` | Task 1: my predictions and answers for the four rounds in *Visualizing Git* |
| `git-graph.png` | Task 1: screenshot of the final commit graph |
| `git.md` | Tasks 2 and 3: my notes on cloning, my commit history and committing step by step |
| `get_data.sh` | Downloads the hourly precipitation of DWD station 02667 Köln/Bonn as a ZIP, unpacks it and prints a first look at the data |
| `.gitignore` | Keeps the raw data in `data/raw/` out of Git |

## How to rebuild the raw data

The raw data is not in the repository. Anyone can download it again:

```bash
cd labs/03
./get_data.sh
```

The script creates `data/raw/` with the ZIP, the unpacked files and `SOURCES.txt`, a log of each download with date, time and URL. The DWD updates the *recent* file every day, so a new download covers a slightly different period.

## Source and licence

*Stundenwerte Niederschlag, station 02667 Köln/Bonn* by Deutscher Wetterdienst (DWD), [opendata.dwd.de](https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/hourly/precipitation/), licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

Part of my labs for DIS 3.3 Data Integration at TH Köln.