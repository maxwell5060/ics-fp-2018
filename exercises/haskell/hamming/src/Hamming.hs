module Hamming (distance) where

distance :: String -> String -> Maybe Integer
distance str1 str2 = let (f, s) = foldl (\(c, xs) x -> case xs of
                                           []              -> (Nothing, [])
                                           (y:ys) | y /= x -> ((+1) <$> c, ys)
                                           (y:ys)          -> (c, ys)
                                        ) (Just 0, str1) str2
                     in case s of
                        [] -> f
                        _  -> Nothing
