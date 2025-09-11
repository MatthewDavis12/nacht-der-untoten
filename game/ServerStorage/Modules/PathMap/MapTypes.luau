--!strict

--// MapTypes
--   Defines the types that will be used to build the PathMap.
--
--   Created By: IAmKingMatt
--   Date Created: 09/10/2025
export type Node = Part

--// A list of region paths that can be validated.
export type RegionPath = {
    --// Path of regions
    Path:    {string},
    --// Validation function for the path
    IsValid: (self: RegionPath) -> boolean
}

--// A list of nodes that can be validated.
export type NodePath = {
    --// Path of nodes
    Path:    {Node},
    --// Validation function for the path
    IsValid: (self: NodePath) -> boolean 
}

--// PathMap type definition
export type PathMap = {
    --// string: This is the name of the region
    --   RegionMap: This is the actual region map associated with that region.
    [string]: RegionMap,
    --// Queries the internal region maps for a path
    GetPath:  (self: PathMap, srcRegion: string, destRegion: string, srcNode: string, destNode: string) -> NodePath?
}

--// RegionMap defintion
export type RegionMap = {
    --// String id for current region
    Id:                string,
    --// Node path mapping for nodes within the region
    Nodes:             NodePathMap,
    --// Node mapping for connected regions
    Bridges:           BridgePathMap,
    --// Region mapping for all connected and non-connected regions
    Regions:           RegionPathMap,
    --// Calculates node path mapping
    GetNodePath:       (self: RegionMap, srcNode: string, dstNode: string) -> NodePath?,
    --// Calulates node paths for external regions, will use GetNodePath internally.
    GetRegionNodePath: (self: RegionMap, dstRegion: string, srcNode: string) -> NodePath?
}

--// RegionPathMap type definition
export type RegionPathMap = {
    --// string: The destination region
    --   RegionPathList: List of all possible paths to destination region
    [string]: {RegionPath}
}

--// BridgePathMap type definition
export type BridgePathMap = {
    --// string: The connected region we're mapping to.
    --   {Node}: The nodes that can be used to get to that region
    [string]: {Node}
}

--// NodePathMap type definition
export type NodePathMap = {
    --// Mapping of start nodes and all possible paths
    [string]:    {[string]: {NodePath}},
    --// Create a new path inside of a NodePath
    NewPath:     (self: NodePathMap, nodePath: {Node}, isValid: ((self: NodePath) -> boolean)?) -> NodePath,
    --// Create a new NodePath
    NewSourceNodePath: (self: NodePathMap, nodePathId: string, nodePath: {[string]: {NodePath}}) -> ()
}

return {}