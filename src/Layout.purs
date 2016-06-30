module App.Layout where

import App.Counter as Counter
import App.NotFound as NotFound
import App.Routes (Route(Home, NotFound))
import Prelude (($), bind, map, const, show, (<>), pure, (<<<))
import Pux.Html (Html, text, td, tr, tbody, th, thead, table, button, div, h1, p)
import Pux.Html.Attributes (key, className)
import Pux.Html.Events (onClick)
import Pux (EffModel, noEffects)
import Data.Argonaut (class DecodeJson, decodeJson, (.?))
import Data.Either (Either(Left, Right), either)
import Network.HTTP.Affjax (AJAX, get)
import Control.Monad.Aff (attempt)
import DOM (DOM)


data Action
  = Child (Counter.Action)
  | PageView Route
  | RequestBooks
  | ReceiveBooks (Either String Books)

type State =
  { route :: Route
  , count :: Counter.State
  , books :: Books
  , status :: String }

type Books = Array Book

newtype Book = Book
  { id :: Int
  , author :: String
  , title :: String
  , content :: String
  , year :: Int }


init :: State
init =
  { route: NotFound
  , count: Counter.init
  , books: []
  , status: "Klicka för att hämta data" }


-- | Decode our Book JSON we receive from the server
instance decodeJsonBook :: DecodeJson Book where
  decodeJson json = do
    obj     <- decodeJson json
    id      <- obj .? "id"
    author  <- obj .? "author"
    title   <- obj .? "title"
    content <- obj .? "content"
    year    <- obj .? "year"
    pure $ Book { id: id, author: author, title: title, content: content, year: year }


update :: Action -> State -> EffModel State Action (dom :: DOM, ajax :: AJAX)
update (PageView route) state = { state: state { route = route }, effects: [] }
update (Child action) state =  { state: state { count = Counter.update action state.count }, effects: [] }
update (ReceiveBooks (Left err)) state =
  noEffects $ state { status = "Error fetching books: " <> show err }
update (ReceiveBooks (Right books)) state =
  noEffects $ state { books = books, status = "Böcker" }
update (RequestBooks) state =
  { state: state { status = "Hämtar böcker..." }
  , effects: [ do
      res <- attempt $ get "http://localhost:3000/books"
      let decode r = decodeJson r.response :: Either String Books
      let books = either (Left <<< show) decode res
      pure $ ReceiveBooks books
    ]
  }


view :: State -> Html Action
view state =
  div []
    [ h1 [] [ text "Pux Starter App" ]
    , p  [] [ text "hot-code-reloading." ]
    , case state.route of
        Home -> map Child $ Counter.view state.count
        NotFound -> NotFound.view state
    , h1 [] [ text state.status ]
    , div
      []
      [ button
        [ className "btn"
        , onClick (const RequestBooks) ]
        [ text "Hämta data" ]
      , table
        [ className "table" ]
        [ thead []
          [ tr
            []
            [ th [] [text "Författare"]
            , th [] [text "Titel"]
            , th [] [text "Årtal"]
            , th [] [text "Innehåll"]
            ]
          ]
        , tbody []
          $ map book state.books
        ]
      ]
    ]


book :: Book -> Html Action
book (Book state) =
  tr [ key (show state.id), className "book" ]
     [ td [] [text state.author]
     , td [] [text state.title]
     , td [] [text (show state.year)]
     , td [] [text state.content]
     ]
