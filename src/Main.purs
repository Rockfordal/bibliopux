module Main where

import App.Routes (match)
import App.Layout (Action(PageView), State, view, update)
import Control.Bind ((=<<))
import Control.Monad.Eff (Eff)
import DOM (DOM)
import Prelude (bind, pure)
import Pux (App, Config, CoreEffects, fromSimple, renderToDOM, start)
import Pux.Devtool (Action, start) as Pux.Devtool
import Pux.Router (sampleUrl)
import Signal ((~>))
import Network.HTTP.Affjax (AJAX, get)

type AppEffects = (dom :: DOM, ajax :: AJAX)

config :: forall eff.  State -> Eff
             ( dom :: DOM | eff)
             (Config State Action AppEffects)


config state = do
  urlSignal <- sampleUrl

  let routeSignal = urlSignal ~> \r -> PageView (match r)

  pure
    { initialState: state
    , update: update
    , view: view
    , inputs: [routeSignal]
    }


main :: State -> Eff (CoreEffects AppEffects) (App State Action)
main state = do
  app <- start =<< (config state)
  renderToDOM "#app" app.html
  pure app


debug :: State -> Eff (CoreEffects AppEffects) (App State (Pux.Devtool.Action Action))
debug state = do
  app <- Pux.Devtool.start =<< config state
  renderToDOM "#app" app.html
  pure app
