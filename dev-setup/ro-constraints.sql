CREATE TABLE target (
  id INTEGER PRIMARY KEY NOT NULL AUTOINCREMENT,
  name VARCHAR(16),
  alphabeta INTEGER
  -- NOTE: alphabeta is the alpha/beta ratio * 100 to prevent
  --       floating point approximation
);

CREATE TABLE regions (
  id INTEGER PRIMARY KEY NOT NULL AUTOINCREMENT,
  target INTEGER NOT NULL REFERENCES target.id,


);


