module Hamming (distance) where

dist r [] [] = Just r
dist r (x:xs) (y:ys) | length xs /= length ys = Nothing
					 | x == y = dist r xs ys
					 | x /= y = dist (r + 1) xs ys
distance :: String -> String -> Maybe Int
distance xs ys = dist 0 xs ys