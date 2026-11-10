-- Einmalig auf derselben D1-Datenbank wie solar_connections ausführen.
CREATE TABLE IF NOT EXISTS easee_connections (
  uid TEXT PRIMARY KEY NOT NULL,
  encrypted_refresh_token TEXT NOT NULL,
  iv TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
