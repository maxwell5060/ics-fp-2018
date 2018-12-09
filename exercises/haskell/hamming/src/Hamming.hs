module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance [] [] = Just 0
distance [x] [] = Nothing
distance [] [x] = Nothing
distance [x] [y]
    | x == y = Just 0
    | otherwise = Just 1

distance (x:xs) (y:ys)
    | x /= y = 
        case distance xs ys of
            Just n  -> Just (n + 1)
            Nothing -> Nothing
    | otherwise = 
        case distance xs ys of
            Just n  -> Just n
            Nothing -> Nothing