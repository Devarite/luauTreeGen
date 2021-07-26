--------------------------------------------
------------- Instantiation ----------------

local rayHeight = 100

GrowClient = {}
GrowClient.__index = GrowClient

function GrowClient.new(regionParts, treeClassList, maxTreeCount, topSpawnRate, spawnRateFunc)
    local newRegion = {}
    setmetatable(newRegion, GrowClient)

	local folder = Instance.new("Folder", game.ReplicatedStorage)
	folder.Name = regionParts[1].Parent.Name
	
	newRegion.treeCountValue = Instance.new("IntValue", folder)
	newRegion.treeCountValue.Name = "TreeCount"
	
	newRegion.maxTreeCountValue = Instance.new("IntValue", folder)
	newRegion.maxTreeCountValue.Name = "MaxTreeCount"
	newRegion.maxTreeCountValue.Value = maxTreeCount
	
	newRegion.superSpeedValue = Instance.new("BoolValue", folder)
	newRegion.superSpeedValue.Name = "SuperSpeed"
	newRegion.superSpeedValue.Value = true

	

	newRegion.treeList = {}
	for _, tree in pairs(treeClassList) do
		for i = 1, tree.weight do
			table.insert(newRegion.treeList, tree.class)
		end
	end
	
	newRegion.regionParts = regionParts
	newRegion.regionBounds = {min = Vector3.new(1,1,1) * 10000000, max = Vector3.new(1,1,1) *  -10000000}
	
	for _, part in pairs(regionParts) do
		if part:IsA("BasePart") then
			for x = -1, 1, 2 do
				for y = -1, 1, 2 do
					for z = -1, 1, 2 do
						local point = (part.CFrame * CFrame.new(Vector3.new(x * part.Size.X / 2, y * part.Size.Y / 2, z * part.Size.Z / 2))).p
						
						newRegion.regionBounds.max = Vector3.new(math.max(newRegion.regionBounds.max.X, point.X),
																math.max(newRegion.regionBounds.max.Y, point.Y),
																math.max(newRegion.regionBounds.max.Z, point.Z))
						
						newRegion.regionBounds.min = Vector3.new(math.min(newRegion.regionBounds.min.X, point.X),
																math.min(newRegion.regionBounds.min.Y, point.Y),
																math.min(newRegion.regionBounds.min.Z, point.Z))
						
					end
				end
			end
		end
	end
	
	newRegion.maxTrees = maxTreeCount
	newRegion.topSpawnRate = topSpawnRate
	newRegion.customSpawnRateFunc = spawnRateFunc  -- would be a function that receives an x value between 0 and 1 (percent max of trees) and returns a y value 0 to 1 (percent of top spawn rate)
	
	newRegion.growSpeed = 1
	newRegion.superSpeed = false
	newRegion.lastSeedPlant = 0
	newRegion.thisTick = nil
	newRegion.lastTick = nil
	
	newRegion.trees = {}
	
	newRegion.Model = Instance.new("Model", workspace)
	newRegion.Model.Name = "TreeRegion"

    return newRegion
end


--------------------------------------------
------------- Running ----------------------

function GrowClient:DoRunLoop()
	
	while true do
		
		self.treeCountValue.Value = #self.trees
		self.superSpeedValue.Value = self.superSpeed
		
		if not self.superSpeed then
			wait(1 / self.growSpeed)	
		else
			wait()
		end
		
		--print("This time: "..tostring((tick() - self.lastSeedPlant) * self.growSpeed).."   Next spawn: "..tostring(self:GetSpawnRate()))
		--print("Trees: "..#self.trees)
			
		if #self.trees < self.maxTrees and ((tick() - self.lastSeedPlant) * self.growSpeed > self:GetSpawnRate() or self.superSpeed) then
			self.lastSeedPlant = tick()
			self:PlantNewTree()
		end
		
		self:GrowTrees()
		
		local removeATree = nil
		for index, tree in pairs(self.trees) do
			if not tree.Model.Parent then--tree.CleanMeUp then
				--tree:Destroy()
				removeATree = index
				break
			end			
		end
		
		if removeATree then
			table.remove(self.trees, removeATree)
		end
		
	end
end



function GrowClient:GetSpawnRate()
	if self.customSpawnRateFunc then
		return self.topSpawnRate * self.customSpawnRateFunc(#self.trees / self.maxTrees)
	end
	
	return (#self.trees / self.maxTrees) ^ (1/2) * self.topSpawnRate
end

--------------------------------------------
------------- Tree Planting ----------------

function GrowClient:PlantNewTree()
	
	local newTree = self.treeList[math.random(1, #self.treeList)].new(self.Model)
	
	local spot
	for i = 1, 100 do
		spot = self:FindSeedSpot(newTree)
		if spot then
			break
		end
	end
	
	if spot and script.Parent.TreeSubclasses:FindFirstChild(newTree.Name) then
		newTree:PlantSeed(spot)
		table.insert(self.trees, newTree)
	end
end


function GrowClient:FindSeedSpot(tree)
	
	local ignoreStuff = {}
	for _, player in pairs(game.Players:GetPlayers()) do
		table.insert(ignoreStuff, player)
	end
	
	for i = 1, 200 do
		local point = Vector3.new(math.random(self.regionBounds.min.X, self.regionBounds.max.X), self.regionBounds.max.Y + rayHeight ,math.random(self.regionBounds.min.Z, self.regionBounds.max.Z))
		local ray = Ray.new(point, Vector3.new(0, self.regionBounds.min.Y - self.regionBounds.max.Y - rayHeight, 0))
		local part, point = workspace:FindPartOnRayWithIgnoreList(ray, ignoreStuff)
		
		if part then
			if not part.CanCollide and not (part.Name == "Water") then
				table.insert(ignoreStuff, part)
			end
			
			for _, regionPart in pairs(self.regionParts) do
				if regionPart == part then
					local attemptCFrame = CFrame.new(point)
					
					if tree:CanSeedHere(attemptCFrame, self.trees) then
						return attemptCFrame
					end
					break
				end
			end
		end
	end
end

--------------------------------------------
------------- Growing ----------------------


function GrowClient:GrowTrees()

	self.lastTick = self.thisTick or tick() - 0.1
	self.thisTick = tick()
	local timeDiff = self.thisTick - self.lastTick

	--intenseGrowingBool.Value = timeDiff > 0.2

	for _, tree in pairs(self.trees) do
		local success, error = pcall(function()
			tree:GrowCheck(timeDiff  * self.growSpeed, self.superSpeed)
		end)
		if not success then
			script.Parent.Parent.Stats.ErrorReport.Report:Fire("Tree growing error: "..error)
			tree:Destroy()
		end
	end
end


return GrowClient

