--!strict

--// Region1
--   Implementation of Region1 in the Nacht Der Untoten map.

--// Types
local MapTypes = require("../PathMap/MapTypes")
local NMPRegister = require("../PathMap/NodePathMap")
local RegionMapRegister = require("../PathMap/RegionMap")

--// Build process should be
--   Create new RegionMap
--   Create NodePathMaps
--   Create RegionPathMaps
--   Create BridgePathMaps

--// Nodes
local PathMapFile = workspace:FindFirstChild("PathMap") :: Instance
local Region1File = PathMapFile:FindFirstChild("Region1") :: Instance
local R1Nodes: {[string]: Part} = {}

for _, node in pairs(Region1File:GetChildren()) do
    if not node:IsA("Part") then
        continue
    end
    R1Nodes[node.Name] = node :: Part
end

--// Create a new region map for Region1
local Region1: MapTypes.RegionMap = RegionMapRegister("Region1")
local NodePathMap: MapTypes.NodePathMap = NMPRegister()
Region1.Nodes = NodePathMap

--// All possible mappings for A
NodePathMap:NewNodePath("A", {
    B = {
        NodePathMap:NewPath({R1Nodes.B})
    },
    C = {
        NodePathMap:NewPath({R1Nodes.C})
    },
    D = {
        NodePathMap:NewPath({R1Nodes.E, R1Nodes.F, R1Nodes.G, R1Nodes.D})
    },
    E = {
        NodePathMap:NewPath({R1Nodes.E})
    },
    F = {
        NodePathMap:NewPath({R1Nodes.E, R1Nodes.F})
    },
    G = {
        NodePathMap:NewPath({R1Nodes.E, R1Nodes.F, R1Nodes.G})
    },
    H = {
        NodePathMap:NewPath({R1Nodes.E, R1Nodes.F, R1Nodes.G, R1Nodes.H})
    }
})

return Region1
