--!strict

--// BridgePathMap
--   This is simply a mapping of transition nodes from connected regions.

--// Types
local MapTypes = require("../PathMap/MapTypes")

--// Create a new BridgePath map that can be used for building
--   paths between connected regions. This requires a node from each region.
return setmetatable({}, {__call = function(self): MapTypes.BridgePathMap 
    return{
        NewBridgePath = function(self: MapTypes.BridgePathMap, region: string, bridgePath: {{MapTypes.Node}})
            self[region] = bridgePath
        end
    }
end})