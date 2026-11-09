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
