CREATE TABLE LogPaths (
    _id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    error_path TEXT,
    access_path TEXT,
    info_path TEXT,
    debug_path TEXT,
    verbose_path TEXT,
    warning_path TEXT,
    wtf_path TEXT
);

CREATE TABLE Config (
    _id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    log_id INTEGER NOT NULL,
    FOREIGN KEY(log_id) REFERENCES LogPaths(_id)
);

CREATE TABLE Host (
    _id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
);

CREATE TABLE VirtualHost (
    _id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    config_id INTEGER NOT NULL,
    name TEXT NOT NULL UNIQUE,
    port INTEGER NOT NULL,
    root TEXT NOT NULL,
    FOREIGN KEY(config_id) REFERENCES Config(_id),
);

CREATE TABLE Alias (
    _id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    virtualhost_id INTEGER NOT NULL,
    name TEXT NOT NULL UNIQUE,
    FOREIGN KEY(virtualhost_id) REFERENCES VirtualHost(_id)
);

