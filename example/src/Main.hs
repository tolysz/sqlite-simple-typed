 {-# LANGUAGE OverloadedStrings
            , TemplateHaskell
            , QuasiQuotes
            #-}
module Main where

import Database.SQLite.Simple
import Database.SQLite.Simple.TypedQuery
import Data.String.QM

hello =  $(genTypedQuery [qq|select (2 + 2) as sum -- Int |]) =<< open "test.db"

hello2 =  $(genTypedQuery [qq|
        select id  -- Int
             , str -- String
         from test
    |] ) =<< open "test.db"

ins = flip $(genTypedQuery [qq|
     INSERT INTO 
         test ( str -- String
              )
   |] ) "test string 2" =<< open "test.db"


main = do
   ins
   putStrLn "Me say hallo"
   print =<< hello
   print =<< hello2
