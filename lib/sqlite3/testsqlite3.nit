module testsqlite3

import sqlite3

fun delete_file is extern `{
	unlink("test.db");
`}

delete_file
var filename = "test.db"
var create_req : String = "CREATE TABLE IF NOT EXISTS users (uname TEXT PRIMARY KEY, pass TEXT NOT NULL, activated INTEGER)"
var insert_req_1 : String = "INSERT INTO users VALUES('Bob', 'zzz', 1)"
var insert_req_2 : String = "INSERT INTO users VALUES('Guillaume', 'xxx', 1)"
var select_req : String = "SELECT * FROM users"

var db : Sqlite3 = new Sqlite3

db.open(filename)
assert sqlite_open: db.get_error == 0

db.exec(create_req)
assert sqlite_create_table: db.get_error == 0

db.exec(insert_req_1)
assert sqlite_insert_1: db.get_error == 0

db.exec(insert_req_2)
assert sqlite_insert_2: db.get_error == 0

db.prepare(select_req)
assert sqlite_select: db.get_error == 0


# Get first row
db.step
assert sqlite_column_0_0: db.column_text(0) == "Bob"
assert sqlite_column_0_1: db.column_text(1) == "zzz"
assert sqlite_column_0_2: db.column_text(2) == "1"
db.step
assert sqlite_column_1_0: db.column_text(0) == "Guillaume"
assert sqlite_column_1_1: db.column_text(1) == "xxx"
assert sqlite_column_1_2: db.column_text(2) == "1"

db.close


db = new Sqlite3
db.open(filename)
assert sqlite_reopen: db.get_error == 0

db.prepare(select_req)
assert sqlite_reselect: db.get_error == 0
db.step
assert sqlite_column_0_0_reopened: db.column_text(0) == "Bob"

