package db

import (
	"database/sql"
	"log"
	"time"

	// Importing the MySQL driver package.
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/mattn/go-sqlite3"
)

func Database() {
	var err error
	var db *sql.DB

	const file = "temp.db?cache=shared&mode=memory&_txlock=immediate" +
		"&_foreign_keys=on&_journal_mode=WAL&_synchronous=normal"

	if pingErr := db.Ping(); pingErr != nil {
		db.Close()
		_, err = sql.Open("sqlite3", "file:"+file)
		if err != nil {
			log.Fatal(err)
		}
	}

	db, err = sql.Open("mysql", "root:password@tcp(localhost:3306)/db?timeout=90s&collation=utf8mb4_unicode_ci")

	if err != nil {
		log.Fatal(err)
	}
	const connMaxLifetimeMinutes = 3

	db.SetConnMaxLifetime(time.Minute * connMaxLifetimeMinutes)
	db.SetMaxOpenConns(1)
	db.SetMaxIdleConns(1)
}
