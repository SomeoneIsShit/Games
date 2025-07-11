	-------------------------------[[ Others ]]-------------------------------
	local HttpService = game:GetService("HttpService")
	local Player = game.Players.LocalPlayer
	local PlayerName = Player and Player.Name or "Unknown Player"
	
	
	local RootFolder = "Someone Hub"           
	local MainFolder = "Main"                  
	local GameName = "Centaura"             
	local FilePrefix = "Someone Settings"      
	
	
	local FirstFolderPath = RootFolder .. "/" .. MainFolder
	local SecondFolderPath = FirstFolderPath .. "/" .. GameName
	local SaveFile = SecondFolderPath .. "/" .. FilePrefix .. " - " .. PlayerName .. ".json"
	
	
	local S = {
	--Main--
	--Player--
	["Walk Speed"] = 30,
	["Change Walk Speed"] = false,
	["Aimbot Distance"] = 250,
	["Aimbot Players"] = false,
	["Raycast Parameters"] = true,
	--Visual--
	["ESP Rival Players"] = false,
	}
	
	
	local secretKey = "minhaChaveSuperSecreta"
	
	
	local function EncryptData(data)
	    local encrypted = HttpService:JSONEncode(data)
	    
	    return encrypted
	end
	
	
	local function DecryptData(data)
	    
	    local decrypted = HttpService:JSONDecode(data)
	    return decrypted
	end
	
	
	local function SS()
	    local dataEncrypted = EncryptData(S)
	
	    if writefile and makefolder then
	        if not isfolder(RootFolder) then
	            makefolder(RootFolder)
	        end
	
	        if not isfolder(FirstFolderPath) then
	            makefolder(FirstFolderPath)
	        end
	
	        if not isfolder(SecondFolderPath) then
	            makefolder(SecondFolderPath)
	        end
	
	        writefile(SaveFile, dataEncrypted)
	    else
	        warn("Seu executor não suporta salvar arquivos.")
	    end
	end
	
	
	local function LoadSettings()
	    if isfile and readfile and isfile(SaveFile) then
	        local successRead, dataEncrypted = pcall(readfile, SaveFile)
	        if successRead then
	            local successDecode, dataDecoded = pcall(DecryptData, dataEncrypted)
	            if successDecode then
	                for k, v in pairs(dataDecoded) do
	                    S[k] = v
	                end
	            else
	                warn("Erro ao decodificar os dados.")
	            end
	        else
	            warn("Erro ao ler o arquivo de configurações.")
	        end
	    else
	        if not (isfile and readfile) then
	            warn("Seu executor não suporta leitura de arquivos.")
	        end
	        SS()
	    end
	end
	
	LoadSettings()
	for i, v in pairs(getgc(true)) do
		if type(v) == "table" and rawget(v, "GunType") and rawget(v, "firerate") and rawget(v, "AmmoCount") then
			v.Recoil = 0
			v.HeadshotMultiplier = 999
		end
	end


	if workspace.Map.Map:FindFirstChild("BarbedWire") then
	workspace.Map.Map:FindFirstChild("BarbedWire"):Destroy()
	end
	local Items = {
		["MortarShrapnelImpact"] = true,
		["AirburstMortarExplosionEffectPart"] = true,
		["Grenade"] = true,
		["Explosion"] = true,
		["SparkbombFlame"] = true,
		["ArtilleryExplosionEffectPart"] = true,
		["GrenadeExplosionEffectPart"] = true,
		["WhistleEffectPart"] = true,
		["AirburstMortarExplosion"] = true,
		["GrenadeExplosion"] = true,
	}
	
	
	for _, v in ipairs(workspace:GetChildren()) do
		if Items[v.Name] or Items[v.ClassName] then
			v:Destroy()
		end
	end
	
	workspace.ChildAdded:Connect(function(child)
		if Items[child.Name] or Items[child.ClassName] then
			child:Destroy()
		end
	end)
	
	-------------------------------[[ Main ]]-------------------------------
	task.spawn(function()
	    local Players = game:GetService("Players")
	    local LocalPlayer = Players.LocalPlayer
	    local pointLetters = { "A", "B", "C", "D", "E" }
	
	    while true do
	        task.wait(0.5)
	
	        if _G.CapturePointNil == true then
	            local Map = workspace:FindFirstChild("Map")
	            if not Map or not Map:FindFirstChild("Map") then
	                continue
	            end
	
	            local Statuses = Map.Map:FindFirstChild("PointStatuses")
	            local Points = Map.Map:FindFirstChild("Points")
	            if not Statuses or not Points then
	                continue
	            end
	
	            local available = {}
	            for _, letter in ipairs(pointLetters) do
	                local status = Statuses:FindFirstChild("Point" .. letter .. "Status")
	                if status and status.Value == nil then
	                    table.insert(available, letter)
	                end
	            end
	
	            if #available > 0 then
	                local letter = available[math.random(#available)]
	                local point = Points:FindFirstChild("Point" .. letter)
	                if point then
	                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	                    local hrp = character:WaitForChild("HumanoidRootPart")
	
	                    for _, part in ipairs(point:GetChildren()) do
	                        if part:IsA("BasePart") then
	                            hrp.CFrame = part.CFrame
	                            break
	                        end
	                    end
	                end
	            end
	        end
	    end
	end)
	-------------------------------[[ Player ]]-------------------------------
	task.spawn(function()
	    local Players = game:GetService("Players")
	    local LocalPlayer = Players.LocalPlayer
	
	    while task.wait() do
	        if _G.ChangeWalkSpeed then
	            local character = LocalPlayer.Character
	            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	
	            if humanoid and humanoid.WalkSpeed ~= _G.WalkSpeed then
	                humanoid.WalkSpeed = _G.WalkSpeed
	            end
	        end
	    end
	end)
	
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local LocalPlayer = Players.LocalPlayer
	local Camera = workspace.CurrentCamera
	
	local function LookAt(pos)
		Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, pos)
	end
	
	local function IsPlayerVisible(player)
		if not _G.RaycastParameters then return true end
	
		local char = player.Character
		if not char then return false end
	
		local head = char:FindFirstChild("Head")
		if not head then return false end
	
		local origin = Camera.CFrame.Position
		local direction = (head.Position - origin).Unit * 1000
	
		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Blacklist
		params.FilterDescendantsInstances = {LocalPlayer.Character}
		params.IgnoreWater = true
	
		local result = workspace:Raycast(origin, direction, params)
		return result and result.Instance and result.Instance:IsDescendantOf(char)
	end
	
	local function GetClosestEnemyByDistance()
		local closestPlayer = nil
		local shortestDistance = _G.AimbotDistance or 1000
	
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
				local char = player.Character
				local hum = char and char:FindFirstChildOfClass("Humanoid")
				local head = char and char:FindFirstChild("Head")
	
				if char and hum and head and hum.Health > 0 then
					local dist = (head.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
					if dist <= shortestDistance and IsPlayerVisible(player) then
						shortestDistance = dist
						closestPlayer = player
					end
				end
			end
		end
	
		return closestPlayer
	end
	
	RunService.RenderStepped:Connect(function()
		if not _G.AimbotPlayers then return end
	
		local target = GetClosestEnemyByDistance()
		if target and target.Character and target.Character:FindFirstChild("Head") then
			LookAt(target.Character.Head.Position)
		end
	end)
	
	-------------------------------[[ Visual ]]-------------------------------
	function ESPRivalPlayers()
		local Players = game:GetService("Players")
		local LocalPlayer = Players.LocalPlayer
		local character = LocalPlayer.Character
		local hrp = character and character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
	
		local AllPlayers = Players:GetPlayers()
	
		if not _G.ESPRivalPlayers then
			for _, plr in ipairs(AllPlayers) do
				local char = plr.Character
				if char then
					local head = char:FindFirstChild("Head")
					local espGui = head and head:FindFirstChild("Player ESP")
					if espGui then espGui:Destroy() end
	
					local highlight = char:FindFirstChild("RivalESPHighlight")
					if highlight then highlight:Destroy() end
				end
			end
			return
		end
	
		for _, plr in ipairs(AllPlayers) do
			if plr ~= LocalPlayer and plr.Team ~= LocalPlayer.Team then
				local char = plr.Character
				if char then
					local head = char:FindFirstChild("Head")
					local humanoid = char:FindFirstChild("Humanoid")
	
					if head then
						local dispname = plr.Name
						local maxhealth = humanoid and humanoid.MaxHealth
						local health = humanoid and math.floor(humanoid.Health)
						local distance = (head.Position - hrp.Position).Magnitude
						local distText = math.floor(distance)
						local healthText = (health and maxhealth) and string.format("[ %d/%d ]", health, maxhealth) or "[ ??? ]"
						local class = "..."
						local Classe = char:FindFirstChildOfClass("StringValue")
						if Classe then class = Classe.Value end
	
						-- Billboard
						local gui = head:FindFirstChild("Player ESP")
						if not gui then
							local bill = Instance.new("BillboardGui")
							bill.Name = "Player ESP"
							bill.Size = UDim2.new(0, 240, 0, 40)
							bill.Adornee = head
							bill.AlwaysOnTop = true
							bill.Parent = head
	
							local label = Instance.new("TextLabel")
							label.Name = "Label"
							label.Size = UDim2.new(1, 0, 1, 0)
							label.BackgroundTransparency = 1
							label.TextSize = 8.5
							label.Text = ""
							label.Font = "FredokaOne"
							label.TextStrokeTransparency = 0
							label.RichText = true
							label.Parent = bill
						end
	
						local label = gui and gui:FindFirstChild("Label")
						if label then
							label.Text = string.format(
								"<font color='rgb(200, 0, 0)'>%s</font> <font color='rgb(150, 150, 150)'>[ %d ]</font>\n<font color='rgb(0, 255, 0)'>%s</font> <font color='rgb(70, 70, 70)'>[ %s ]</font>",
								dispname, distText, healthText, class
							)
						end
	
						if not char:FindFirstChild("RivalESPHighlight") then
							local hl = Instance.new("Highlight")
							hl.Name = "RivalESPHighlight"
							hl.FillColor = Color3.fromRGB(255, 0, 0)
							hl.OutlineColor = Color3.fromRGB(0, 0, 0) 
							hl.FillTransparency = 0
							hl.OutlineTransparency = 0
							hl.Adornee = char
							hl.Parent = char
						end
					end
				end
			end
		end
	end
	
	task.spawn(function()
		while true do
			ESPRivalPlayers()
		task.wait()
		end
	end)
	-------------------------------[[ More ]]-------------------------------
	
	
		function SendWebhookBug(texto)
	    local HttpService = game:GetService("HttpService")
	    local Players = game:GetService("Players")
	    local MarketplaceService = game:GetService("MarketplaceService")
	    local ReplicatedStorage = game:GetService("ReplicatedStorage")
	
	    local Webhook = "https://discord.com/api/webhooks/1388052439701258240/CvNhSO8EfRQwAqivwMfx_LTsCE15PAlZ3nAthyISGWQdoHFqdNkVV13fv1oO41zzJjXb" 
	
	    local player = Players.LocalPlayer
	    if not player then return end
	
	    local nameDisplay = player.DisplayName
	    local nameUser = player.Name
	    local userId = player.UserId
	
	    local successParty, partyId = pcall(function()
	        return ReplicatedStorage.PartyId
	    end)
	    partyId = successParty and tostring(partyId) or "Desconhecida"
	
	    local successGame, gameInfo = pcall(function()
	        return MarketplaceService:GetProductInfo(game.PlaceId)
	    end)
	
	    local gameName = successGame and gameInfo.Name or "Desconhecido"
	
	    local data = os.date("*t")
	    local horaFormatada = string.format("%02d/%02d/%04d | %02d:%02d:%02d", data.day, data.month, data.year, data.hour, data.min, data.sec)
	
	    local embed = {
	        title = "📢 Novo Report de Bug",
	        description = table.concat({
	            "||@everyone|| ||@here||",
	            "",
	            "**O Jogador**",
	            nameDisplay .. " (@" .. nameUser .. ")",
	            "(UserId: " .. userId .. ")",
	            "(Party: " .. partyId .. ")",
	            "Game: " .. gameName,
	            "Hora: " .. horaFormatada,
	            "",
	            "**Reportou o Bug:**",
	            texto
	        }, "\n"),
	        color = tonumber(0x00FFFF)
	    }
	
	    http.request({
	        Url = Webhook,
	        Method = "POST",
	        Headers = {
	            ["Content-Type"] = "application/json"
	        },
	        Body = HttpService:JSONEncode({
	            content = nil,
	            embeds = {embed}
	        })
	    })
	end
	
	function SendWebhookSug(texto)
	    local HttpService = game:GetService("HttpService")
	    local Players = game:GetService("Players")
	    local MarketplaceService = game:GetService("MarketplaceService")
	    local ReplicatedStorage = game:GetService("ReplicatedStorage")
	
	    local Webhook = "https://discord.com/api/webhooks/1388052665031725136/c4ECc8tnsKe4B45LQZXDjzxZC35gIUCNQ6XOhsRr_vUFKB5CkN9k5GdWEgnSY2sJHOVK" 
	
	    local player = Players.LocalPlayer
	    if not player then return end
	
	    local nameDisplay = player.DisplayName
	    local nameUser = player.Name
	    local userId = player.UserId
	
	    local successParty, partyId = pcall(function()
	        return ReplicatedStorage.PartyId
	    end)
	    partyId = successParty and tostring(partyId) or "Desconhecida"
	
	    local successGame, gameInfo = pcall(function()
	        return MarketplaceService:GetProductInfo(game.PlaceId)
	    end)
	
	    local gameName = successGame and gameInfo.Name or "Desconhecido"
	
	    local data = os.date("*t")
	    local horaFormatada = string.format("%02d/%02d/%04d | %02d:%02d:%02d", data.day, data.month, data.year, data.hour, data.min, data.sec)
	
	    local embed = {
	        title = "📢 Nova Sugestão",
	        description = table.concat({
	            "||@everyone|| ||@here||",
	            "",
	            "**O Jogador**",
	            nameDisplay .. " (@" .. nameUser .. ")",
	            "(UserId: " .. userId .. ")",
	            "(Party: " .. partyId .. ")",
	            "Game: " .. gameName,
	            "Hora: " .. horaFormatada,
	            "",
	            "**Sugeriu:**",
	            texto
	        }, "\n"),
	        color = tonumber(0x00FFFF)
	    }
	
	    http.request({
	        Url = Webhook,
	        Method = "POST",
	        Headers = {
	            ["Content-Type"] = "application/json"
	        },
	        Body = HttpService:JSONEncode({
	            content = nil,
	            embeds = {embed}
	        })
	    })
	end
	
	local function IsRealText(value)
	    return typeof(value) == "string"
	        and #value > 2                                
	        and not tonumber(value)                       
	        and not value:lower():match("^true$")         
	        and not value:lower():match("^false$")        
	end
	
	-------------------------------[[ Window ]]-------------------------------
	
	local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SomeoneIsShit/Librarys/refs/heads/main/RedzLibrary.lua"))()
	
	local Window = redzlib:MakeWindow({
	Title = "Someone Hub - Centaura",
	SubTitle = "by Someone",
	SaveFolder = "Someone Settings.json"
	})
	
	Window:AddMinimizeButton({
	  Button = { Image = "rbxassetid://6390505386", BackgroundTransparency = 0 },
	  Corner = { CornerRadius = UDim.new(0, 6) }
	})
	
	local Discord = Window:MakeTab({Title = "Discord", Icon = "alertcircle"})
	--local Main = Window:MakeTab({Title = "Home", Icon = "home"})
	local Player = Window:MakeTab({Title = "Player", Icon = "usercog"})
	local Visual = Window:MakeTab({Title = "Visual", Icon = "eye"})
	local More = Window:MakeTab({Title = "More", Icon = "smile"})
	
	
	-------------------------------[[ Discord ]]-------------------------------
	Discord:AddDiscordInvite({
	Title = "Someone Hub",
	Description = "Join The World's Best Scripting Community",
	Logo = "rbxassetid://6390505386",
	Invite = "https://discord.gg/ReFNzFy6AZ",
	})
	
	-------------------------------[[ Main ]]-------------------------------
	
	-------------------------------[[ Player ]]-------------------------------
	
	Player : AddSection("Support")
	
	Player:AddSlider({
    Title = "Walk Speed",
    Description = "Select Walk Speed",
    Min = 16,
    Max = 50,
    Increase = 2,
    Default = S["Walk Speed"],
    Callback = function(Value)
        _G.WalkSpeed = Value
        S["Walk Speed"] = Value
        SS()
    end})

	Player:AddToggle({
    Title = "Change Walk Speed",
    Description = "Modify Walk Speed to Desired Speed",
    Default = S["Change Walk Speed"],
    Callback = function(Value)
        _G.ChangeWalkSpeed = Value
        S["Change Walk Speed"] = Value
        SS()
    end})
    
	Player : AddSection("Aimbot")
	
	Player : AddSlider({
    Title = "Aimbot Distance",
    Description = "Distance The Aimbot Will Work",
    Min = 10,
    Max = 750,
    Increase = 10,
    Default = S["Aimbot Distance"],
    Callback = function(Value)
    _G.AimbotDistance = Value
        S["Aimbot Distance"] = Value
        SS()
    end
    })
	
	Player:AddToggle({
    Title = "Aimbot Players",
    Description = "Aim at the Head of the Closest Enemy in Aimbot Radius",
    Default = S["Aimbot Players"],
    Callback = function(Value)
    _G.AimbotPlayers = Value
        S["Aimbot Players"] = Value
        SS()
    end})
	
	Player:AddToggle({
    Title = "Raycast Parameters",
    Description = "Creates a Raycast Parameter to Check Whether or Not the Target Is Visible",
    Default = S["Raycast Parameters"],
    Callback = function(Value)
    _G.RaycastParameters = Value
        S["Raycast Parameters"] = Value
        SS()
    end})
	
	-------------------------------[[ Visual ]]-------------------------------
	
	Visual : AddSection("Extra Sensorial Perception")
	
	Visual:AddToggle({
    Title = "ESP Rival Players",
    Description = "See the Rival Team's Players",
    Default = S["ESP Rival Players"],
    Callback = function(Value)
    _G.ESPRivalPlayers = Value
        S["ESP Rival Players"] = Value
        SS()
    end
	})
	
	-------------------------------[[ More ]]-------------------------------
	
	More : AddSection("Announcement")
	
	More : AddParagraph({
	Title = "If You Abuse The Bugs And Suggestions Features, \nYou Will Have Your Account Banned From Using The Hub",
	Description = ""
	})
	
	More : AddSection("Bugs")
	
	More:AddTextBox({
    Title = "Bug Report",
    Description = "Describe Exactly What Happened",
    PlaceholderText = "Paste Here",
    Callback = function(Value)
        _G.Bug = Value 
    end})
    
    More : AddButton({
    Title = "Submit Bug",
    Description = "Send Your Message To The Team",
    Callback = function()
    if IsRealText(_G.Bug) then
	    SendWebhookBug(_G.Bug)
	end
    end})
    
    More : AddSection("Suggestions")
    
    More:AddTextBox({
    Title = "Describe Your Suggestion",
    Description = "All Suggestions Are Welcome, We Count On You To Make\nThe Hub Even Better ",
    PlaceholderText = "Paste Here",
    Callback = function(Value)
    _G.Suggestion = Value
    end})

	More : AddButton({
    Title = "Submit Suggestion",
    Description = "Send Your Suggestion To Our Team",
    Callback = function()
    if IsRealText(_G.Suggestion) then
    SendWebhookSug(_G.Suggestion)
    end
    end})
	