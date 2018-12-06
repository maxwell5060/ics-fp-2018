module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs ys = 
  if length xs /= length ys 
    then Nothing
  else 
    Just (count xs ys)
    where
    count :: String -> String -> Int
    count [] [] = 0
    count (xh:xt) (yh:yt) = 
      if xh /= yh
        then (count xt yt) + 1
      else
        count xt yt
