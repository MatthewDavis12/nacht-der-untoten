--!strict

--// Region1
--   Implementation of Region1 in the Nacht Der Untoten map.

--// Types
local MapTypes = require("../PathMap/MapTypes")
local NMPRegister = require("../PathMap/NodePathMap")
local RPMRegister = require("../PathMap/RegionPathMap")
local BPMRegister = require("../PathMap/BridgePathMap")
local RegionMapRegister = require("../PathMap/RegionMap")

--// Build process should be
--   Create new RegionMap
--   Create NodePathMaps
--   Create RegionPathMaps
--   Create BridgePathMaps

--// Nodes
local PathMapFile = workspace:FindFirstChild("PathMap") :: Instance
local Region1File = PathMapFile:FindFirstChild("Region1") :: Instance
local Region2File = PathMapFile:FindFirstChild("Region2") :: Instance
local Region4File = PathMapFile:FindFirstChild("Region4") :: Instance
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
local RegionPathMap: MapTypes.RegionPathMap = RPMRegister()
local BridgePathMap: MapTypes.BridgePathMap = BPMRegister()
Region1.Nodes = NodePathMap
Region1.Bridges = BridgePathMap
Region1.Regions = RegionPathMap

--////////////////////////////--
--         REGION_MAP         --
--////////////////////////////--
RegionPathMap:NewSourceRegionPath("Region1", {
    Region2 = {
        RegionPathMap:NewRegionPath({"Region2"}),
        RegionPathMap:NewRegionPath({"Region4", "Region3", "Region2"})
    },
    Region3 = {
        RegionPathMap:NewRegionPath({"Region2", "Region3"}),
        RegionPathMap:NewRegionPath({"Region4", "Region3"})
    },
    Region4 = {
        RegionPathMap:NewRegionPath({"Region4"}),
        RegionPathMap:NewRegionPath({"Region2", "Region3", "Region4"})
    }
})

--////////////////////////////--
--         BRIDGE_MAP         --
--////////////////////////////--
--// Bridge R1->R2
BridgePathMap:NewBridgePath("Region2", {
    {Region1File:FindFirstChild("H1") :: Part, Region2File:FindFirstChild("F2") :: Part}
})

--////////////////////////////--
--         NODE_MAP           --
--////////////////////////////--
--// All possible mappings for A
NodePathMap:NewSourceNodePath("A1", {
    B1 = {
        NodePathMap:NewPath({R1Nodes.B1})
    },
    C1 = {
        NodePathMap:NewPath({R1Nodes.E1, R1Nodes.F1, R1Nodes.C1})
    },
    D1 = {
        NodePathMap:NewPath({R1Nodes.E1, R1Nodes.F1, R1Nodes.G1, R1Nodes.D1})
    },
    E1 = {
        NodePathMap:NewPath({R1Nodes.E1})
    },
    F1 = {
        NodePathMap:NewPath({R1Nodes.E1, R1Nodes.F1})
    },
    G1 = {
        NodePathMap:NewPath({R1Nodes.E1, R1Nodes.F1, R1Nodes.G1})
    },
    H1 = {
        NodePathMap:NewPath({R1Nodes.E1, R1Nodes.F1, R1Nodes.G1, R1Nodes.H1})
    }
})

--// Mappings for Node B
NodePathMap:NewSourceNodePath("B1", {
    A1 = {
        NodePathMap:NewPath({R1Nodes.A11})
    },
    C1 = {
        NodePathMap:NewPath({R1Nodes.E1, R1Nodes.F1, R1Nodes.C1})
    },
    D1 = {
        NodePathMap:NewPath({R1Nodes.E1, R1Nodes.F1, R1Nodes.G1, R1Nodes.D1})
    },
    E1 = {
        NodePathMap:NewPath({R1Nodes.E1})
    },
    F1 = {
        NodePathMap:NewPath({R1Nodes.E1, R1Nodes.F1})
    },
    G1 = {
        NodePathMap:NewPath({R1Nodes.E1, R1Nodes.F1, R1Nodes.G1})
    },
    H1 = {
        NodePathMap:NewPath({R1Nodes.E1, R1Nodes.F1, R1Nodes.G1, R1Nodes.H1})
    }
})

--// Mappings for Node C
NodePathMap:NewSourceNodePath("C1", {
    A1 = {
        NodePathMap:NewPath({R1Nodes.F1, R1Nodes.E1, R1Nodes.A11})
    },
    B1 = {
        NodePathMap:NewPath({R1Nodes.F1, R1Nodes.E1, R1Nodes.B1})
    },
    D1 = {
        NodePathMap:NewPath({R1Nodes.D1})
    },
    E1 = {
        NodePathMap:NewPath({R1Nodes.F1, R1Nodes.E1})
    },
    F1 = {
        NodePathMap:NewPath({R1Nodes.F1})
    },
    G1 = {
        NodePathMap:NewPath({R1Nodes.F1, R1Nodes.G1})
    },
    H1 = {
        NodePathMap:NewPath({R1Nodes.F1, R1Nodes.G1, R1Nodes.H1})
    }
})

