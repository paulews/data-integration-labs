# Dataset Profile: DWD Hourly Precipitation (Station Köln/Bonn)

## Task 5: Dataset Search & Selection

### Search process

I looked for hourly weather data for Cologne in three kinds of sources: a national portal, a city portal and a dataset search engine.

| Source | Kind | Search term | Result |
| --- | --- | --- | --- |
| [GovData](https://www.govdata.de) | National portal | `Niederschlag Köln` | No hits |
| [GovData](https://www.govdata.de) | National portal | `Wetter Köln` | Several hits, e.g. [Wetterdaten Projekt iResilience 2021](https://www.govdata.de/suche/daten/wetterdaten-projekt-iresilience-2021-iii), but project data, no continuous hourly measurements |
| [Offene Daten Köln](https://www.offenedaten-koeln.de) | City portal | `Niederschlag` | No hits |
| [Offene Daten Köln](https://www.offenedaten-koeln.de) | City portal | `Wetter` | Unrelated hits only (e.g. volunteer fire brigade staff numbers, artificial turf pitches); closest is the *Planungshinweiskarte Hitze Köln*, a climate analysis map (JSON, WMS, WFS, Shape), not measured weather |
| [Google Dataset Search](https://datasetsearch.research.google.com) | Search engine | `DWD Köln` | Third-party sites (otterwetter.de, ultrion.de) that reuse DWD data without a clear licence, and one DWD dataset on [data.europa.eu](https://data.europa.eu/data/datasets/de-dwd-routine-meg-ico-eddk) |

### Following it back to the publisher

The hit on data.europa.eu links to the DWD's own [WIS portal](https://gisc.dwd.de/wisportal/#SearchPlace:q?pid=de.dwd.routine.meg.ico.EDDK). EDDK is the code of Köln/Bonn airport, but according to its identifier (`routine.meg.ico`) this dataset holds meteograms from the ICON weather model, that is, forecasts and not measurements. My question needs measured weather, so I went on to the DWD's Climate Data Center, which publishes the station observations.

### API search (GovData)

Query: https://www.govdata.de/ckan/api/3/action/package_search?q=niederschlag&rows=1

- **Count:** 605 datasets
- **First hit:** *Meteorologiemessstelle Grüntensee (Niederschlag)*, published by open.bydata, category *Umwelt*. The answer contains three `title` fields: the dataset, the organisation and the category.
- **Licence:** `license_id` is empty (`""`) at dataset level. The licence is only given per file under `resources`: CC BY 4.0 (`http://dcat-ap.de/def/licenses/cc-by/4.0`).

### Selection

I chose the **hourly precipitation observations of the Deutscher Wetterdienst (DWD)** for station 02667, Köln/Bonn.

- **Why:** Neither portal offers continuous hourly measurements for Cologne, and the third-party sites have no clear licence or provenance. The DWD is the original publisher: its data is measured, hourly, machine-readable (zipped CSV text files), covers decades and is licensed under CC BY 4.0.
- **Publisher:** Deutscher Wetterdienst (DWD), Climate Data Center
- **Dataset:** [hourly precipitation, all stations](https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/hourly/precipitation/)
- **File:** [station 02667 Köln/Bonn, recent values](https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/hourly/precipitation/recent/stundenwerte_RR_02667_akt.zip)

## Task 6: Profile

### Facts

| Fact | Value |
| --- | --- |
| Title | Hourly station observations of precipitation for Germany (*Stundenwerte Niederschlag*), station 02667 Köln/Bonn |
| Publisher | Deutscher Wetterdienst (DWD), Climate Data Center (original publisher) |
| Link | [opendata.dwd.de/…/hourly/precipitation/](https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/hourly/precipitation/) |
| Formats | ZIP containing a `;`-separated text file (CSV) plus metadata as TXT and HTML |
| Size | 1 ZIP (47 KB) with 16 files; data file 673 KB, 13,200 rows, 7 columns |
| Coverage | 08.05.2025 to 08.11.2026 (*recent*; older data in `historical/`, station measures since 1892) · station Köln/Bonn airport (50.86° N, 7.16° E, 91 m) · hourly |
| Last update | 09.11.2026 09:05 (date in the folder listing) |
| Update frequency | daily (the *recent* file is replaced every day) |
| Licence | CC BY 4.0 ([Terms of use](https://opendata.dwd.de/climate_environment/CDC/Terms_of_use.pdf)) |

### Stars

★★★ (3 of 5): the data is on the web under an open licence (★), machine-readable (★★) and in a non-proprietary format, plain text with separators (★★★). For the fourth star, each station and each measurement would need its own URI, for example in RDF, so that others can point to it.

### Open the data

I downloaded and unzipped the file in Git Bash (`curl`, `unzip`) and opened the data file `produkt_rr_stunde_20250508_20261108_02667.txt` in **Microsoft Excel** (Data → From Text/CSV, Power Query).

The ZIP file contains 1 data file and 15 metadata files (station location, station name, devices, parameters, missing data). The data file has 13,200 rows and 7 columns, one row per hour from 08.05.2025 00:00 to 08.11.2026 23:00.

```text
STATIONS_ID;MESS_DATUM;QN_8;  R1;RS_IND;WRTR;eor
       2667;2025050800;    3;   0.0;   0;   0;eor
```

| Column | Min | Max | Mean | Missing (-999) |
| --- | --- | --- | --- | --- |
| `R1` (precipitation in mm) | 0 | 14.9 | 0.083 | 2 |
| `RS_IND` (precipitation yes/no) | 0 | 1 | 0.197 | 2 |

Min and mean are calculated without the missing values. In about 20 % of all hours it rained, and the wettest hour brought 14.9 mm.

What I noticed:

- **Missing values** are not empty cells but coded as `-999`. If you do not exclude them, the minimum is -999 and the mean of `R1` becomes negative (-0.068).
- **Encoding:** the files are not UTF-8 but Latin-1. In Git Bash, umlauts appear broken (`Kln/Bonn` instead of `Köln/Bonn`, `Schl▒sselgruppen`). In Excel I had to choose *Western European (ISO)*.
- **Separator and spaces:** columns are separated by `;`, and values and some column names are padded with spaces (the column is called `"  R1"`, not `R1`).
- **Decimal point:** `R1` uses a decimal point. German Excel read `0.3` as `3` at first, until I set the column type to *Decimal number* with the locale *English (US)*.
- **Time:** `MESS_DATUM` is written as `YYYYMMDDHH` and is in **UTC** (`Metadaten_Parameter_rr_stunde_02667.txt`), not in German local time.
- **Last column** `eor` only means *end of record* and holds no data.
- **Coverage:** the *recent* file only starts on 08.05.2025. Older data is in a separate file in the folder `historical/`.

### Data dictionary

The DWD documents all columns in [DESCRIPTION_obsgermany_climate_hourly_precipitation_en.pdf](https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/hourly/precipitation/DESCRIPTION_obsgermany_climate_hourly_precipitation_en.pdf) and in `Metadaten_Parameter_rr_stunde_02667.txt`.

| Column | Meaning | Type and unit | Example |
| --- | --- | --- | --- |
| `STATIONS_ID` | ID of the weather station | integer, code | `2667` |
| `MESS_DATUM` | date and hour of the measurement | date and hour `YYYYMMDDHH`, UTC | `2025050800` |
| `QN_8` | quality level of the row | integer, code | `3` |
| `R1` | precipitation in this hour | decimal, mm | `0.3` |
| `RS_IND` | did it rain or snow in this hour? | integer, 0 = no, 1 = yes | `1` |
| `WRTR` | form of precipitation (rain, snow …) | integer, code; only reported for some hours | `0` |

### Licence

The data is open according to the Open Definition: CC BY 4.0 allows anyone to use, change and share it, also commercially. When we reuse it, we must name the source, link the licence and say whether we changed the data.

Attribution for our README (TASL):

> *Stundenwerte Niederschlag, station 02667 Köln/Bonn* by Deutscher Wetterdienst (DWD), [opendata.dwd.de](https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/hourly/precipitation/), licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Filtered and converted to local time by us.

### People

The data contains no personal data: it holds measurements of one weather station, run by the DWD, and no information about people.

## Task 7: FAIR review

| Principle | Rating | Evidence |
| --- | --- | --- |
| F1 | ~ | Stable URL for the dataset ([…/hourly/precipitation/](https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/hourly/precipitation/)) and for each file, but no DOI for the dataset itself: the description PDF only cites a DOI for a paper about the Climate Data Center ([Kaspar et al. 2013, doi:10.5194/asr-10-99-2013](https://doi.org/10.5194/asr-10-99-2013)). The name of the *recent* file stays the same, its content changes every day. |
| F2 | ~ | Rich metadata exists (15 metadata files per station plus a description PDF), but the download page itself is only a folder listing without title, description or keywords. |
| F4 | ~ | Not found on GovData or Offene Daten Köln. Via Google Dataset Search I only found other DWD datasets. On data.europa.eu, `Stundenwerte Niederschlag` gives over 6,500 hits, so the dataset is hard to find even if it is indexed. |
| A1 | ✓ | Download via HTTPS without login, also from the command line with `curl`. |
| I1 | ✓ | Plain text with `;` as separator, readable by any tool; ZIP is an open format. |
| I2, I3 | ~ | Dates are written as `YYYYMMDDHH` in UTC, close to ISO 8601 but not the standard form (`2025-05-08T00:00Z`). The station has a DWD ID and coordinates, but no official municipality key. The data links to its metadata files and the description, not to related datasets. |
| R1 | ✓ | Every column is described in the description PDF and in `Metadaten_Parameter_rr_stunde_02667.txt`, including units and time zone. |
| R1.1 | ~ | The licence is clear (CC BY 4.0 in the [Terms of use](https://opendata.dwd.de/climate_environment/CDC/Terms_of_use.pdf)), but only as a PDF, not in machine-readable metadata of the dataset or its files. |
| R1.2 | ✓ | Provenance is well documented: operator (DWD, before 1957 *Wetterdienst*), station history with all locations since 1892, devices and data source (SYNOP reports), known errors (device problem 2021). It is the original. |
| R1.3 | ✗ | The folder offers no DCAT-AP metadata. Other DWD datasets do appear with DCAT-AP on data.europa.eu, this one I did not find there. |

**Verdict:** The dataset is clearly **open** (CC BY 4.0, free download, open format) and only **partly FAIR**: it is very accessible and reusable, but hard to find, because it lives in a folder structure without a catalogue entry, DOI or machine-readable licence.

When we publish our own dataset for milestone 2, we will:

1. write dates in ISO 8601 and say which time zone they use,
2. put the licence and a description in machine-readable metadata (for example a `datapackage.json` or a README with a licence file),
3. use empty cells or a documented `NA` for missing values instead of a magic number like `-999`.

## Task 8: Combination plan

### Second source

**Deutsche Bahn delay data** collected by the GitHub user piebro from the DB Timetables API: [huggingface.co/datasets/piebro/deutsche-bahn-data](https://huggingface.co/datasets/piebro/deutsche-bahn-data) ([documentation](https://github.com/piebro/deutsche-bahn-data)). Licence: CC BY 4.0, original publisher Deutsche Bahn. It has one row per train stop with planned and actual times, `delay_in_min`, cancellations and train type, for the ~100 largest stations (including Köln Hbf) since 07/2024, as monthly Parquet files.

### Shared key

Both sources are linked by **time** (date and hour). The place is fixed: DB rows are filtered to Köln Hbf (`station_name`), the weather comes from station 02667 Köln/Bonn.

Real values from both sources (DB: `data-2025-05.parquet`, filtered to `station_name == "Köln Hbf"`, read with pandas):

| DB `time` (German time) | Train | → UTC | DWD `MESS_DATUM` |
| --- | --- | --- | --- |
| `2025-05-08 02:13:00` | S, 0 min late | 00:13 | `2025050800` |
| `2025-05-08 02:16:00` | S, 1 min late | 00:16 | `2025050800` |
| `2025-05-08 02:24:00` | S, 0 min late | 00:24 | `2025050800` |
| `2025-05-08 17:01:00` | S 11, 14 min late (planned 16:47) | 15:01 | `2025050815` |

In May 2025, Köln Hbf has 32,806 train stops (of 2,011,335 in the whole file), about 44 per hour. The station also has an official code: `eva` = `08000207`.

They do not match as published:

- **Time zone:** DWD uses UTC, DB uses German local time (CET/CEST). We must convert one of them: +1 hour in winter, +2 hours in summer, with the switch in March and October.
- **Format:** DWD writes `YYYYMMDDHH` as a number, DB a real timestamp. We parse `MESS_DATUM` into a timestamp.
- **Precision:** DB times are exact to the minute, DWD gives whole hours. We cut DB times down to the hour (floor).
- **Planned or actual time:** DB `time` is the *actual* time (17:01 above), the planned time was 16:47. Here the two fall into different weather hours, so we must decide which one to join on.
- **Time zone not stored:** DB timestamps carry no time zone (`.dt.tz` is `None`); only the documentation says they are German time.
- **Hour meaning:** we still have to check in the DWD description whether `2025050800` covers the hour before or after 00:00.

### Granularity

DWD has **one row per hour**, DB has **one row per train stop** (several hundred per hour at Köln Hbf). Two ways to align them:

1. aggregate DB per hour (mean delay, share of trains more than 5 minutes late, number of cancellations) and join one weather row per hour, or
2. give every train stop the weather of its hour, which keeps train type for comparing ICE/IC with regional trains.

Area: the weather station is at Köln/Bonn airport, about 15 km from Köln Hbf. Local showers can differ, which we must mention as a limitation.

### Research questions

1. Are trains at Köln Hbf more delayed in hours with precipitation than in dry hours?
2. Does the share of cancelled trains rise with heavy rain (for example more than 5 mm per hour)?
3. Does rain affect long-distance trains (ICE/IC) more than regional trains?

### Licences

Both sources are licensed under CC BY 4.0, so we may combine them and publish the joined table, also under CC BY 4.0. We must credit the **Deutscher Wetterdienst** and **Deutsche Bahn** (data collected by piebro), link the licence and state our changes (filtered to Köln, converted time zone, aggregated per hour).

### Next steps

```mermaid
flowchart LR
  A[Download DWD recent + historical ZIP] --> B[Read CSV, drop -999, parse MESS_DATUM as UTC]
  C[Download DB monthly Parquet 07/2024 onwards] --> D[Filter Köln Hbf, convert time to UTC, floor to hour]
  B --> E[Join on hour]
  D --> E
  E --> F[Joined table: delay and weather per hour]
```

### Verdict

Yes, we will build our project on this dataset: it is open, measured, hourly and well documented, and it covers the same period as the DB data. The biggest risk is the **join**: a time zone mistake would shift every hour, and the weather at the airport is not exactly the weather at Köln Hbf. We also need the *historical* DWD file, because the *recent* file only starts in May 2025.
