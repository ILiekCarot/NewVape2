
local cloneref = cloneref or function(obj) 
	return obj 
end
local playersService = cloneref(game:GetService('Players'))
local inputService = cloneref(game:GetService('UserInputService'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local collectionService = cloneref(game:GetService('CollectionService'))
local httpService = cloneref(game:GetService('HttpService'))
local coreGui = cloneref(game:GetService('CoreGui'))
local gameCamera = workspace.CurrentCamera
local lplr = playersService.LocalPlayer

local vape = shared.vape
local sessioninfo = vape.Libraries.sessioninfo

task.spawn(function()
	local kills = sessioninfo:AddItem('Kills')
	local eggs = sessioninfo:AddItem('Eggs')
	local wins = sessioninfo:AddItem('Wins')
	local games = sessioninfo:AddItem('Games')
end)
	
--- NEW MODULES ---

task.spawn(function() -- ForceField
	local ForceField
	local AvatarParts = {}
	local AvatarColor
	
	for _, x in pairs(lplr.Character:GetDescendants()) do
		if x:IsA("BasePart") then
			table.insert(AvatarParts, {Col = x.BrickColor, Ins = x})
		end
	end
	for _, x in pairs(workspace.Camera.Viewmodel:GetDescendants()) do
		if x:IsA("BasePart") then
			table.insert(AvatarParts, {Col = x.BrickColor, Ins = x})
		end
	end
	
	ForceField = vape.Categories.Render:CreateModule({
		Name = 'ForceField',
		Function = function(callback)
			repeat task.wait()
				for _, x in pairs(lplr.Character:GetDescendants()) do
					if x:IsA("BasePart") then
						x.Material = Enum.Material.ForceField
					end
				end
				for _, x in pairs(workspace.Camera.Viewmodel:GetDescendants()) do
					if x:IsA("BasePart") then
						x.Material = Enum.Material.ForceField
					end
				end
			until not ForceField.Enabled
			task.wait(.2)
			for _, x in pairs(AvatarParts) do i=x.Ins;local x=x.Col
				i.Material = Enum.Material.Plastic
				i.BrickColor = x
			end
		end,
		Tooltip = 'uhh.. makes nice avatar ig.'
	})
	AvatarColor = ForceField:CreateColorSlider({
		Name = 'Avatar Color',
		Function = function(hue, sat, val)
			if ForceField.Enabled then
				for _, x in pairs(lplr.Character:GetDescendants()) do
					if x:IsA("BasePart") then
						x.BrickColor = BrickColor.new(Color3.fromHSV(hue, sat, val))
					end
				end
				for _, x in pairs(workspace.Camera.Viewmodel:GetDescendants()) do
					if x:IsA("BasePart") then
						x.BrickColor = BrickColor.new(Color3.fromHSV(hue, sat, val))
					end
				end
			end
		end,
		Darker = true,
		Visible = true
	})
end)