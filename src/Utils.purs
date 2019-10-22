module Utils where

import Specular.FRP (annotateDyn)

foreign import annotateFn :: forall a b. String -> (a -> b) -> a -> b

annotateDyn' name x = x { dynamic = annotateDyn name x.dynamic }
