# Rail Network Builder: Game Framework

## Core idea

A strategy and management game about building rail systems that connect small communities to national and international networks. Players design infrastructure, choose trains, set service patterns, and respond to changing demand. The central challenge is making distinct networks work together: local lines feed regional services, regional services connect to national routes, and national systems link across borders.

## Game pillars

- **Build:** Lay track, stations, yards, depots, and connections across a map.
- **Operate:** Set routes, timetables, frequencies, train consists, and service priorities.
- **Connect:** Coordinate separate systems through shared hubs, interchange, and compatible infrastructure.
- **Grow:** Match capacity and investment to ridership, geography, and economic development.
- **Explore railway technology:** Choose from a broad catalog of engines, cars, and trainsets.

## Network layers

| Layer | Typical role | Main decisions |
|---|---|---|
| Local | Urban and suburban travel | Stop spacing, frequency, transfers, peak capacity |
| Regional | Towns and cities within a region | Travel time, service patterns, feeder connections |
| National | Long-distance links across a country | Major corridors, intercity frequency, rolling stock |
| International | Cross-border passenger and freight links | Interoperability, border procedures, shared hubs |

Players can create multiple networks at each layer. Separate metro, tram, and commuter systems can connect at shared stations.

## Map and infrastructure

The map is the main construction and operations surface. It supports track placement with curves, grades, junctions, bridges, tunnels, and crossings; multiple gauges; stations, interchanges, yards, depots, terminals, and maintenance facilities; and constraints such as electrification, speed limits, and axle load. Optional overlays show terrain, population, demand, existing infrastructure, congestion, and service coverage.

The simulation distinguishes a **physical connection** from a **passenger interchange**. Lines can share a station without sharing tracks, and tracks can connect without providing a convenient transfer.

## Train and equipment database

Organize equipment as structured data in three primary categories:

- **Engines:** Locomotives and other powered units that haul compatible cars.
- **Cars:** Passenger, freight, service, and specialist vehicles that form a train.
- **Trainsets:** Integrated units with defined formations, including multiple units and fixed-consist trains.

Entries can include manufacturer, model, build years, region, gauge, power type, speed, capacity, range, dimensions, cost, maintenance needs, and compatibility. The starter catalog is in [`data/rail-vehicle-library/`](data/rail-vehicle-library/). It contains 28 records and is an expandable seed library, not a verified census of every train ever made. Keep sources and confidence with each record; fact-check seed data before shipping it in a game.

## Network management hub

Each local, regional, national, or international system has a management hub with:

- **Ridership:** Boardings, origin-destination flows, crowding, transfers, and unmet demand.
- **Frequency:** Departures per hour, service span, peak and off-peak patterns, and reliability.
- **Train assignment:** Vehicle type, consist, capacity, speed, and accessibility.
- **Operations:** Punctuality, bottlenecks, platform use, maintenance, and operating cost.
- **Connections:** Transfer quality, coordinated schedules, and links to other networks.

Players can manage a network as a whole, then open a route or station for detailed controls.

## How networks work together

Treat each network as an operating organization with its own routes, fleet, budget, and service settings. Networks cooperate through shared infrastructure and interchange agreements. Mechanics include coordinated timetables and transfer windows, shared stations with capacity limits, transfer quality based on walking distance and schedule coordination, through-running where track/gauge/power/signaling allow it, transfer penalties, and optional freight interchange and cross-border rules.

## Suggested gameplay loop

1. Read demand, terrain, and existing infrastructure.
2. Choose a service goal, such as connecting towns or reducing city congestion.
3. Plan and build track, stations, and facilities.
4. Select compatible equipment from the train database.
5. Create routes and set frequency and stopping patterns.
6. Connect the service to other networks.
7. Review ridership, reliability, cost, and crowding.
8. Expand, retime, upgrade, or redesign based on results.

## Development path

Start with a playable foundation: a map, track construction, stations, a small equipment catalog, route creation, schedules, and basic ridership simulation. Then add multiple network layers, cross-network transfers, detailed operations, international connections, and a larger equipment database.

Keep **infrastructure, services, organizations, and vehicles** as separate but connected systems. This lets the game grow from a local rail builder into a multi-scale network simulator without redesigning its foundations.

## UX direction: approachable, with character

- Start with the railway and map, not a control panel. Let players place a line, connect stations, and run a useful service before exposing advanced settings.
- Reveal details as players need them. Beginners can choose an interval and a suitable train; experienced players can tune departures and consists.
- Use familiar language such as “trains per hour,” “transfer,” and “platform,” and explain constraints in context.
- Let the map explain demand, crowding, awkward connections, and delays. Keep charts available without making spreadsheets the main way to understand the railway.
- Make stations feel like places through restrained local details, neighborhoods, passenger stories, and changing scenery.
- Give specific, actionable feedback about service problems and let players decide how to respond.
- Keep the visual design grounded in railways with a readable map, strong route colors, and distinct vehicle silhouettes.

For every screen, ask: **Can a new player tell what they’re looking at, what they can do next, and what changed because of their decision?**


The first lightweight map screen is [`map-prototype.html`](map-prototype.html). It is a standalone Canvas 2D prototype with a generalized contiguous-U.S. outline, selectable hex tiles, generated terrain relief, and terrain, population, combined, and rail-potential views. It runs locally without a map API or large mapping library. Its shape and terrain are illustrative; the population layer uses seeded major-metro estimates to demonstrate the game mechanic and should be replaced with licensed Census and geographic datasets before being presented as authoritative data.
