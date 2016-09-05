module Kalk where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.JQuery (JQuery)
import DOM (DOM)


foreign import kalka :: Number -> Number

foreign import msg :: String

foreign import hej :: String

foreign import data ALERT :: !

foreign import alert :: forall eff. String -> Eff (alert :: ALERT | eff) Unit

foreign import leanmodal :: forall eff. JQuery -> Eff (dom :: DOM | eff) Unit

foreign import openleanmodal :: forall e. Eff (dom :: DOM | e) JQuery
