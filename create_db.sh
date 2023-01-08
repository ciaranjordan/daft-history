#!/bin/bash
set -euxo pipefail

git-history file listings.db galway_listings.json --id id --namespace listing --import datetime --import re --convert '
from datetime import datetime

for listing in json.loads(content)["listings"]:
    listing["listing"]["latitude"] = listing["listing"]["point"]["coordinates"][1]
    listing["listing"]["longitude"] = listing["listing"]["point"]["coordinates"][0]
    listing["listing"]["publishDateReadable"] = str(datetime.fromtimestamp(listing["listing"]["publishDate"]/1000))
    listing["listing"]["numericPrice"] = re.sub("[^0-9]", "", listing["listing"]["price"])

    yield listing["listing"]
'
