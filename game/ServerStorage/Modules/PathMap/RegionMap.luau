--!strict

--// RegionMap
--   Implmentation of the RegionMap type.
--   Usage: RegionMap("Region1")
--  
--   Created By: IAmKingMatt
--   Date Created: 09/10/2025

--// Types
local MapTypes = require("../PathMap/MapTypes")

--// Create a new RegionMap
--   The region map will contain methods that are used to register various other
--   map types to it. This is important as RegionMaps are the primary means of pathfinding.
return setmetatable({}, {__call = function(self, regionName: string): MapTypes.RegionMap
    assert(regionName, `Failed to create RegionMap, missing arg 1 (No region name provided)`)

    return {
        Id = regionName,
        Bridges = {},
        Regions = {},
        Nodes = {} :: MapTypes.NodePathMap,

        --// Impementation for the logic behind calulating the best path inside of 
        --   a region
        GetNodePath = function(self: MapTypes.RegionMap, srcNode: string, dstNode: string): MapTypes.NodePath?
            local nodePath: {MapTypes.NodePath} = self.Nodes[srcNode][dstNode]
            if not nodePath then
                return
            end

            for _, path: MapTypes.NodePath in ipairs(nodePath) do
                if not path:IsValid() then
                    continue
                end

                return path
            end

            return
        end,

        --// Implementation for the logic behind external region pathfinding.
        GetRegionNodePath = function(self: MapTypes.RegionMap, dstRegion: string, srcNode: string): MapTypes.NodePath?
            return
        end,
    }
end})

