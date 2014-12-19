{-# Language TemplateHaskell #-}

module Database.SQLite.Simple.TypedQuery
( genJsonQuery
, genTypedQuery
, TQ.genUncurry
, TQ.TypedQuery(..)
, S.Query
)
where

import qualified Database.SQLite.Simple.Internal       as S -- (Connection)
import qualified Database.SQLite.Simple.Types as S -- (fromQuery)
import qualified Database.SQLite.Simple       as S -- (query, query_, execute, execute_, Only(..), In(..), connect, Query)
import Database.SQLite.Simple.DBmore()
import qualified Database.TypedQuery.Types as TQ
import Language.Haskell.TH.Syntax (Q, Exp, Lift(..))
-- import Data.ByteString.UTF8 (toString)
import Prelude ( (.), id)


 
-- > query c "select * from whatever where id in ?" (Only (In [3,4,5]))
{-- 
newtype In a = In a
    deriving (Eq, Ord, Read, Show, Typeable, Functor)

instance (Param a) => Param (In [a]) where
    toRow (In []) = toRow [S.Null]
    toRow (In xs) = toRow xs
--}
--        Plain (fromChar '(') :
--        (intersperse (Plain (fromChar ',')) . map toRow $ xs) ++
--        [Plain (fromChar ')')]

{--
-- | Wrap a mostly-binary string to be escaped in hexadecimal.
newtype Binary a = Binary a
    deriving (Eq, Ord, Read, Show, Typeable, Functor)
--}
-- Move this somewhere
instance Lift S.Query where
  lift = lift . S.fromQuery

instance TQ.RunDB S.Query where
  rdquery  _   = 'S.query
  rdquery_ _   = 'S.query_
  rdexecute_ _ = 'S.execute_
  rdexecute  _ = 'S.execute
  rdin       _ = 'id
  rdonly     _ = 'S.Only
  rdconn     _ = ''S.Connection

genJsonQuery :: TQ.TypedQuery S.Query -> Q Exp
genJsonQuery = TQ.genJsonQuery

genTypedQuery :: TQ.TypedQuery S.Query -> Q Exp
genTypedQuery = TQ.genTypedQuery
