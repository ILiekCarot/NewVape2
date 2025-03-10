local vape = shared.vape
local loadstring = function(...)
	local res, err = loadstring(...)
	if err and vape then 
		vape:CreateNotification('Vape', 'Failed to load : '..err, 30, 'alert') 
	end
	return res
end
local isfile = isfile or function(file)
	local suc, res = pcall(function() 
		return readfile(file) 
	end)
	return suc and res ~= nil and res ~= ''
end
local function downloadFile(path, func)
	if not isfile(path) then
		local suc, res = pcall(function() 
			return game:HttpGet('https://raw.githubusercontent.com/ILiekCarot/NewVape2/'..readfile('newvape/profiles/commit.txt')..'/'..select(1, path:gsub('newvape/', '')), true) 
		end)
		if not suc or res == '404: Not Found' then 
			error(res) 
		end
		if path:find('.lua') then 
			res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.\n'..res 
		end
		writefile(path, res)
	end
	return (func or readfile)(path)
end

vape.Place = 6872274481
if isfile('newvape/games/'..vape.Place..'.lua') then
	loadstring(readfile('newvape/games/'..vape.Place..'.lua'), 'bedwars')()
else
	if not shared.VapeDeveloper then
		local suc, res = pcall(function() 
			return game:HttpGet('https://raw.githubusercontent.com/ILiekCarot/NewVape2/'..readfile('newvape/profiles/commit.txt')..'/games/'..vape.Place..'.lua', true) 
		end)
		if suc and res ~= '404: Not Found' then
			loadstring(downloadFile('newvape/games/'..vape.Place..'.lua'), 'bedwars')()
		end
	end
end
	
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