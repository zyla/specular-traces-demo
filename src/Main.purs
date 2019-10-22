module Main where

import Prelude

import Effect (Effect)
import Specular.Dom.Builder.Class (text)
import Specular.Dom.Widget (runMainWidgetInBody)

main :: Effect Unit
main = runMainWidgetInBody do
  text "Hello"
