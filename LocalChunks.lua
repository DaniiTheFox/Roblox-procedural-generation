------------------------------------------------------
-- 	CHUNK ENGINE BASE FOR ROBLOX TECH TEST  		--
--		THIS IS A TEST FOR PROCEDURAL GEN IN ROBLOX --
------------------------------------------------------
local lighting = game:GetService("Lighting");
------------------------------------------------------------------------------------------------
GRAND_X = 0; -- THIS IS THE PLAYER CENTER CHUNK POSITION
GRAND_Z = 0; -- IT'S USED TO DEFINE WHEN THE PLAYER HAS MOVED 16 UNITS ON A DIRECTION
GLOBAL_X = 0;
GLOBAL_Z = 0;
-------------------------------------------------------------------------------------------------
ptr_a100 = Instance.new("Part"); ptr_a100.Parent = game.Workspace; ptr_a100.Anchored = true;
ptr_a100.Position = Vector3.new( 32,0,32); ptr_a100.Color = Color3.new(1,0,0);
ptr_a100.Transparency = 1;
ptr_a100.CanCollide = false;
ptr_a010 = Instance.new("Part"); ptr_a010.Parent = game.Workspace; ptr_a010.Anchored = true;
ptr_a010.Position = Vector3.new(  0,0,32); ptr_a010.Color = Color3.new(0,1,0);
ptr_a010.Transparency = 1;
ptr_a010.CanCollide = false;
ptr_a001 = Instance.new("Part"); ptr_a001.Parent = game.Workspace; ptr_a001.Anchored = true;
ptr_a001.Position = Vector3.new(-32,0,32);  ptr_a001.Color = Color3.new(0,0,1);
ptr_a001.Transparency = 1;
ptr_a001.CanCollide = false;
-------------------------------------------------------------------------------------------------
ptr_b100 = Instance.new("Part"); ptr_b100.Parent = game.Workspace; ptr_b100.Anchored = true;
ptr_b100.Position = Vector3.new( 32,0, 0); ptr_b100.Color = Color3.new(1,0,0);
ptr_b100.Transparency = 1;
ptr_b100.CanCollide = false;
ptr_b010 = Instance.new("Part"); ptr_b010.Parent = game.Workspace; ptr_b010.Anchored = true;
ptr_b010.Position = Vector3.new(  0,0, 0); ptr_b010.Color = Color3.new(0,1,1);
ptr_b010.Transparency = 1;
ptr_b010.CanCollide = false;
ptr_b001 = Instance.new("Part"); ptr_b001.Parent = game.Workspace; ptr_b001.Anchored = true;
ptr_b001.Position = Vector3.new(-32,0, 0); ptr_b001.Color = Color3.new(0,0,1);
ptr_b001.Transparency = 1;
ptr_b001.CanCollide = false;
-------------------------------------------------------------------------------------------------
ptr_c100 = Instance.new("Part"); ptr_c100.Parent = game.Workspace; ptr_c100.Anchored = true;
ptr_c100.Position = Vector3.new( 32,0,-32); ptr_c100.Color = Color3.new(1,0,0);
ptr_c100.Transparency = 1;
ptr_c100.CanCollide = false;
ptr_c010 = Instance.new("Part"); ptr_c010.Parent = game.Workspace; ptr_c010.Anchored = true;
ptr_c010.Position = Vector3.new(  0,0,-32); ptr_c010.Color = Color3.new(1,1,0);
ptr_c010.Transparency = 1;
ptr_c010.CanCollide = false;
ptr_c001 = Instance.new("Part"); ptr_c001.Parent = game.Workspace; ptr_c001.Anchored = true;
ptr_c001.Position = Vector3.new(-32,0,-32); ptr_c001.Color = Color3.new(0,0,1);
ptr_c001.Transparency = 1;
ptr_c001.CanCollide = false;
--- NOW THAT THE TEMPLATES HAD BEEN CREATED IS TIME TO MAKE THE ARRAY TO EASY ACCESS ----
array = {}				-- WE FIRST INVOQUE THE CREATION OF THE ARRAY

for i=1,3 do			-- THEN WE CREATE A 3X3 MATRIX FOR OUR ARRAY POINTERS
	array[i] = {}		-- AND FOING THIS FOR LOOP WE PERFORM THE CREATION OF HE POINTERS

	for j=1,3 do
		array[i][j] = 0; -- THIS CREATES AN ARRAY
	end					 -- SO WE CAN STORE OUR PARTS AND THEN USE THEM
						 -- IN THE POSITION SHIFTING ALGORITHM
