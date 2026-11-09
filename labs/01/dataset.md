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
