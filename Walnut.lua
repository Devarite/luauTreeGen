SuperTree = require(game.ServerScriptService.Trees.TreeSuperClass)

Tree = {}
Tree.__index = Tree
setmetatable(Tree, SuperTree)

function Tree.new(...)
    local newtree = SuperTree.new(...)
    setmetatable(newtree, Tree)


	
	--------------[[ Wood Stats ]]--------------
	
	newtree.Name = script.Name

	newtree.Hardness = 6.4 --Hit points per cross sectional square stud
	newtree.LogValue = 1.2
	newtree.PlankValue = 11
	
	--------------[[ Apearance ]]--------------


	newtree.WoodColor = BrickColor.new("Reddish brown")
	newtree.WoodMaterial = Enum.Material.Wood
	newtree.BarkColor = BrickColor.new("Dark orange")
	newtree.BarkMaterial = Enum.Material.Concrete
	newtree.BarkThickness = 0.11
	
	
	
	
	newtree.LeafColors={{Material=Enum.Material.Grass,Color=BrickColor.new("Camo")}}
	newtree.NumLeafParts = { min=1,
							 max=1 }
	newtree.LeafAngle = { X = {min=-20, max=20},
						  Y = {min=-40, max=40},
						  Z = {min=-20, max=20}}
	newtree.LeafSizeFactor = { X = {min=12, max=19}, --Leaf size as a factor of the thickness of its branch
							   Y = {min=5, max=8},
	  						   Z = {min=12, max=19}}
	
	
	newtree.BranchClass = nil



	--------------[[ Growth Behavior ]]--------------
	
	
	newtree.GrowInterval = {	min=20, --Seconds between :Grow() is called
								max=30 }
	newtree.MaxGrowCalls = {	min=65, --Max distance from bottom of trunk to tip of farthest extremety
								max=90 }
	newtree.NewBranchCutoff = 10 --Don't create a new section if we are within this many grow calls of maximum
	newtree.LifetimePerVolume = 25 --Tree will die after this much time after it stops growing
	newtree.LeafDropTime = 130 --Tree will drop leaves at this time before death
	
	
	newtree.SeedThickness = {	min=0.4, --Initial outer diameter for seedling tree
								max=0.6 }
	newtree.ThicknessGrow = {	min=0.021, --Amount the outer diameter thickens for each call of :Grow()
								max=0.03 }
	newtree.LengthGrow = {	min=0.55, --Amount length of extremety branches increases for each call of :Grow()
							max=0.68 }
	newtree.BendThicknessReduce = {	min=0.1, --Starting thickness of new bend segments, subracted from parent branch
									max=0.12 }
	newtree.SplitThicknessReduce = {min=0.18, --Starting thickness of new branch segments, subracted from parent branch
									max=0.28 }
	
	
	
	newtree.TrunkAnglePhi = {	min=0, --Angle away fron vertical normal of baseplate
								max=8 }
	newtree.TrunkAngleTheta = {	min=0, --Spin
								max=360 }
	newtree.TrunkDistanceUntilBending = {	min=7, --Will yield these distance amounts before beginning regular yield cycles for bending/branching/splitting
											max=16 }
	newtree.TrunkDistanceUntilSpliting = {	min=5,
											max=9 }
	newtree.TrunkDistanceUntilBranching = { min=100000,
											max=100000 }
	
	
	
	newtree.DistanceBetweenSplits = {	min=6, --Will yield this distance between new splits
										max=13 }
	newtree.NumSplits = {	min=2, --Number of new segments at each split. 1 is no split.
							max=6 }
	newtree.SplitAngle = {	min=0, --Angle away fron vertical normal of parent branch
							max=50 }
	newtree.AllowableAngleBetweenSplits = {	min=50, --Value between 0 and 180 degrees
											max=160 }
	newtree.SplitUnitYComponentConstraints = {	min=-0.1,
												max=1 }

 


	newtree.DistanceBetweenBends = {	min=4, --Will yield this distance between new bends
										max=16 }
	newtree.BendAngle = {	min=16, --Angle away fron vertical normal of parent branch
							max=32 }
	newtree.BendUnitYComponentConstraints = {min=-0.1,
											max=1 }




	newtree.DistanceBetweenBranching = {min=0, --Will yield this distance between new splits
										max=0 }
	newtree.NumBranches = {	min=0, --Number of new segments at each split. 1 is no split.
							max=100 }
	newtree.BranchAngle = {	min=0, --Angle away fron vertical normal of parent branch
							max=0 }
	newtree.AllowableAngleBetweenBranches = {	min=0, --Value between 0 and 180 degrees
											max=0 }
	newtree.BranchUnitYComponentConstraints = {	min=0,
												max=0 }



	newtree.SpaceCheckCone = {Distance=10,
							  Angle=15	}
	newtree.NumNewSegmentAttempts = 420
	
	newtree.MinSpawnDistanceToOtherTrees = 60



    return newtree
end

return Tree