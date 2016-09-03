module App.State where

import App.Types
import App.Counter as Counter
import Prelude (($), bind, show, (<>), pure, (<<<))
import Pux (EffModel, noEffects)
import DOM (DOM)
import Network.HTTP.Affjax (AJAX, get)
import Data.Either (Either(Left, Right), either)
import Control.Monad.Aff (attempt)
import Data.Argonaut (decodeJson)


init :: State
init =
  { route: NotFoundR
  , count: Counter.init
  , shelfs: []
  , items:  []
  , status: "Klicka för att hämta data"
  }


update :: Action -> State -> EffModel State Action (dom :: DOM, ajax :: AJAX)
update (PageView route) state = { state: state { route = route }, effects: [] }

update (Child action) state   = { state: state { count = Counter.update action state.count }, effects: [] }

update (ReceiveShelfs (Left err)) state =
  noEffects $ state { status = "Error fetching shelfs: " <> show err }

update (ReceiveShelfs (Right shelfs)) state =
  noEffects $ state { shelfs = shelfs, status = "Hyllor" }

update (RequestShelfs) state =
  { state: state { status = "Hämtar hyllor..." }
  , effects: [ do
      res <- attempt $ get "http://localhost:3000/shelfs"
      let decode r = decodeJson r.response :: Either String Shelfs
      let shelfs = either (Left <<< show) decode res
      pure $ ReceiveShelfs shelfs
    ]
  }

update (ReceiveItems (Left err)) state =
  noEffects $ state { status = "Error fetching items: " <> show err }

update (ReceiveItems (Right items)) state =
  noEffects $ state { items = items, status = "Artiklar" }

update (RequestItems) state =
  { state: state { status = "Hämtar artiklar..." }
  , effects: [ do
      res <- attempt $ get "http://localhost:3000/items"
      let decode r = decodeJson r.response :: Either String Items
      let items = either (Left <<< show) decode res
      pure $ ReceiveItems items
    ]
  }

