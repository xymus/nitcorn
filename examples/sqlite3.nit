import sqlite3
var db : Sqlite3 = new Sqlite3 # init

var req : String = "CREATE TABLE IF NOT EXISTS users (uname TEXT PRIMARY KEY, pass TEXT NOT NULL, activated INTEGER)"
var req1 : String = "INSERT INTO users VALUES('Bob', 'zzzzzzzzz', 1)"
var req2 : String = "INSERT INTO users VALUES('Guillaume', 'xxxxxxxxxx', 1)"
var fet : String = "SELECT * FROM users"

# Open the DB file
db.open("bob")

# Create DB
db.exec(req)

# Insert data
db.exec(req1)
db.exec(req2)

# Select *
db.prepare(fet)

# Get first row
db.step
print db.column_text(0)
print db.column_text(1)
print db.column_text(2)
# Get next row
db.step
print db.column_text(0)
print db.column_text(1)
print db.column_text(2)

