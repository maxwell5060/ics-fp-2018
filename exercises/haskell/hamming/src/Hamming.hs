module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs ys =
  if (length xs) /= (length ys)
  then Nothing
  else Just (distance' xs ys 0)

-- distance' gets validated data, e.g. lists of the same length
distance' :: String -> String -> Int -> Int
distance' [] [] acc = acc
distance' (x:xs) (y:ys) acc =
  if x == y
  then distance' xs ys acc
  else distance' xs ys (1 + acc)
