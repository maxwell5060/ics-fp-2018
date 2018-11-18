module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs ys
    | length xs /= length ys = Nothing
    | otherwise = Just $ hamming xs ys 0

hamming :: String -> String -> Int -> Int
hamming [] _ n = n
hamming _ [] n = n
hamming (x:xs) (y:ys) n
    | x == y    = hamming xs ys n
    | otherwise = hamming xs ys (n+1)