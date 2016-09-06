module App.Items where

import Pux.Html (Html, text, td, tr, tbody, th, thead, table, button, div, b) -- h1 p b nav ul li
import Pux.Html.Attributes (key, className)
import Pux.Html.Events (onClick)
import Prelude (($), (<>), const, map, show, (<<<))
import App.Types (Action(..), State, Item(..))


items_v :: State -> Html Action
items_v state =
  div []
  [
    button
      [ className "btn"
      , onClick (const RequestItems) ]
      [ text "Hämta" ]
    -- , b [] [ text state.status ]

  , table
    [ className "table" ]
    [ thead []
      [ tr
        []
        [ th [] [text "Namn"]
        , th [] [text "Info"]
        , th [] [text "Skapad"]
        ]
      ]
    , tbody []
      $ map item_v state.items
    ]
  ]


item_v :: Item -> Html Action
item_v (Item item) =
  tr [ key (show item.id), className "item" ]
     [ td [] [text item.name]
     , td [] [text item.info]
     , td [] [text item.timestamp]
     ]
