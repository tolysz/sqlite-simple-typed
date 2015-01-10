Lets follow:

https://hackage.haskell.org/package/sqlite-simple-0.1.0.2/docs/Database-SQLite-Simple.html

    sqlite3 test.db "CREATE TABLE test (id INTEGER PRIMARY KEY, str text);  INSERT INTO test (str) VALUES ('test string');"
    
    cabal sandbox init
    cabal install -f debug-typed-queries typedquery
    cabal install


The generated queries will be output on the console during compilation ( if you do not `-j` it)
And for our example will look like:


     SELECT( 2 + 2) AS sum
          
    []
    [("sum",TACast "Int ")]
    []
    \ conn_0 ->
      GHC.Base.fmap
        (GHC.Base.map
           (\ (!(Database.SQLite.Simple.Types.Only a_1)) -> a_1 :: Int))
        (Database.SQLite.Simple.query_
           (conn_0 :: Database.SQLite.Simple.Internal.Connection)
           " SELECT( 2 + 2) AS sum\n      ")


Sql stripped of comments

     SELECT( 2 + 2) AS sum


Internal structure

    []
    [("sum",TACast "Int ")]
    []
    
Generated `haskell` function 

    \ conn_0 ->
      GHC.Base.fmap
        (GHC.Base.map
           (\ (!(Database.SQLite.Simple.Types.Only a_1)) -> a_1 :: Int))
        (Database.SQLite.Simple.query_
           (conn_0 :: Database.SQLite.Simple.Internal.Connection)
           " SELECT( 2 + 2) AS sum\n      ")



And the other:

     SELECT id
          , str
           FROM test
    []
    [("id",TACast "Int"),("str",TACast "String")]
    []
    \ conn_0 ->
      GHC.Base.fmap
        (GHC.Base.map (\ (!a_1, !a_2) -> (a_1 :: Int, a_2 :: String)))
        (Database.SQLite.Simple.query_
           (conn_0 :: Database.SQLite.Simple.Internal.Connection)
           " SELECT id\n      , str\n       FROM test")
    
     INSERT INTO test (str)  VALUES ( ? );
    [TAInsQM]
    []
    [TACast "String"]
    \ conn_0 qp_1 ->
      Database.SQLite.Simple.execute
        (conn_0 :: Database.SQLite.Simple.Internal.Connection)
        " INSERT INTO test (str)  VALUES ( ? );"
        ((\ (!i_2) -> Database.SQLite.Simple.Types.Only (i_2 :: String))
           qp_1)
    
     INSERT INTO test (str)  VALUES ( ? );
    [TAInsIS "\"test string inlined\""]
    []
    [TACast "String "]
    \ conn_0 ->
      Database.SQLite.Simple.execute
        (conn_0 :: Database.SQLite.Simple.Internal.Connection)
        " INSERT INTO test (str)  VALUES ( ? );"
        (Database.SQLite.Simple.Types.Only
           ("test string inlined" :: String))
    
     INSERT INTO test (str)  VALUES ( ? );
    [TAInsIS "s"]
    []
    []
    \ conn_0 ->
      Database.SQLite.Simple.execute_
        (conn_0 :: Database.SQLite.Simple.Internal.Connection)
        " INSERT INTO test (str)  VALUES ( ? );"
