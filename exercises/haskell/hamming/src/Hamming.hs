module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs ys = 
    if length xs /= length ys 
        then 
            error "Len(x) != Len(y). Please enter strings with equal lengths"
    else 
        Just (
            length (
                filter id (
                    zipWith (/=) xs ys
                )
            )
        )
