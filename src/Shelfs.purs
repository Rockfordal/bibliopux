module App.Shelfs where

import Pux.Html (Html, text, td, tr, tbody, th, thead, table, button, div, b) -- h1 p b nav ul li
import Pux.Html.Attributes (key, className)
import Pux.Html.Events (onClick)
import Prelude (($), (<>), const, map, show, (<<<))
import App.Types (Action(..), State, Shelf(..))


shelfs_v :: State -> Html Action
shelfs_v state =
  div []
  [
    button
      [ className "btn"
      , onClick (const RequestShelfs) ]
      [ text "Hämta data" ]
    -- , b [] [ text state.status ]
  , table
    [ className "table" ]
    [ thead []
      [ tr
        []
        [ th [] [text "Etikett"]
        , th [] [text "Storlek"]
        , th [] [text "Position"]
        , th [] [text "Timestamp"]
        ]
      ]
    , tbody []
      $ map shelf_v state.shelfs
    ]
  ]


shelf_v :: Shelf -> Html Action
shelf_v (Shelf shelf) =
  tr [ key (show shelf.id), className "shelf" ]
     [ td [] [text shelf.label]
     , td [] [text (show shelf.size)]
     , td [] [text shelf.position]
     , td [] [text shelf.timestamp]
     ]
