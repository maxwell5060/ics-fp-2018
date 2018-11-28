module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance (h1:t1) (h2:t2) | h1 /= h2 = fmap (+1) func
                         | otherwise = func
    where func = distance t1 t2
distance [] [] = Just 0
distance _ _ = Nothing