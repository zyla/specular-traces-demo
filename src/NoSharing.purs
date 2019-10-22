module NoSharing where

import Prelude

import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Uncurried (runEffectFn2)
import Specular.Dom.Widget (runMainWidgetInBody)
import Specular.FRP (newEvent, subscribeEvent_, annotateEvent)
import Specular.Profiling (measureEffect)
import Utils (annotateFn)

main :: Effect Unit
main = runMainWidgetInBody do
  e <- newEvent
  let root = annotateEvent "root" e.event
  let mapped = annotateEvent "map (+1)" $ map (annotateFn "+1" (_ + 1)) root

  -- subscribe twice
  subscribeEvent_ (\_ -> runEffectFn2 measureEffect "handler 1" (pure unit)) mapped
  subscribeEvent_ (\_ -> runEffectFn2 measureEffect "handler 2" (pure unit)) mapped

  liftEffect $ e.fire 2
