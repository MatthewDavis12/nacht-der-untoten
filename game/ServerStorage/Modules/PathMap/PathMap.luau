--!strict

--// Usage Goal
-- MyMap: PathMap = PathMap(RegionMap, RegionMap, RegionMap)
-- 
-- RegionMaps will be generated hopefully through external modules that are used to import.

--// Types
local MapTypes = require("../PathMap/MapTypes")

--// PathMap implementation
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

--// __call allows us to call our PathMap as if it was a function.
--   This QoL feature makes for some good looks PathMap instantiations.
return setmetatable(PathMap, {__call = function(self, ...: MapTypes.RegionMap)
    for _, regionMap: MapTypes.RegionMap in ipairs({...}) do
        self[regionMap.Id] = regionMap
    end
end})