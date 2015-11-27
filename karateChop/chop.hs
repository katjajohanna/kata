import Data.List
import Data.Maybe

chop _ [] _ = -1
chop lost_int [x] original_xs = if lost_int == x then fromJust ((lost_int `elemIndex` original_xs)) else -1
chop lost_int xs original_xs = if lost_int `elem` first_half then fromJust ((lost_int `elemIndex` original_xs)) else chop lost_int second_half original_xs
    where
        first_half = take ((length xs) `quot` 2) xs
        second_half = drop ((length xs) `quot` 2) xs

position = chop 1 [2, 3, 1] [2, 3, 1]

chop2 _ [] = False
chop2 lost_int [x] = if lost_int == x then True else False
chop2 lost_int xs = if lost_int `elem` first_half then True else chop2 lost_int second_half
    where
        first_half = take ((length xs) `quot` 2) xs
        second_half = drop ((length xs) `quot` 2) xs

position2 = chop2 1 [2, 3, 1]

main = print position