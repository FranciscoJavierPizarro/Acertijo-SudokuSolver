-- Utilidades
module Graph where

import Data.List

data Graph v = Graph v (Graph v -> v ->[v])

info (Graph info _) = info

paths :: Eq v => Graph v -> v -> v -> [[v]]
paths graph org dst = pathsToGoal graph org (== dst)

pathsToGoal :: Eq v => Graph v -> v -> (v -> Bool) -> [[v]]
pathsToGoal graph here goal = pathsToGoalNoLoop graph here goal []

pathsToGoalNoLoop :: Eq v => Graph v -> v -> (v -> Bool) -> [v] -> [[v]]
pathsToGoalNoLoop graph@(Graph _ succ) here goal visited
    | goal here = [ [here] ]
    | otherwise = [ here:path |
                    next <- (succ graph here)\\visited,
                    path <- pathsToGoalNoLoop graph next goal (here:visited)]

-- Lista de las soluciones mas cortas
-- supone que estan ordenadas
shortest :: [[v]] -> [[v]]
shortest [] = []
shortest [x] = [x]
shortest (x:xs) = x:(takeWhile ((== l).length) xs)
    where
        l = length x
