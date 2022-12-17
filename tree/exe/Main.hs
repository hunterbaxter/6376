module Main where

import Hb (Tree, fromList, inOrder, postOrder, preOrder, singleton, sumTree, treeInsert)

main :: IO ()
main = do
  putStrLn "See asci tree in exe/Main.hs"
  putStrLn "In order list"
  print (inOrder exTreeInt)
  putStrLn "pre order list"
  print (preOrder exTreeInt)
  putStrLn "post order list"
  print (postOrder exTreeInt)
  print (sumTree exTreeInt)

exTreeInt :: Tree Int
exTreeInt = fromList [7, 5, 3, 1, 6, 2, 4]

--         4
--       /  \
--      2    6
--     / \  / \
--    1  3 5   7
