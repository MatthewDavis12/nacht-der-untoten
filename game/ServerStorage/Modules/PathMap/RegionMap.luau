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
        Nodes = {} :: MapTypes.NodePathMap,
        Bridges = {} :: MapTypes.BridgePathMap,
        Regions = {} :: MapTypes.RegionPathMap,

        --// Impementation for the logic behind calulating the best path inside of 
        --   a region
        GetNodePath = function(self: MapTypes.RegionMap, srcNode: string, dstNode: string): MapTypes.NodePath?
            print(self.Nodes[srcNode])
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
            --// Query the srcRegion map for a region path
            local regionPath: MapTypes.RegionPath
            local regionPaths: {MapTypes.RegionPath} = self.Regions[self.Id][dstRegion] 

            --// Select region path
            for _, path: MapTypes.RegionPath in pairs(regionPaths) do
                if not path:IsValid() then
                    continue
                end
                regionPath = path
                break
            end

            --// Get bridge path
            --   TODO:
            --   Right now this is fetching the first bridge path found, but if the future
            --   requires then we'll need to pick the best path instead.
            local bridgePath: {Part} = self.Bridges[regionPath.Path[1]][1]
            local nodePath: MapTypes.NodePath? = self:GetNodePath(srcNode, bridgePath[1].Name)
            if not nodePath then
                return
            end

            --// Add the connected region bridge node then return path
            table.insert(nodePath.Path, bridgePath[2])
            return nodePath
        end,
    }
end})

