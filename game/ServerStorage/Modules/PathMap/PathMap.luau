--!strict

--// Usage Goal
-- MyMap: PathMap = PathMap(RegionMap, RegionMap, RegionMap)
-- 
-- RegionMaps will be generated hopefully through external modules that are used to import.
--
--   Created By: IAmKingMatt
--   Date Created: 09/10/2025

--// Types
local MapTypes = require("../PathMap/MapTypes")

--// __call allows us to call our PathMap as if it was a function.
--   This QoL feature makes for some good looks PathMap instantiations.
return setmetatable({}, {__call = function(self, ...: MapTypes.RegionMap): MapTypes.PathMap
    local PathMap: MapTypes.PathMap = {
        GetPath = function(self: MapTypes.PathMap, srcRegion: string, dstRegion: string, srcNode: string, dstNode: string): MapTypes.NodePath?
            local srcRegionMap: MapTypes.RegionMap = self[srcRegion]
            assert(srcRegionMap, `Failed to find RegionMap for {srcRegion}`)

            if srcRegion == dstRegion then
                --// Intra-regional pathfinding query
                --   Performed for destination regions that are the source region.
                return srcRegionMap:GetNodePath(srcNode, dstNode)
            else
                --// Region-to-Region pathfinding query
                --   Performed for a destination region that is not the same region as the target.
                return srcRegionMap:GetRegionNodePath(dstRegion, srcNode)
            end
        end
    }

    --// Build the PathMap with provided RegionMaps
    for _, regionMap: MapTypes.RegionMap in ipairs({...}) do
        PathMap[regionMap.Id] = regionMap
    end

    return PathMap
end})