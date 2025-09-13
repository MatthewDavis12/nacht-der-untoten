--!nonstrict
--// Test
local MyPM = require("../ServerStorage/Modules/NachtDerUntoten")
local srcRegion: string = "Region1"
local srcNodes: string = "E1"

for i = 5, 1, -1 do
    print(`Waiting Until Test: {i}s`)
    task.wait(1)
end

--// Zombie
local zombie: Model = workspace:FindFirstChild("Zombie") :: Model

--// Region1 Nodes
local pathMap = workspace:FindFirstChild("PathMap") :: Instance
local r1File = pathMap:FindFirstChild("Region1") :: Instance
local path = MyPM:GetPath(srcRegion, "Region2", srcNodes, "")

local hum: Humanoid = zombie:FindFirstChild("Zombie") :: Humanoid
local srcNode: Part = r1File:FindFirstChild(srcNodes) :: Part
zombie:MoveTo(srcNode.Position + Vector3.new(0, 3.5, 0))

for _, node: Part in ipairs(path.Path) do
    print(node, typeof(node))
    hum:MoveTo(node.Position, node)
    hum.MoveToFinished:Wait()
end