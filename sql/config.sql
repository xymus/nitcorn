CREATE TABLE Config (
    name TEXT NOT NULL PRIMARY KEY,
    error_path TEXT,
    access_path TEXT,
    info_path TEXT,
    debug_path TEXT,
    verbose_path TEXT,
    warning_path TEXT,
    wtf_path TEXT
);

CREATE TABLE VirtualHost (
    virtual_host TEXT PRIMARY KEY NOT NULL,
    ip INTEGER,
    port INTEGER,
    alias TEXT
);

CREATE TABLE Host (
    host TEXT PRIMARY KEY NOT NULL,
    base_root TEXT
);
