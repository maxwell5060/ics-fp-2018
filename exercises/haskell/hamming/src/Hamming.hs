module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance str1 str2 = distance' str1 str2 0
    where 
        distance' [] [] c = Just c
        distance' xs [] _ = Nothing
        distance' [] ys _ = Nothing 
        distance' (x:xs) (y:ys) c | x /= y = distance' xs ys (c + 1)
                                 | otherwise = distance' xs ys c


                    