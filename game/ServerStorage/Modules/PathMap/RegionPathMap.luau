--!strict

--// RegionPathMap
--   Maps the various paths one region will take to another.
--   Contains statically defined mappings.

--// Types
local MapTypes = require("../PathMap/MapTypes")

--// Creates a new RegionPathMap
return setmetatable({}, {__call = function(self: any): MapTypes.RegionPathMap 
    return {
        --// Register new RegionPathMap to the RegionMap
        NewSourceRegionPath = function(self: MapTypes.RegionPathMap, srcRegion: string, regionPath: {[string]: {MapTypes.RegionPath}})
            self[srcRegion] = regionPath
        end,

        --// Register new region path to the RegionPathMap
        NewRegionPath = function(self: MapTypes.RegionPathMap, regionPath: {string}, isValid: ((self: MapTypes.RegionPath)->boolean)?): MapTypes.RegionPath
            return {
                Path = regionPath,
                IsValid = isValid or function(self): boolean
                    return true
                end
            }  
        end
    }
end})