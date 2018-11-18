module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs ys
    | len_xs == len_ys = Just dist
    | otherwise = Nothing
    where
        initDist = 0
        len_xs = length xs
        len_ys = length ys
        dist = hamming xs ys initDist

hamming :: String -> String -> Int -> Int
hamming [] [] d = d
hamming (x:xs) (y:ys) d
    | x /= y = incrHamming
    | otherwise = currHamming
    where
        incrHamming = hamming xs ys d+1
        currHamming = hamming xs ys d
