module Hamming (distance, distance2) where

distance :: String -> String -> Maybe Int
distance xs ys =
  if (length xs) /= (length ys)
  then Nothing
  else Just (length $ filter (\(x, y) -> x /= y) (zip xs ys))

-- Old solution

-- distance2 + distance' is also works, but it is just huge
distance2 :: String -> String -> Maybe Int
distance2 xs ys =
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

