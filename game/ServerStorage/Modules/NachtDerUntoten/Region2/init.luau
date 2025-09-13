--!strict

--// Region2
--   Builds the pathfinding structures required for region 2

--// Types
local MapTypes = require("../PathMap/MapTypes")
local NMPRegister = require("../PathMap/NodePathMap")
local RPMRegister = require("../PathMap/RegionPathMap")
local BPMRegister = require("../PathMap/BridgePathMap")
local RegionMapRegister = require("../PathMap/RegionMap")

--// Nodes
local PathMapFile = workspace:FindFirstChild("PathMap") :: Instance
local Region2File = PathMapFile:FindFirstChild("Region2") :: Instance

--// Connected regions
local Region1File = PathMapFile:FindFirstChild("Region1") :: Instance
local Region3File = PathMapFile:FindFirstChild("Region4") :: Instance

--// Local region nodes
local N: {[string]: Part} = {}

for _, node in pairs(Region2File:GetChildren()) do
    if not node:IsA("Part") then
        continue
    end
    N[node.Name] = node :: Part
end

--// Create a new region map for Region1
local Region2: MapTypes.RegionMap = RegionMapRegister("Region2")
local NodePathMap: MapTypes.NodePathMap = NMPRegister()
local RegionPathMap: MapTypes.RegionPathMap = RPMRegister()
local BridgePathMap: MapTypes.BridgePathMap = BPMRegister()
Region2.Nodes = NodePathMap
Region2.Bridges = BridgePathMap
Region2.Regions = RegionPathMap

--////////////////////////////--
--         REGION_MAP         --
--////////////////////////////--
RegionPathMap:NewSourceRegionPath("Region2", {
    Region1 = {
        RegionPathMap:NewRegionPath({"Region1"}),
        RegionPathMap:NewRegionPath({"Region3", "Region4", "Region1"})
    },
    Region3 = {
        RegionPathMap:NewRegionPath({"Region3"}),
        RegionPathMap:NewRegionPath({"Region2", "Region4", "Region3"})
    },
    Region4 = {
        RegionPathMap:NewRegionPath({"Region3", "Region4"}),
        RegionPathMap:NewRegionPath({"Region2", "Region4"})
    }
})

--////////////////////////////--
--         BRIDGE_MAP         --
--////////////////////////////--
BridgePathMap:NewBridgePath("Region1", {
    {Region2File:FindFirstChild("F2") :: Part, Region1File:FindFirstChild("H1") :: Part}
})

--////////////////////////////--
--         NODE_MAP           --
--////////////////////////////--