module Form where

import Prelude

import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Uncurried (runEffectFn2)
import Record.Extra (sequenceRecord)
import Specular.Dom.Widget (runMainWidgetInBody)
import Specular.FRP (annotateDyn, newDynamic, subscribeDyn_)
import Specular.Profiling (measureEffect)
import Utils (annotateDyn')

main :: Effect Unit
main = runMainWidgetInBody do
  name  <- annotateDyn' "name"  <$> newDynamic "Jan"
  phone <- annotateDyn' "phone" <$> newDynamic "123123123"
  age   <- annotateDyn' "age"   <$> newDynamic 7

  let result = annotateDyn "{name,phone,age}" $
                 sequenceRecord {name: name.dynamic, phone: phone.dynamic, age: age.dynamic}

  subscribeDyn_ (\_ -> runEffectFn2 measureEffect "handler" (pure unit)) result

  liftEffect do
    runEffectFn2 measureEffect "name <- Krzysztof" do
      name.set "Krzysztof"

    runEffectFn2 measureEffect "phone <- 9999" do
      phone.set "999"
