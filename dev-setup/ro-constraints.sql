CREATE TABLE target (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  name VARCHAR(16),
  alphabeta INTEGER
  -- NOTE: alphabeta is the alpha/beta ratio * 100 to prevent
  --       floating point approximation
);

CREATE TABLE fractionation (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  description VARCHAR(32),
  fractions_min INTEGER,
  fractions_max INTEGER DEFAULT NULL
);

CREATE TABLE volume_type (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  description VARCHAR(16)
);

CREATE TABLE dose_type (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  description VARCHAR(16)
);

CREATE TABLE intent (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  description VARCHAR(16)
);

CREATE TABLE region (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  target INTEGER NOT NULL REFERENCES target(id),
  fractionation INTEGER NOT NULL REFERENCES fractionation(id),
  intent INTEGER DEFAULT NULL REFERENCES intent(id),
  volume INTEGER DEFAULT NULL,
  -- NOTE: volumes are the volumes * 100 to prevent floating point
  --       approximation
  volume_type INTEGER DEFAULT NULL REFERENCES volume_type(id),
  volume_deviation INTEGER DEFAULT NULL,
  volume_deviation_type INTEGER DEFAULT NULL REFERENCES volume_type(id),
  prv INTEGER DEFAULT NULL,
  -- NOTE: dose are the dose * 100 to prevent floating point
  --       approximation
  dose INTEGER DEFAULT NULL,
  dose_type INTEGER DEFAULT NULL REFERENCES dose_type(id),
  dose_deviation INTEGER DEFAULT NULL,
  dose_deviation_type INTEGER DEFAULT NULL REFERENCES dose_type(id),
  conversion VARCHAR(16) DEFAULT NULL,
  importance VARCHAR(16) DEFAULT NULL
);

CREATE TABLE disease_site (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  description VARCHAR(32)
);

CREATE TABLE region_disease_site (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  region INTEGER REFERENCES region(id),
  disease_site INTEGER REFERENCES disease_site(id)
);

CREATE TABLE protocol (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  name VARCHAR(128) NOT NULL,
  year INTEGER DEFAULT NULL
);

CREATE TABLE region_protocols (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  region INTEGER REFERENCES region(id),
  protocol INTEGER REFERENCES protocol(id)
);

CREATE TABLE publication (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  title VARCHAR(128) DEFAULT NULL,
  doi VARCHAR(32) DEFAULT NULL,
  pubmed VARCHAR(32) DEFAULT NULL
);

CREATE TABLE region_publications (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  region INTEGER REFERENCES region(id),
  publication INTEGER REFERENCES publication(id)
);

CREATE TABLE note (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  region INTEGER REFERENCES region(id),
  text TEXT NOT NULL,
  parent INTEGER REFERENCES note(id)
);

