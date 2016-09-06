module App.Types where

import Prelude (($), bind, (<>), pure, (<<<))
import Data.Either (Either)
import Data.Argonaut (class DecodeJson, decodeJson, (.?))
import App.Counter as Counter
import App.Cal as Cal


data Route = HomeR | AboutR | ShelfR | ItemR | NotFoundR
-- | CalR

data Action
  -- = ChildCount (Counter.Action)
  = ChildCal (Cal.Action)
  | PageView Route
  | RequestItems
  | ReceiveItems (Either String Items)
  | RequestShelfs
  | ReceiveShelfs (Either String Shelfs)

type State =
  { route    :: Route
  -- , count    :: Counter.State
  , calinfo  :: Cal.State
  , shelfs   :: Shelfs
  , items    :: Items
  , status   :: String }


newtype Shelf = Shelf
  { id        :: Int
  , label     :: String
  , size      :: Int
  , position  :: String
  , timestamp :: String
  }

type Shelfs = Array Shelf

instance decodeJsonShelf :: DecodeJson Shelf where
  decodeJson json = do
    obj       <- decodeJson json
    id        <- obj .? "id"
    label     <- obj .? "label"
    size      <- obj .? "size"
    position  <- obj .? "position"
    timestamp <- obj .? "timestamp"
    pure $ Shelf { id: id, label:label, size:size, position:position, timestamp:timestamp }


-- Items

newtype Item = Item
  { id        :: Int
  , name      :: String
  , info      :: String
  , timestamp :: String
  }

type Items = Array Item

instance decodeJsonItem :: DecodeJson Item where
  decodeJson json = do
    obj       <- decodeJson json
    id        <- obj .? "id"
    name      <- obj .? "name"
    info      <- obj .? "info"
    timestamp <- obj .? "timestamp"
    pure $ Item { id: id, name:name, info:info, timestamp:timestamp }
