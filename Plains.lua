wait(1 + math.random())

-------------------------------------------------------------------------
-----------------------------[[ Setup ]]---------------------------------

local treeClasses = {{class = require(game.ServerScriptService.Trees.TreeSubclasses.Oak), weight = 8},{class = require(game.ServerScriptService.Trees.TreeSubclasses.Walnut), weight = 9},{class = require(game.ServerScriptService.Trees.TreeSubclasses.Cherry), weight = 10}}
						
local regionParts = {}
for _, v in pairs(workspace.Biome_Plains:GetChildren()) do
	if v.Name == "GrassPart" then
		table.insert(regionParts, v)
	end
end

local maxTreeCount = 1020

local topSpawnRate = 20


-------------------------------------------------------------------------
-----------------------------[[ Loop ]]------------------------------

local treeGrowerModule = require(game.ServerScriptService.Trees.TreeGrowingClient)
local treeGrower = treeGrowerModule.new(regionParts, treeClasses, maxTreeCount, topSpawnRate, spawnRateFunc)

coroutine.resume(coroutine.create(function()
	treeGrower.growSpeed = 20
	--treeGrower.topSpawnRate = 0
	treeGrower.superSpeed = true
	while #treeGrower.trees < treeGrower.maxTrees do
		wait(1)
	end
	wait(10)
	treeGrower.growSpeed = 1
	--treeGrower.topSpawnRate = topSpawnRate
	treeGrower.superSpeed = false
end))

treeGrower:DoRunLoop()
