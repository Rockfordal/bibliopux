module App.Layout where

import App.Counter as Counter
import App.Cal as Cal
import App.NotFound as NotFound
import App.Shelfs (shelfs_v)
import App.Items (items_v)
import App.Types -- (State, Action(..), Route(..))
import Pux.Html (Html, text, h1, li, ul, nav, b, div, br)
import Pux.Router (link)
import Prelude (($), map)



view :: State -> Html Action
view state =
  div []
    [ div [] [ navigation ]
      , br [] []
    -- , b [] [text "hej"]
    , case state.route of
        -- HomeR     -> map ChildCount $ Counter.view state.count
        HomeR     -> home_v
        -- CalR      -> map ChildCal $ Cal.view state.calinfo
        AboutR    -> about_v
        ShelfR    -> shelfs_v state
        ItemR     -> items_v state
        NotFoundR -> NotFound.view state
    ]


navigation :: Html Action
navigation =
  nav
    []
    [ ul
      []
      [ li [] [ link "/"       [] [ text "Home" ] ]
      , li [] [ link "/cal"    [] [ text "Kalender" ] ]
      , li [] [ link "/shelfs" [] [ text "Hyllor" ] ]
      , li [] [ link "/items"  [] [ text "Items" ] ]
      , li [] [ link "/about"  [] [ text "Om" ] ]
      ]
    ]

home_v :: Html Action
home_v =
  h1 [] [ text "Hem" ]

about_v :: Html Action
about_v =
  div []
  [ h1 [] [ text "Om oss" ]
  , li [] [ link "/sdfsdf" [] [ text "Not found" ] ]
  ]
