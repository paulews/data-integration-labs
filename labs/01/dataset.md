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
