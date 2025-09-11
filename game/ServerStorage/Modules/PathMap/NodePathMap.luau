--!strict

--// NodePathMap
--   Implmentation of the NodePathMap type.
--   Usage: NPMRegister()
--
--   Created By: IAmKingMatt
--   Date Created: 09/10/2025

--// Types
local MapTypes = require("../PathMap/MapTypes")

--// Create a new NodePathMap to register node paths to.
--   This allows us to be symetrical and reduce the amount
--   of configuration.
return setmetatable({}, {__call = function(self: any): MapTypes.NodePathMap
    return {
        --// Creates a new path inside of a NodePath
        NewPath = function(self: MapTypes.NodePathMap, nodePath: {MapTypes.Node}, isValid: ((self: MapTypes.NodePath) -> boolean)?): MapTypes.NodePath
            return {
                Path = nodePath,
                IsValid = isValid or function(): boolean
                    return true
                end
            }
        end,

        --// Create new NodePath mappings for new nodes.
        NewNodePath = function(self: MapTypes.NodePathMap, nodeId: string, nodePath: {[string]: {MapTypes.NodePath}})
            self[nodeId] = nodePath
        end
    }
end})


--[[
local R1_NPM: MapTypes.NodePathMap = NPMRegister()

--// 
R1_NPM:NewNodePath("A", {
    B = {
        R1_NPM:NewPath({A, B, C}, function(): boolean
            return true
        end) 
    },
    C = {},
    D = {},
})


]]
