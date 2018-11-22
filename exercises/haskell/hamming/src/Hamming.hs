module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs ys 
  | (length xs) /= (length ys) = Nothing
  | otherwise = hamming 0 xs ys
    where
      hamming count [] [] = Just count
      hamming count (x:xs) (y:ys) = 
        if x /= y
          then hamming (count+1) xs ys
          else hamming count xs ys