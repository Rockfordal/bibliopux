module App.Types where

import Prelude (($), bind, (<>), pure, (<<<))
import Data.Either (Either)
import Data.Argonaut (class DecodeJson, decodeJson, (.?))
import App.Counter as Counter


data Route = HomeR | AboutR | ShelfR | ItemR | NotFoundR

data Action
  = Child (Counter.Action)
  | PageView Route
  | RequestItems
  | ReceiveItems (Either String Items)
  | RequestShelfs
  | ReceiveShelfs (Either String Shelfs)

type State =
  { route  :: Route
  , count  :: Counter.State
  , shelfs :: Shelfs
  , items  :: Items
  , status :: String }


-- Shelfs

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
    pure $ Shelf { id: id, label: label, size: size, position: position, timestamp: timestamp }


-- Items

newtype Item = Item
  { id   :: Int
  , name :: String
  }

type Items = Array Item

instance decodeJsonItem :: DecodeJson Item where
  decodeJson json = do
    obj       <- decodeJson json
    id        <- obj .? "id"
    name      <- obj .? "name"
    pure $ Item { id: id, name: name }
