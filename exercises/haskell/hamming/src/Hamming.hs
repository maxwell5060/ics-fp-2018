module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs ys = compare 0 xs ys
	where
		compare n [] [] = Just n
		compare n [] ys = Nothing
		compare n xs [] = Nothing
		compare n (head1:tail1) (head2:tail2) =
			if head1 /= head2
				then compare (n+1) tail1 tail2
				else compare n tail1 tail2
