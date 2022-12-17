module Hb (gcd, Tree, fromList, treeInsert, singleton, inOrder, postOrder, preOrder, sumTree) where

data Tree a = Nil | Node (Tree a) a (Tree a)
  deriving (Show, Read, Eq)

mirror :: Tree a -> Tree a
mirror Nil = Nil
mirror (Node left value right) = Node (mirror right) value (mirror left)

fromList :: (Ord a) => [a] -> Tree a
fromList [] = Nil
fromList [x] = singleton x
fromList (x : xs) = treeInsert x (fromList xs)

-- list of elemnts in a tree in pre-order
preOrder :: Tree a -> [a]
preOrder Nil = []
preOrder (Node left value right) = [value] ++ preOrder left ++ preOrder right

-- list of elemnts in a tree in in-order
inOrder :: Tree a -> [a]
inOrder Nil = []
inOrder (Node left value right) = inOrder left ++ [value] ++ inOrder right

-- list of elemnts in a tree in post-order
postOrder :: Tree a -> [a]
postOrder Nil = []
postOrder (Node left value right) = postOrder left ++ postOrder right ++ [value]

sumTree :: Tree Int -> Int
sumTree Nil = 0
sumTree (Node left x right) = x + sumTree left + sumTree right

-- from http://learnyouahaskell.com/making-our-own-types-and-typeclasses
singleton :: a -> Tree a
singleton x = Node Nil x Nil

-- from http://learnyouahaskell.com/making-our-own-types-and-typeclasses
treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x Nil = Node Nil x Nil
treeInsert x (Node left a right)
  | x == a = Node left a right
  | x < a = Node (treeInsert x left) a right
  | x > a = Node left a (treeInsert x right)
