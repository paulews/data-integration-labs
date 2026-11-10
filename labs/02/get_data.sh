#!/bin/bash
# get_data.sh: downloads the hourly precipitation of DWD station 02667 Köln/Bonn (recent values).
# Usage: ./get_data.sh
#
# Source:  Deutscher Wetterdienst (DWD), Stundenwerte Niederschlag, station 02667 Köln/Bonn,
#          https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/hourly/precipitation/
# Licence: CC BY 4.0, https://creativecommons.org/licenses/by/4.0/

url="https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/hourly/precipitation/recent/stundenwerte_RR_02667_akt.zip"
out="data/raw/rr_02667_recent.zip"

mkdir -p data/raw
curl -fL -o "$out" "$url" || exit 1
echo "$(date +"%Y-%m-%d %H:%M") $url -> $out" >> data/raw/SOURCES.txt


# Unpack the zip: the data is in produkt_rr_stunde_*.txt, the rest is metadata.
unzip -o -q "$out" -d data/raw/rr_02667
data=$(ls data/raw/rr_02667/produkt_rr_stunde_*.txt)

# First look at the data
echo "== Size";        ls -lh "$data"
echo "== Type";        file "$data"
echo "== Lines";       wc -l < "$data"
echo "== Columns";     head -n 1 "$data" | tr ';' '\n' | wc -l
echo "== First lines"; head -n 3 "$data"

# Compared with dataset.md (downloaded one day earlier):
# - Period: 09.05.2025-09.11.2026 instead of 08.05.2025-08.11.2026. The "recent" file
#   is a rolling window that DWD moves forward every day, so the number of rows stays
#   the same (13,200 hours + 1 header) while the content changes.
# - Size: ls -lh shows 658K, dataset.md says 673 KB. ls counts 1 K = 1024 bytes,
#   658 x 1024 = about 674,000 bytes, so the size is the same.
# - Type: file says ASCII, dataset.md says Latin-1. The data file has no umlauts, and
#   ASCII is the part that Latin-1 and UTF-8 share, so file cannot tell them apart.
#   Only the metadata files contain umlauts (Köln) and show that DWD uses Latin-1.