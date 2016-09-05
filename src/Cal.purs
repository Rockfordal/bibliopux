module App.Cal where

import Prelude ((+), (-), const, show, pure, bind, ($)) -- (<>), (<<<))
import Pux.Html (Html, div, span, button, text, h4, p, a)
import Pux.Html.Attributes (className, id_, href)
import Pux.Html.Events (onClick)
import Pux (EffModel, noEffects)
import DOM (DOM)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Class (liftEff)
import Network.HTTP.Affjax (AJAX, get)

data Action = ShowModal
--| Nada

type State = { id :: Int }

init :: State
init = { id: 0 }


-- update :: Action -> State -> State
-- update ShowModal state = state + 1

-- update :: Action -> State -> EffModel State Action (dom :: DOM, con :: CONSOLE)
update :: Action -> State -> EffModel State Action (dom :: DOM, ajax :: AJAX)

-- update Nada state =
--   noEffects $ state { id = 1 }

update ShowModal state =
  -- noEffects $ state { id = 2 }
  { state: state { id = 0 }
  , effects: []
  }

-- update ShowModal state =
--   { state: state { id = 0 }
--   , effects: [ do
--       -- res <- attempt $ get "http://localhost:3000/shelfs"
--       -- let decode r = decodeJson r.response :: Either String Shelfs
--       -- let shelfs = either (Left <<< show) decode res
--       -- pure $ ReceiveShelfs shelfs
--       -- pure "yes sir"
--       -- liftEff $ log "Hello sailor"
--       pure $ Nada
--     ]
--   }

view :: State -> Html Action
view state =
  div []
    [
      -- span [] [ text (show state) ]
      -- , button [ onClick (const ShowModal) ] [ text "Visa Modal" ]
      div [ id_ "modal1", className "modal" ]
      [ div [ className "modal-content"]
        [ h4 [] [ text "Modal Header"]
        , p [] [ text "A bunch of text"]
        ]
      , div [ className "modal-footer"]
        [ a [ href "#!", className "modal-action modal-close waves-effect waves-green btn-flat"] [ text "Agree" ]
        ]
      ]
    , a [ className "waves-effect waves-light btn modal-trigger", href "#modal1"] [ text "Modal1" ]
    ]

  -- <a class="waves-effect waves-light btn modal-trigger" href="#modal1">Modal</a>

  -- <div id="modal1" class="modal">
  --   <div class="modal-content">
  --     <h4>Modal Header</h4>
  --     <p>A bunch of text</p>
  --   </div>
  --   <div class="modal-footer">
  --     <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Agree</a>
  --   </div>
  -- </div>
