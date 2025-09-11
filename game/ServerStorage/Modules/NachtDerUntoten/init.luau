--!strict

--// Test Pathfinding Build
--   This is just testing

--// Types
local MapTypes = require("./PathMap/MapTypes")
local PathMapRegister = require("./PathMap/PathMap")

--// Load All Region Maps
local Region1RM: MapTypes.RegionMap = require("./NachtDerUntoten/Region1")

--// PathMap
local PathMap: MapTypes.PathMap = PathMapRegister(Region1RM)
return PathMap