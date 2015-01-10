Lets follow:

https://hackage.haskell.org/package/sqlite-simple-0.1.0.2/docs/Database-SQLite-Simple.html

    sqlite3 test.db "CREATE TABLE test (id INTEGER PRIMARY KEY, str text);  INSERT INTO test (str) VALUES ('test string');"
    cabal sandbox init
    cabal install -f debug-typed-queries #to see how the magic looks like 
