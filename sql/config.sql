CREATE TABLE Config (
    _id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    log_id INTEGER
);

CREATE TABLE LogPaths (
    _id INTEGER NOT NULL PRIMARY KEY,
    error_path TEXT,
    access_path TEXT,
    info_path TEXT,
    debug_path TEXT,
    verbose_path TEXT,
    warning_path TEXT,
    wtf_path TEXT
);

CREATE TABLE VirtualHost (
    _id INTEGER NOT NULL PRIMARY KEY,
    config_id INTEGER,
    name TEXT NOT NULL,
    ip INTEGER,
    port INTEGER,
    alias TEXT,
    host_id INTEGER
);

CREATE TABLE Host (
    _id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    root TEXT
);
