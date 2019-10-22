module Utils where

foreign import annotateFn :: forall a b. String -> (a -> b) -> a -> b
