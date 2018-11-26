module Hamming (distance) where

distance :: String -> String -> Int
distance xs ys = if ((length xs == length ys) && (length xs > 0) && (length ys > 0))
				then hammingTemp xs ys 0
				else 0


hammingTemp :: String -> String -> Int -> Int
hammingTemp xs ys cont = if(length xs > 0)
						then 
							if (head xs /= head ys)
							then hammingTemp (tail xs) (tail ys) (cont + 1)
							else hammingTemp (tail xs) (tail ys) (cont)
						else
							cont
