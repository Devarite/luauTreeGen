SuperTree = require(game.ServerScriptService.Trees.TreeSuperClass)

Tree = {}
Tree.__index = Tree
setmetatable(Tree, SuperTree)

function Tree.new(...)
    local newtree = SuperTree.new(...)
    setmetatable(newtree, Tree)


	
	--------------[[ Wood Stats ]]--------------
	
	newtree.Name = script.Name

	newtree.Hardness = 5.2 --Hit points per cross sectional square stud
	newtree.LogValue = 0.75
	newtree.PlankValue = 6
	
	--------------[[ Apearance ]]--------------


	newtree.WoodColor = BrickColor.new("Light orange")
	newtree.WoodMaterial = Enum.Material.Wood
	newtree.BarkColor = BrickColor.new("Sand red")
	newtree.BarkMaterial = Enum.Material.Concrete
	newtree.BarkThickness = 0.095
	
	
	
	
	newtree.LeafColors={{Material=Enum.Material.Grass,Color=BrickColor.new("Bright green")},
						{Material=Enum.Material.Grass,Color=BrickColor.new("Dark green")}}
	newtree.NumLeafParts = { min=1,
							 max=1 }
	newtree.LeafAngle = { X = {min=-10, max=10},
						  Y = {min=-20, max=20},
						  Z = {min=-10, max=10}}
	newtree.LeafSizeFactor = { X = {min=8, max=11}, --Leaf size as a factor of the thickness of its branch
							   Y = {min=4, max=6},
	  						   Z = {min=8, max=11}}
	
	
	newtree.BranchClass = nil



	--------------[[ Growth Behavior ]]--------------
	
	
	newtree.GrowInterval = {	min=8, --Seconds between :Grow() is called
								max=15 }
	newtree.MaxGrowCalls = {	min=65, --Max distance from bottom of trunk to tip of farthest extremety
								max=90 }
	newtree.NewBranchCutoff = 10 --Don't create a new section if we are within this many grow calls of maximum
	newtree.LifetimePerVolume = 25 --Tree will die after this much time after it stops growing
	newtree.LeafDropTime = 130 --Tree will drop leaves at this time before death
	
	
	newtree.SeedThickness = {	min=0.3, --Initial outer diameter for seedling tree
								max=0.5 }
	newtree.ThicknessGrow = {	min=0.02, --Amount the outer diameter thickens for each call of :Grow()
								max=0.028 }
	newtree.LengthGrow = {	min=0.56, --Amount length of extremety branches increases for each call of :Grow()
							max=0.65 }
	newtree.BendThicknessReduce = {	min=0.7, --Starting thickness of new bend segments, subracted from parent branch
									max=0.9 }
	newtree.SplitThicknessReduce = {min=0.2, --Starting thickness of new branch segments, subracted from parent branch
									max=0.32 }
	
	
	
	newtree.TrunkAnglePhi = {	min=0, --Angle away fron vertical normal of baseplate
								max=10 }
	newtree.TrunkAngleTheta = {	min=0, --Spin
								max=360 }
	newtree.TrunkDistanceUntilBending = {	min=10000, --Will yield these distance amounts before beginning regular yield cycles for bending/branching/splitting
											max=10000 }
	newtree.TrunkDistanceUntilSpliting = {	min=10,
											max=18 }
	newtree.TrunkDistanceUntilBranching = { min=10,
											max=14 }
	
	
	
	newtree.DistanceBetweenSplits = {	min=8, --Will yield this distance between new splits
										max=13 }
	newtree.NumSplits = {	min=2, --Number of new segments at each split. 1 is no split.
							max=4 }
	newtree.SplitAngle = {	min=0, --Angle away fron vertical normal of parent branch
							max=65 }
	newtree.AllowableAngleBetweenSplits = {	min=40, --Value between 0 and 180 degrees
											max=140 }
	newtree.SplitUnitYComponentConstraints = {	min=0.1,
												max=1 }

 


	newtree.DistanceBetweenBends = {	min=3, --Will yield this distance between new bends
										max=5 }
	newtree.BendAngle = {	min=10, --Angle away fron vertical normal of parent branch
							max=30 }
	newtree.BendUnitYComponentConstraints = {min=0,
											max=1 }




	newtree.DistanceBetweenBranching = {min=4, --Will yield this distance between new splits
										max=10 }
	newtree.NumBranches = {	min=1, --Number of new segments at each split. 1 is no split.
							max=1 }
	newtree.BranchAngle = {	min=0, --Angle away fron vertical normal of parent branch
							max=80 }
	newtree.AllowableAngleBetweenBranches = {	min=30, --Value between 0 and 180 degrees
											max=180 }
	newtree.BranchUnitYComponentConstraints = {	min=-0.6,
												max=1 }



	newtree.SpaceCheckCone = {Distance=10,
							  Angle=15	}
	newtree.NumNewSegmentAttempts = 250
	
	newtree.MinSpawnDistanceToOtherTrees = 30



    return newtree
end

return Tree