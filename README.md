# Docs
This document is designed to help us understand and keep track of the various moving parts, data structures and methods used to make this game come back to life.

## Overview
There are a few concepts that you need to understand when it comes with the primary goal of the game, zombies roaming a map to kill players every round. Here are some key terms that you should remembers:
- `Region`: The maps are divided into regions.
- `Path Node`: Nodes that are layed out across the map to assist zombies in traversing the map.
- `PathMap`: Data structure used by zombies to navigate the map.
- `RegionMap`: Data structure that stores information on `path nodes`, `bridge nodes`, and `region paths`.
- `BridgePathMap`: Data structure that stores a mapping of `bridge node` to connected `regions`
- `BridgeNode`: A special node that connects regions. 
- `NodePathMap`: A mapping of `source path nodes` to paths that lead to all over `path nodes` in the `region`.
- `RegionPathMap`: A mapping of `source regions` to all over `regions` on the map.