--// Mappings for Node D
NodePathMap:NewSourceNodePath("D1", {
    A1 = {
        NodePathMap:NewPath({R1Nodes.G1, R1Nodes.F1, R1Nodes.E1, R1Nodes.A11})
    },
    B1 = {
        NodePathMap:NewPath({R1Nodes.G1, R1Nodes.F1, R1Nodes.E1, R1Nodes.B1})
    },
    C1 = {
        NodePathMap:NewPath({R1Nodes.C1})
    },
    E1 = {
        NodePathMap:NewPath({R1Nodes.G1, R1Nodes.F1, R1Nodes.E1})
    },
    F1 = {
        NodePathMap:NewPath({R1Nodes.G1, R1Nodes.F1})
    },
    G1 = {
        NodePathMap:NewPath({R1Nodes.G1})
    },
    H1 = {
        NodePathMap:NewPath({R1Nodes.H1})
    }
})

--// Mappings for Node E
NodePathMap:NewSourceNodePath("E1", {
    A1 = {
        NodePathMap:NewPath({R1Nodes.A1})
    },
    B1 = {
        NodePathMap:NewPath({R1Nodes.B1})
    },
    C1 = {
        NodePathMap:NewPath({R1Nodes.F1, R1Nodes.C1})
    },
    D1 = {
        NodePathMap:NewPath({R1Nodes.F1, R1Nodes.G1, R1Nodes.D1})
    },
    F1 = {
        NodePathMap:NewPath({R1Nodes.F1})
    },
    G1 = {
        NodePathMap:NewPath({R1Nodes.F1, R1Nodes.G1})
    },
    H1 = {
        NodePathMap:NewPath({R1Nodes.F1, R1Nodes.G1, R1Nodes.H1})
    }
})

--// Mappings for Node F
NodePathMap:NewSourceNodePath("F1", {
    A1 = {
        NodePathMap:NewPath({R1Nodes.E1, R1Nodes.A1})
    },
    B1 = {
        NodePathMap:NewPath({R1Nodes.E1, R1Nodes.B1})
    },
    C1 = {
        NodePathMap:NewPath({R1Nodes.C1})
    },
    D1 = {
        NodePathMap:NewPath({R1Nodes.G1, R1Nodes.D1})
    },
    E1 = {
        NodePathMap:NewPath({R1Nodes.E1})
    },
    G1 = {
        NodePathMap:NewPath({R1Nodes.G1})
    },
    H1 = {
        NodePathMap:NewPath({R1Nodes.G1, R1Nodes.H1})
    }
})

--// Mappings for Node G
NodePathMap:NewSourceNodePath("G1", {
    A1 = {
        NodePathMap:NewPath({R1Nodes.F1, R1Nodes.E1, R1Nodes.A1})
    },
    B1 = {
        NodePathMap:NewPath({R1Nodes.F1, R1Nodes.E1, R1Nodes.B1})
    },
    C1 = {
        NodePathMap:NewPath({R1Nodes.F1, R1Nodes.C1})
    },
    D1 = {
        NodePathMap:NewPath({R1Nodes.D1})
    },
    E1 = {
        NodePathMap:NewPath({R1Nodes.F1, R1Nodes.E1})
    },
    F1 = {
        NodePathMap:NewPath({R1Nodes.F1})
    },
    H1 = {
        NodePathMap:NewPath({R1Nodes.H1})
    }
}) 

--// Mappings for Node H
NodePathMap:NewSourceNodePath("H1", {
    A1 = {
        NodePathMap:NewPath({R1Nodes.G1, R1Nodes.F1, R1Nodes.E1, R1Nodes.A1})
    },
    B1 = {
        NodePathMap:NewPath({R1Nodes.G1, R1Nodes.F1, R1Nodes.E1, R1Nodes.B1})
    },
    C1 = {
        NodePathMap:NewPath({R1Nodes.G1, R1Nodes.F1, R1Nodes.C1})
    },
    D1 = {
        NodePathMap:NewPath({R1Nodes.D1})
    },
    E1 = {
        NodePathMap:NewPath({R1Nodes.G1, R1Nodes.F1, R1Nodes.E1})
    },
    F1 = {
        NodePathMap:NewPath({R1Nodes.G1, R1Nodes.F1})
    },
    G1 = {
        NodePathMap:NewPath({R1Nodes.G1})
    }
})

return Region1
