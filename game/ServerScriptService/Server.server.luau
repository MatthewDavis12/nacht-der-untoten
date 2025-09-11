--!nonstrict
--// Test
local MyPM = require("../ServerStorage/Modules/NachtDerUntoten")
local Region: string = "Region1"
local srcNode: string = "A"

for i = 5, 1, -1 do
    print(`Waiting Until Test: {i}s`)
    task.wait(1)
end

--// Zombie
local zombie: Model = workspace:FindFirstChild("Zombie") :: Model

--// Region1 Nodes
local pathMap = workspace:FindFirstChild("PathMap") :: Instance
local r1File = pathMap:FindFirstChild("Region1") :: Instance
local r1Nodes = r1File:GetChildren()

for _, node in pairs(r1Nodes) do
    if node.Name == srcNode then
        continue
    end

    print(`Path: {srcNode} -> {node.Name}`)
    local path = MyPM:GetPath(Region, Region, srcNode, node.Name)
    if not path then
        continue
    end


    local hum: Humanoid = zombie:FindFirstChild("Zombie") :: Humanoid
    local root = zombie:FindFirstChild("Torso") :: Part
    root.CFrame = r1File[srcNode].CFrame * CFrame.new(0, 3.5, 0)
    
    print(`Moving Zombie: {root}, {hum}`)
    for _, waypoint: Part in ipairs(path.Path) do
        hum:MoveTo(waypoint.Position, waypoint)
        hum.MoveToFinished:Wait()
    end
end
