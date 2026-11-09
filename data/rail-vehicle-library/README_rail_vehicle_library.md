# Rail vehicle library — starter release

This is a workable, game-oriented catalog foundation: `rail_vehicle_catalog.csv` opens in spreadsheet software and can be imported into a database; `rail_vehicle_schema.sql` defines a normalized SQLite model for production use.

## Coverage and completeness

This release contains 54 records: 51 named vehicle/family records and 3 generic gameplay archetypes. It is a starter catalog, not a verified census of every railway vehicle ever built. No single public source is a complete, authoritative, global inventory of every engine, coach, wagon, tram, metro car, and trainset. Records also represent a mix of individual models and families; those levels must be made explicit before production use. A claim of complete coverage would be misleading.

Use this library as an expandable registry. Track each source, source confidence, last checked date, scope (individual vehicle, class/family, or generic archetype), and coverage status. Keep uncertain facts blank rather than inventing values. `0` means a known non-applicable value only where the field definition supports it; blank means unknown. Some seed rows still need data cleanup and verification, especially approximate or generic records.

## Tags

The CSV uses pipe-separated tag fields. Suggested controlled groups for expansion:

- **Vehicle kind:** engine, car, trainset
- **Traction:** steam, diesel, electric, battery, hydrogen, bi-mode, unpowered
- **Service role:** metro, tram, commuter, regional, intercity, high-speed, freight, maintenance, heritage
- **Operating fit:** local, regional, national, international
- **Capability:** high-capacity, accessible, tilting, push-pull, distributed-power, heavy-haul
- **Compatibility:** gauge, electrification, platform length, loading gauge, signaling, couplers
- **Lifecycle:** planned, in service, withdrawn, preserved

Use tags for discovery and game balancing, while keeping measurable properties (gauge, speed, capacity, power) in separate fields.

## Data conventions

- One row describes a vehicle model or family, not a unique numbered unit.
- Cars are separately modeled from engines and trainsets; real formations should be represented in a future `formation` / `formation_member` relationship.
- Multiple values in CSV fields use `|` as a separator.
- Empty production years or specifications are unknown. Some entries currently use zero for unavailable values and should be corrected to blank before production import.
- `source_confidence` describes the initial record quality, not a licensing or safety certification.

## Expansion workflow

1. Add a record only with a traceable source and clear record scope.
2. Normalize manufacturers, operators, regions, gauges, propulsion, and service roles into controlled vocabularies.
3. Deduplicate aliases and variants while preserving distinct subtypes that affect gameplay.
4. Validate factual fields against operator, manufacturer, museum, or government sources where possible.
5. Record coverage by country, era, and vehicle category; report uncatalogued coverage openly.
6. Review licensing before redistributing imported datasets or photographs.

## Data sources to seed and reconcile

- [Wikidata data access](https://www.wikidata.org/wiki/Help:Data_access): queryable data and downloadable dumps; useful for discovery and identifiers, but community-maintained and not a completeness guarantee.
- [RailToolKit rolling-stock-data](https://zenodo.org/records/6468325): a small open research collection intended for running-time estimation, not a world inventory.
- National operators, manufacturers, rail museums, transit agencies, and vehicle registers should be used to verify technical specifications and lifecycle status.

Generated on 2026-11-09. Audit the seed records and database rights before shipping them in a commercial game.

## Regional coverage added

New York City region coverage now includes NYCT subway and Staten Island Railway cars, plus LIRR and Metro-North commuter passenger cars. See [New York City fleet research and sources](us_new_york_city_sources.md). The coverage reflects operator fleet lists, not every outside operator that reaches New York City.

## U.S. rail inventory baseline (2025 NTD)

The 2025 FTA National Transit Database Revenue Vehicle Inventory adds a nationwide U.S. rail baseline in three linked CSVs:

- `us_rail_vehicle_profiles_2025.csv`: 859 reported vehicle specification profiles, deduplicated across agencies.
- `us_rail_fleet_deployments_2025.csv`: 2,259 active inventory records linked to profiles, covering 80 reporting agencies and 24,589 active revenue vehicles.
- `us_rail_city_coverage_2025.csv`: grouped coverage for 73 city/service regions.

Rows include commuter rail, heavy rail, light rail, cable cars, vintage trolleys, automated guideway, inclined plane, monorail, and aerial tramway vehicles. One NTD inventory row can represent multiple active vehicles. Capacity fields reproduce NTD seated and standing counts per vehicle; `capacity_total` is their sum when both source values are present. Length is preserved in feet and converted to meters. `max_speed_kmh` is blank because the inventory does not publish speed. `service_city_region` and state abbreviations are practical metro/service-area mappings inferred from reporting agencies; NTD IDs and agency names are retained. Multi-region services are labeled accordingly.

Source: [FTA 2025 NTD Revenue Vehicle Inventory](https://data.transportation.gov/Public-Transit/2025-NTD-Annual-Data-Revenue-Vehicle-Inventory/ifzt-j53d), checked 2026-11-09. This is a reporting baseline, not a claim that every U.S. city or every non-NTD, heritage, or private rail operator is covered. Some agencies report several modes and some commuter agencies span multiple cities. Review the region mapping and licensing terms before commercial redistribution.

### Researched U.S. vehicle specifications

The NTD profile CSV now includes separate `researched_*` fields, `*_basis`, source URLs, and `spec_checked_on`. These supplement the NTD-reported capacities; they do not replace them. Speed entries distinguish design maximum from manufacturer maximum. Current researched matches are intentionally conservative: Siemens S700 (manufacturer maximum 105 km/h), Chicago CTA 7000-series 48-foot profiles (CRRC design maximum 113 km/h), and CTA Bombardier 5000-series profiles (manufacturer design maximum 70 mph / 112.7 km/h, rated 38 seated and 123 seated plus standing). The CTA 5000 source is the Bombardier maintenance manual in the NTSB docket. These sources identify the relevant model and configuration.

The 859 profile rows do not all have model-level speed values yet. NTD capacity data remains the base value for each profile; only the 5000-series profiles above include an additional manufacturer-rated total-capacity value. Unmatched and ambiguous variants remain blank. Wikipedia and other community references may help discover model names and sources, but are not treated as sufficient evidence for these technical values.
