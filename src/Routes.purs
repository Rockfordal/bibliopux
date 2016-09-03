module App.Routes where

import App.Types
import Data.Functor ((<$))
import Control.Apply ((<*), (*>))
import Control.Alt ((<|>))
import Data.Maybe (fromMaybe)
import Pux.Router (param, router, lit, int, end)
import Prelude (($), (<$>))


match :: String -> Route
match url = fromMaybe NotFoundR $ router url $
  HomeR <$ end
  <|>
  AboutR <$ (lit "about") <* end
  <|>
  ShelfR <$ (lit "shelfs") <* end
  <|>
  ItemR <$ (lit "items") <* end
  -- Shelfs <$> (lit "shelfs" *> param "sortBy") <* end
