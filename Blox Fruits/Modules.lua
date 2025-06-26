
-- Esp Fruit
function UpdateDevilChams() 
	for i, v in pairs(game.Workspace:GetChildren()) do
		pcall(function()
			if _G.ESPFruits then
				if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then 
					Id = nil
					if v:FindFirstChild("Fruit") then
						if v.Fruit:FindFirstChild("Animation") and v.Fruit.Animation:IsA("Animation") then
							Id = v.Fruit.Animation.AnimationId
						end
						if not Id and v.Fruit:FindFirstChild("Idle") and v.Fruit.Idle:IsA("Animation") then
							Id = v.Fruit.Idle.AnimationId
						end
					end
					if not Id and v:FindFirstChild("Fruit") and v.Fruit:FindFirstChild("Fruit") then
						if v.Fruit.Fruit:IsA("MeshPart") or v.Fruit.Fruit:IsA("SpecialMesh") then
							Id = v.Fruit.Fruit.MeshId
						end
					end

					if Id == "rbxassetid://15124425041" then FruitName = "Rocket Fruit"
					elseif Id == "rbxassetid://15123685330" then FruitName = "Spin Fruit"
					elseif Id == "rbxassetid://15123613404" then FruitName = "Blade Fruit"
					elseif Id == "rbxassetid://15123689268" then FruitName = "Spring Fruit"
					elseif Id == "rbxassetid://15123595806" then FruitName = "Bomb Fruit"
					elseif Id == "rbxassetid://15123677932" then FruitName = "Smoke Fruit"
					elseif Id == "rbxassetid://15124220207" then FruitName = "Spike Fruit"
					elseif Id == "rbxassetid://121545956771325" then FruitName = "Flame Fruit"
					elseif Id == "rbxassetid://15100433167" then FruitName = "Ice Fruit"
					elseif Id == "rbxassetid://15123673019" then FruitName = "Sand Fruit"
					elseif Id == "rbxassetid://15123618591" then FruitName = "Dark Fruit"
					elseif Id == "rbxassetid://77885466312115" then FruitName = "Eagle Fruit"
					elseif Id == "rbxassetid://15112600534" then FruitName = "Diamond Fruit"
					elseif Id == "rbxassetid://15123640714" then FruitName = "Light Fruit"
					elseif Id == "rbxassetid://15123668008" then FruitName = "Rubber Fruit"
					elseif Id == "rbxassetid://15123662036" then FruitName = "Ghost Fruit"
					elseif Id == "rbxassetid://15123645682" then FruitName = "Magma Fruit"
					elseif Id == "rbxassetid://15123659214" then FruitName = "Quake Fruit"
					elseif Id == "rbxassetid://15123606541" then FruitName = "Buddha Fruit"
					elseif Id == "rbxassetid://15123643097" then FruitName = "Love Fruit"
					elseif Id == "rbxassetid://15123681598" then FruitName = "Spider Fruit"
					elseif Id == "rbxassetid://116828771482820" then FruitName = "Creation Fruit"
					elseif Id == "rbxassetid://15123679712" then FruitName = "Sound Fruit"
					elseif Id == "rbxassetid://15123654553" then FruitName = "Rumble Fruit"
					elseif Id == "rbxassetid://15123656798" then FruitName = "Portal Fruit"
					elseif Id == "rbxassetid://15123670514" then FruitName = "Rumble Fruit"
					elseif Id == "rbxassetid://15123652069" then FruitName = "Pain Fruit"
					elseif Id == "rbxassetid://15123587371" then FruitName = "Blizzard Fruit"
					elseif Id == "rbxassetid://15123633312" then FruitName = "Gravity Fruit"
					elseif Id == "rbxassetid://15123648309" then FruitName = "Mammoth Fruit"
					elseif Id == "rbxassetid://15694681122" then FruitName = "T-Rex Fruit"
					elseif Id == "rbxassetid://15123624401" then FruitName = "Dough Fruit"
					elseif Id == "rbxassetid://15123675904" then FruitName = "Shadow Fruit"
					elseif Id == "rbxassetid://10773719142" then FruitName = "Venom Fruit"
					elseif Id == "rbxassetid://15123616275" then FruitName = "Control Fruit"
					elseif Id == "rbxassetid://11911905519" then FruitName = "Spirit Fruit"
					elseif Id == "rbxassetid://15123638064" then FruitName = "Leopard Fruit"
					elseif Id == "rbxassetid://15487764876" then FruitName = "Kitsune Fruit"
					elseif Id == "rbxassetid://115276580506154" then FruitName = "Yeti Fruit"
					elseif Id == "rbxassetid://118054805452821" then FruitName = "Gas Fruit"
					elseif Id == "rbxassetid://95749033139458" then FruitName = "Dragon Fruit"
					else FruitName = "Fruit [ ??? ]" end
					
					local Hdl = v:FindFirstChild("Handle")
					if not Hdl:FindFirstChild("Fruit ESP") then
						local bill = Instance.new("BillboardGui",Hdl)
						bill.Name = "Fruit ESP"
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(0, 240, 0, 40)
						bill.Adornee = Hld
						bill.AlwaysOnTop = true
						
						local name = Instance.new("TextLabel", bill)
						name.Font = Enum.Font.FredokaOne
						name.TextSize = 12
						name.TextWrapped = true
						name.Size = UDim2.new(1, 0, 1, 0)
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0
						name.RichText = true
						name.Text = string.format("<font color='rgb(255, 0, 0)'>"..FruitName.."</font><font color='rgb(169, 169, 169)'> [ "..math.floor((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/6).." ]</font>")
					else
						v.Handle["Fruit ESP"].TextLabel.Text = ("<font color='rgb(255, 0, 0)'>"..FruitName.."</font><font color='rgb(169, 169, 169)'> [ "..math.floof((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/6).." ]</font>")
					end
				end
			else
				if v:FindFirstChild("Handle") and v.Handle:FindFirstChild("Fruit ESP") then
					v.Handle:FindFirstChild("Fruit ESP"):Destroy()
				end
			end
		end)
	end
end
