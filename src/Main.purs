module Main where

import App.Routes (match)
import App.Types (State, Action(..))
import App.State (update)
import App.Layout (view)
import Control.Bind ((=<<))
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import DOM (DOM)
import Prelude (bind, pure)
import Pux (App, Config, CoreEffects, renderToDOM, start) -- fromSimple
import Pux.Devtool (Action, start) as Pux.Devtool
import Pux.Router (sampleUrl)
import Signal ((~>))
import Network.HTTP.Affjax (AJAX) -- get
import Kalk -- (kalka, hej, msg, alert)
type AppEffects = (dom :: DOM, ajax :: AJAX)


config :: forall eff.  State -> Eff
             ( dom :: DOM
             -- , con :: CONSOLE
             | eff)
             (Config State Action AppEffects)


config state = do
  urlSignal <- sampleUrl

  let routeSignal = urlSignal ~> \r -> PageView (match r)

  pure
    { initialState: state
    , update:       update
    , view:         view
    , inputs:       [routeSignal]
    }


main :: State -> Eff (CoreEffects AppEffects) (App State Action)
main state = do
  -- x <- log "Hello sailor"
  openleanmodal
  app <- start =<< (config state)
  renderToDOM "#app" app.html
  pure app


debug :: State -> Eff (CoreEffects AppEffects) (App State (Pux.Devtool.Action Action))
debug state = do
  app <- Pux.Devtool.start =<< config state
  renderToDOM "#app" app.html
  pure app