end						 -- THIS POSITION SHIFTWING WILL MOVE POINTERS IN ORDER TO CREATE NEW TERRAIN
-------------------------------------------------------------------------------------------------
array[1][1] = ptr_a100; array[1][2] = ptr_a010; array[1][3] = ptr_a001; -- IN THE VARIABLE NAMES I defined a code
array[2][1] = ptr_b100; array[2][2] = ptr_b010; array[2][3] = ptr_b001; -- WHICH IS XZ -> X is the letter a
array[3][1] = ptr_c100; array[3][2] = ptr_c010; array[3][3] = ptr_c001; -- and the z indicates the 1 position
-------------------------------------------------------------------------------------------------
water = Instance.new("Part");
water.Size = Vector3.new(1000,1,1000)
water.Color = Color3.new(0.4,0.4,0.8);
water.Material = Enum.Material.Ice;
water.Transparency = 0.6;
water.Anchored = true;
water.CanCollide = false;
water.Parent = game.Workspace;
---------------------------------------------------------------------------------------------
print ("pointers are initialized...");
---------------------------------------------------------
function perlin (x,z)
	return ((1 + math.noise(x/50,z/50,0.5))/2)*50
end

function genChunk (ptr,gx,gz)
	for x = 0, 32,2 do
		for z = 0,32,2 do
			temp_part = Instance.new ("Part");
			temp_part.Size = Vector3.new(2,2.5,2);
			temp_part.Anchored = true;
			temp_part.Position = Vector3.new( ((ptr.Position.X-16)+x),
											  perlin(((ptr.Position.X)+x),((ptr.Position.Z)+z)),
											  ((ptr.Position.Z-16)+z));
			temp_part.Parent = ptr;
			temp_part.Material = Enum.Material.Grass;
			if temp_part.Position.Y < 20 then
				temp_part.Color = Color3.new(0.317647, 0.580392, 0.360784)
			else
				temp_part.Material = Enum.Material.Snow;
				temp_part.Color = Color3.new(0.682353, 0.952941, 0.819608)
			end
		end
	end
end

genChunk(array[1][1],GRAND_X-1,GRAND_Z+1); genChunk(array[1][2],GRAND_X,GRAND_Z+1); genChunk(array[1][3],GRAND_X+1,GRAND_Z+1);
genChunk(array[2][1],GRAND_X-1,GRAND_Z  ); genChunk(array[2][2],GRAND_X,GRAND_Z  ); genChunk(array[2][3],GRAND_X+1,GRAND_Z  );
genChunk(array[3][1],GRAND_X-1,GRAND_Z-1); genChunk(array[3][2],GRAND_X,GRAND_Z-1); genChunk(array[3][3],GRAND_X+1,GRAND_Z-1);

