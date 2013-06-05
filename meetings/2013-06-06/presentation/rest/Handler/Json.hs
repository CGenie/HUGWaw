module Handler.Json where

import Import

import Yesod.Core.Json

import qualified Data.Text as T

getJsonR :: Handler TypedContent
getJsonR = do
         let widget = [whamlet|Pure HTML|]
         let json = object ["name" .= String "JSON"]
         defaultLayoutJson widget (returnJson json)
