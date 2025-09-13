--!nonstrict
--// Test
local MyPM = require("../ServerStorage/Modules/NachtDerUntoten")
local srcRegion: string = "Region1"
local srcNodes: string = "B1"

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

--// Stress test
print(`Performing stress test: Query Size {1000} lookups`)
for i = 1, 1000 do
    local queryStart: number = tick()
    local srcNode = r1Nodes[math.random(1, #r1Nodes)]
    local path = MyPM:GetPath(srcRegion, "Region2", srcNode.Name, "")

    print(`Query Time: {tick() - queryStart}\nPath: {path}`)
end

while task.wait(1) do
    local requestStart: number = tick()
    local path = MyPM:GetPath(srcRegion, "Region2", srcNodes, "")
    print(tick() - requestStart)
    local hum: Humanoid = zombie:FindFirstChild("Zombie") :: Humanoid
    local srcNode: Part = r1File:FindFirstChild(srcNodes) :: Part
    zombie.Torso.CFrame = srcNode.CFrame * CFrame.new(0, 3.5, 0)

    for _, node: Part in ipairs(path.Path) do
        print(node, typeof(node))
        hum:MoveTo(node.Position, node)
        hum.MoveToFinished:Wait()
    end
end