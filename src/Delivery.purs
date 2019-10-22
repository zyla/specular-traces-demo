module Delivery where

import Prelude

import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Uncurried (runEffectFn2)
import Specular.Dom.Widget (runMainWidgetInBody)
import Specular.FRP (annotateDyn, newDynamic, subscribeDyn_)
import Specular.Profiling (measureEffect)
import Utils (annotateDyn', annotateFn)

main :: Effect Unit
main = runMainWidgetInBody do
  store_ <- annotateDyn' "store" <$> newDynamic []
  let computed =
        annotateDyn "computed" $
          map (annotateFn "heavy" (map (_ + 1))) store_.dynamic

  subscribeDyn_ (\_ -> runEffectFn2 measureEffect "label 1" (pure unit)) computed
  subscribeDyn_ (\_ -> runEffectFn2 measureEffect "label 2" (pure unit)) computed
  subscribeDyn_ (\_ -> runEffectFn2 measureEffect "label 3" (pure unit)) computed

  liftEffect do
    runEffectFn2 measureEffect "update store" do
      store_.set [1,2,3]
