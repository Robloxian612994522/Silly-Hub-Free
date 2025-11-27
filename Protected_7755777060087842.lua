local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local QuitautoPlay = false
local AutoGenSafer = false
local MapLoadedForGen = false
local OptionsChoose = false
local AutoGenActif = false
local Reach = false

local Options = Library.Options
local Toggles = Library.Toggles

_G.Delay = 2

local Pathfinding = game:GetService("PathfindingService")
local Workspace = game:GetService("Workspace")

Library.ForceCheckbox = false -- Forces AddToggle to AddCheckbox
Library.ShowToggleFrameInKeybinds = true -- Make toggle keybinds work inside the keybinds UI (aka adds a toggle to the UI). Good for mobile users (Default value = true)

local Window = Library:CreateWindow({
	-- Set Center to true if you want the menu to appear in the center
	-- Set AutoShow to true if you want the menu to appear when it is created
	-- Set Resizable to true if you want to have in-game resizable Window
	-- Set MobileButtonsSide to "Left" or "Right" if you want the ui toggle & lock buttons to be on the left or right side of the window
	-- Set ShowCustomCursor to false if you don't want to use the Linoria cursor
	-- NotifySide = Changes the side of the notifications (Left, Right) (Default value = Left)
	-- Position and Size are also valid options here
	-- but you do not need to define them unless you are changing them :)

	Title = "Legit Hub",
	Footer = "version: BETA 0.0.1",
	Icon = 15761903714,
	NotifySide = "Right",
	ShowCustomCursor = true,
})

local Tabs = {
	-- Creates a new tab titled Main
	Main = Window:AddTab("Main", "user"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

local lolz = {}
if _G.emergency_stop == nil or not _G.emergency_stop then
	_G.emergency_stop = false
end

local function StudsIntoPower(studs)
	return (studs * 2)
end

function lolz:ExtendHitbox(studs, time)
	local distance = StudsIntoPower(studs)
	local start = tick()
	local connection = nil
	if  _G.emergency_stop == true then
		_G.emergency_stop = false
	end
	repeat game:GetService("RunService").Heartbeat:Wait()
		local velocity = nil
		while not (game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Parent and game:GetService("Players").LocalPlayer.Character.HumanoidRootPart and game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Parent) do
			game:GetService("RunService").Heartbeat:Wait()
		end
		velocity = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = velocity * distance + (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * distance)
		game:GetService("RunService").RenderStepped:Wait()
		if (game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Parent and game:GetService("Players").LocalPlayer.Character.HumanoidRootPart and game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Parent) then
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = velocity
		end
	until tick() - start > tonumber(time) or _G.emergency_stop == true
	if _G.emergency_stop == true then
		_G.emergency_stop = false
	end
end

function lolz:StopExtendingHitbox()
	_G.emergency_stop = true
end

while true do
	wait(1)
	if Reach == true then
		lolz:ExtendHitbox(0.4, 0.1)
	end
end


local LeftGroupBox = Tabs.Main:AddLeftGroupbox("Killer")

LeftGroupBox:AddToggle("Reach (Mid Legit)", {
	Text = "This is a toggle",
	Tooltip = "This is a tooltip", -- Information shown when you hover over the toggle
	DisabledTooltip = "I am disabled!", -- Information shown when you hover over the toggle while it's disabled

	Default = false, -- Default value (true / false)
	Disabled = false, -- Will disable the toggle (true / false)
	Visible = true, -- Will make the toggle invisible (true / false)
	Risky = true, -- Makes the text red (the color can be changed using Library.Scheme.Red) (Default value = false)

	Callback = function(Value)
		Reach = Value
	end,
})

local LeftGroupBox2 = Tabs.Main:AddLeftGroupbox("Survivor")

LeftGroupBox2:AddToggle("Auto Generator (Legit)", {
	Text = "This automate generator Legitely by randomzing how much delay it needs to activatd",
	Tooltip = "Enables Auto Generator", -- Information shown when you hover over the toggle
	DisabledTooltip = "Disables Auto Generator", -- Information shown when you hover over the toggle while it's disabled

	Default = false, -- Default value (true / false)
	Disabled = false, -- Will disable the toggle (true / false)
	Visible = true, -- Will make the toggle invisible (true / false)
	Risky = false, -- Makes the text red (the color can be changed using Library.Scheme.Red) (Default value = false)

	Callback = function(Value)
		AutoGenActif = Value
	end,
})

LeftGroupBox2:AddSlider("Auto Gen Delay", {
	Text = "This is only for nodes way",
	Default = 2,
	Min = 2,
	Max = 6,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		_G.Delay = Value
	end,

	Tooltip = "Activated", -- Information shown when you hover over the slider
	DisabledTooltip = "Disabled", -- Information shown when you hover over the slider while it's disabled

	Disabled = false, -- Will disable the slider (true / false)
	Visible = true, -- Will make the slider invisible (true / false)
})

local MenuGroup = Tabs.Main:AddRightGroupbox("Unload")
MenuGroup:AddButton("Unload", function()
	Library:Unload()
end)



LeftGroupBox2:AddToggle("Auto Generator Customize", {
	Text = "Enables auto generator",
	Tooltip = "This is Nodes way", -- Information shown when you hover over the toggle
	DisabledTooltip = "This is Remotes way", -- Information shown when you hover over the toggle while it's disabled

	Default = false, -- Default value (true / false)
	Disabled = false, -- Will disable the toggle (true / false)
	Visible = true, -- Will make the toggle invisible (true / false)
	Risky = false, -- Makes the text red (the color can be changed using Library.Scheme.Red) (Default value = false)

	Callback = function(Value)
		OptionsChoose = Value
	end,
})


LeftGroupBox2:AddToggle("Auto Generator Depends on characters (Ultra Legit)", {
	Text = "This is like auto Generator but less delay depending on the skin and Playtime to make it more legit",
	Tooltip = "Enables Auto Generator", -- Information shown when you hover over the toggle
	DisabledTooltip = "Disables Auto Generator", -- Information shown when you hover over the toggle while it's disabled

	Default = false, -- Default value (true / false)
	Disabled = false, -- Will disable the toggle (true / false)
	Visible = true, -- Will make the toggle invisible (true / false)
	Risky = false, -- Makes the text red (the color can be changed using Library.Scheme.Red) (Default value = false)

	Callback = function(Value)
		print("[cb] MyToggle changed to:", Value)
	end,
})

while true do
	if MapLoadedForGen == true and OptionsChoose == false then
		if AutoGenSafer == true and game:GetService("Players").LocalPlayer.PlayerData.Equipped.Survivor.Value == "Noob" then
			task.wait(math.random(8, 12))
			for _,v in pairs(workspace.Map.Ingame.Map:GetChildren()) do
				if v.Name == "Generator" then
					v.Remotes.RE:FireServer()
				end
			end
		end
	end
end

while true do
	wait(1)
	if game.Workspace.Map.Ingame:FindFirstChild("Map") then
		for _,v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
			if v.Name == "Generator" then
				v.Remotes.RF.OnServerInvoke:Connect(function()
					if OptionsChoose == false then
						MapLoadedForGen = true
					else
						loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxian612994522/Silly-Hub-Free/refs/heads/main/AutoGen"))()
					end
				end)
			end
		end
	else
		MapLoadedForGen = false
	end
end