while true do -- CHUNK LOOP WHICH CONTROLS THE MOVEMENT
	-- print("NEW CHUNKS HAD BEEN GENERATED")	
	player = script.Parent;
	GLOBAL_X = math.floor(player.Head.Position.X);
	GLOBAL_Z = math.floor(player.Head.Position.Z);
	
	lighting.FogEnd = 200
	lighting.FogStart = 0
	lighting.FogColor = Color3.new(0.709804, 0.709804, 0.709804)
	
	if GLOBAL_X > (GRAND_X+16) then
		print ("Hop in upper X");
		GRAND_X = GRAND_X + 32;
		array[1][3]:clearAllChildren();
		array[2][3]:clearAllChildren();
		array[3][3]:clearAllChildren();
		
		array[1][3].Position = Vector3.new(GRAND_X+32,array[1][3].Position.Y,array[1][3].Position.Z);
		array[2][3].Position = Vector3.new(GRAND_X+32,array[2][3].Position.Y,array[2][3].Position.Z);
		array[3][3].Position = Vector3.new(GRAND_X+32,array[3][3].Position.Y,array[3][3].Position.Z);
		
		temp_address  = array[1][3];
		temp_address2 = array[2][3];
		temp_address3 = array[3][3];
		
		array[1][3] = array[1][2];
		array[2][3] = array[2][2];
		array[3][3] = array[3][2];
		
		array[1][2] = array[1][1];
		array[2][2] = array[2][1];
		array[3][2] = array[3][1];

		array[1][1] = temp_address;
		array[2][1] = temp_address2;
		array[3][1] = temp_address3;
		
		genChunk(array[1][1],GRAND_X+1,GRAND_Z+1);
		genChunk(array[2][1],GRAND_X+1,GRAND_Z+1);
		genChunk(array[3][1],GRAND_X+1,GRAND_Z+1);
	end
	
	if GLOBAL_X < (GRAND_X-16) then
		print ("Hop in lower X");
		GRAND_X = GRAND_X - 32;
		array[1][1]:clearAllChildren();
		array[2][1]:clearAllChildren();
		array[3][1]:clearAllChildren();

		array[1][1].Position = Vector3.new(GRAND_X-32,array[1][1].Position.Y,array[1][1].Position.Z);
		array[2][1].Position = Vector3.new(GRAND_X-32,array[2][1].Position.Y,array[2][1].Position.Z);
		array[3][1].Position = Vector3.new(GRAND_X-32,array[3][1].Position.Y,array[3][1].Position.Z);

		temp_address  = array[1][1]; -- 2 3 1
		temp_address2 = array[2][1]; -- 1 2 3
		temp_address3 = array[3][1]; -- 3 1 2

		array[1][1] = array[1][2];
		array[2][1] = array[2][2];
		array[3][1] = array[3][2];

		array[1][2] = array[1][3];
		array[2][2] = array[2][3];
		array[3][2] = array[3][3];

		array[1][3] = temp_address;
		array[2][3] = temp_address2;
		array[3][3] = temp_address3;
		
		genChunk(array[1][3],GRAND_X+1,GRAND_Z+1);
		genChunk(array[2][3],GRAND_X+1,GRAND_Z+1);
		genChunk(array[3][3],GRAND_X+1,GRAND_Z+1);
	end
	
	if GLOBAL_Z > (GRAND_Z+16) then
		print ("Hop in upper Z");
		GRAND_Z = GRAND_Z + 32;
		
		array[3][1]:clearAllChildren();
		array[3][2]:clearAllChildren();
		array[3][3]:clearAllChildren();

		array[3][1].Position = Vector3.new(array[3][1].Position.X,array[3][1].Position.Y,GRAND_Z+32);
		array[3][2].Position = Vector3.new(array[3][2].Position.X,array[3][2].Position.Y,GRAND_Z+32);
		array[3][3].Position = Vector3.new(array[3][3].Position.X,array[3][3].Position.Y,GRAND_Z+32);

		temp_address  = array[3][1];
		temp_address2 = array[3][2];
		temp_address3 = array[3][3];

		array[3][1] = array[2][1];
		array[3][2] = array[2][2];
		array[3][3] = array[2][3];

		array[2][1] = array[1][1];
		array[2][2] = array[1][2];
		array[2][3] = array[1][3];

		array[1][1] = temp_address;
		array[1][2] = temp_address2;
		array[1][3] = temp_address3;
		
		genChunk(array[1][1],GRAND_X+1,GRAND_Z+1);
		genChunk(array[1][2],GRAND_X+1,GRAND_Z+1);
		genChunk(array[1][3],GRAND_X+1,GRAND_Z+1);
	end

	if GLOBAL_Z < (GRAND_Z-16) then
		print ("Hop in lower Z");
		GRAND_Z = GRAND_Z - 32;
		array[1][1]:clearAllChildren();
		array[1][2]:clearAllChildren();
		array[1][3]:clearAllChildren();

		array[1][1].Position = Vector3.new(array[1][1].Position.X,array[1][1].Position.Y,GRAND_Z-32);
		array[1][2].Position = Vector3.new(array[1][2].Position.X,array[1][2].Position.Y,GRAND_Z-32);
		array[1][3].Position = Vector3.new(array[1][3].Position.X,array[1][3].Position.Y,GRAND_Z-32);

		temp_address  = array[1][1]; -- 2 3 1
		temp_address2 = array[1][2]; -- 1 2 3
		temp_address3 = array[1][3]; -- 3 1 2

		array[1][1] = array[2][1];
		array[1][2] = array[2][2];
		array[1][3] = array[2][3];

		array[2][1] = array[3][1];
		array[2][2] = array[3][2];
		array[2][3] = array[3][3];

		array[3][1] = temp_address;
		array[3][2] = temp_address2;
		array[3][3] = temp_address3;
		
		genChunk(array[3][1],GRAND_X+1,GRAND_Z+1);
		genChunk(array[3][2],GRAND_X+1,GRAND_Z+1);
		genChunk(array[3][3],GRAND_X+1,GRAND_Z+1);
	end

	water.Position = Vector3.new(GRAND_X,15,GRAND_Z);

	wait(0.1);
end
