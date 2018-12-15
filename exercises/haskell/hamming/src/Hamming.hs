module Hamming (distance) where

--declare function distance and describe its args
distance :: String -> String -> Maybe Int
--if strings have different lengths -> return Nothing (can't evaluate Hamming distance)
--otherwise (any else aren't true) we start counting Hamming distance from 0
distance xs ys  | (length xs) /= (length ys) = Nothing | otherwise = dist 0 xs ys                
  where
--starting implementation -> little bit kind of Prolog algs =)
--returning when there are empty lists left
    dist counter [] [] = Just counter
--take elem from every string
    dist counter (x:xs) (y:ys) = 
--checking these elements for equality
      if x /= y
        then dist (counter+1) xs ys
      else dist counter xs ys
