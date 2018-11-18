module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs ys
    |(length xs) /= (length ys) = Nothing
    |otherwise              = Just $ hammingDis xs ys
hammingDis xs ys = length([el | el <- zipWith (/=) xs ys, el == True])
