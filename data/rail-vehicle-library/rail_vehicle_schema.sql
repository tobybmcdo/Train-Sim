-- Rail Network Builder rolling-stock catalog schema (SQLite 3)
PRAGMA foreign_keys = ON;
CREATE TABLE vehicle (
  record_id TEXT PRIMARY KEY,
  record_name TEXT NOT NULL,
  record_kind TEXT NOT NULL CHECK(record_kind IN ('engine','car','trainset')),
  vehicle_category TEXT NOT NULL,
  traction TEXT NOT NULL,
  manufacturer TEXT,
  region TEXT,
  production_start INTEGER,
  production_end INTEGER,
  status TEXT CHECK(status IN ('planned','in_service','withdrawn','preserved','unknown')),
  capacity_seated INTEGER,
  capacity_total INTEGER,
  max_speed_kmh REAL,
  power_kw REAL,
  length_m REAL,
  notes TEXT,
  source_confidence TEXT NOT NULL CHECK(source_confidence IN ('high','medium','low','unverified'))
);
CREATE TABLE gauge (vehicle_id TEXT NOT NULL REFERENCES vehicle(record_id), gauge_mm INTEGER NOT NULL, PRIMARY KEY(vehicle_id,gauge_mm));
CREATE TABLE role (vehicle_id TEXT NOT NULL REFERENCES vehicle(record_id), role TEXT NOT NULL, PRIMARY KEY(vehicle_id,role));
CREATE TABLE scale (vehicle_id TEXT NOT NULL REFERENCES vehicle(record_id), scale TEXT NOT NULL CHECK(scale IN ('local','regional','national','international')), PRIMARY KEY(vehicle_id,scale));
CREATE TABLE tag (tag_id TEXT PRIMARY KEY, tag_group TEXT NOT NULL, label TEXT NOT NULL);
CREATE TABLE vehicle_tag (vehicle_id TEXT NOT NULL REFERENCES vehicle(record_id), tag_id TEXT NOT NULL REFERENCES tag(tag_id), PRIMARY KEY(vehicle_id,tag_id));
CREATE TABLE source (source_id INTEGER PRIMARY KEY, vehicle_id TEXT NOT NULL REFERENCES vehicle(record_id), url TEXT NOT NULL, checked_on TEXT, source_note TEXT);
CREATE TABLE alias (vehicle_id TEXT NOT NULL REFERENCES vehicle(record_id), alias TEXT NOT NULL, language TEXT, PRIMARY KEY(vehicle_id,alias));
CREATE INDEX vehicle_kind_idx ON vehicle(record_kind);
CREATE INDEX vehicle_category_idx ON vehicle(vehicle_category);
CREATE INDEX tag_group_idx ON tag(tag_group);
-- Import the accompanying CSV into a staging table, then split pipe-separated fields
-- (gauges_mm, service_roles, service_scale, tags) into normalized child tables.
