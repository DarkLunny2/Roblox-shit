-- Cracked by darklunny ez
Client = {
    Modules = {
        ClientEnvoirment,
        ClientMain,
        CreateProj,
        CretTrail,
        ModsShit
    },
    Toggles = {
        BHop = false,
        Infammo = false,
        Automtatic = false,
        FireRate = false,
        NoRecoil = false,
        NoSpread = false,
        WallBang = false,
        InstantRespawn = false,
        AntiAim = false,
        AutoAmmo = false,
        AutoHealth = false,
        Trac = false,
        Sight = false,
        FOV = false,
        Golden = true,
        Visiblecheck = false,
        SilentAim = false,

    },
    Values = {
        JumpPower = 50,
        LookMeth = 'Look Up',                                                                                                                                                                                                                                                 
        Test = '',
        FOV = 150,
        ChatMsg = 'dexhub.xyz',
        AimPart = 'Head'

        
    }
}

-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Fuck dexhub V2 | "..identifyexecutor(), 5013109572)

-- themes
local themes = {
Background = Color3.fromRGB(24, 24, 24),
Glow = Color3.fromRGB(255, 0, 223),
Accent = Color3.fromRGB(10, 10, 10),
LightContrast = Color3.fromRGB(20, 20, 20),
DarkContrast = Color3.fromRGB(14, 14, 14),  
TextColor = Color3.fromRGB(255, 255, 255)
}

-- sections
-- 1st page
local combat = venyx:addPage("Combat", 7107223310)
local combatsection = combat:addSection("Combat Addons")
local gunmodsection = combat:addSection("Gun Modifiers")
-- 2nd page
local player = venyx:addPage("Player", 7107224011)
local playersection = player:addSection("Player Addons")
--3rd page
local visuals = venyx:addPage("Visuals", 7107224326)
local visualssection = visuals:addSection("Visual Addons")
--4th page
local misc = venyx:addPage("Misc", 7107223754)
local miscsection = misc:addSection("Misc Addons")
--5th page
local fun = venyx:addPage("Fun", 7107223519)
local funsection = fun:addSection("Fun Addons")
--6th page
local settings = venyx:addPage("Settings", 7107227420)
local settingssection = settings:addSection("Settings")
local settingstheme = settings:addSection("Theme Settings")

--7th page
local credits = venyx:addPage("Credits", 7107227847)
local creditssection = credits:addSection("Credits")

if hookmetamethod then

local OldNameCall
OldNameCall = hookmetamethod(game, "__newindex", function(A, B, ...)
    if not checkcaller()  and (B == "WalkSpeed" or B == "JumpPower") then
        return 23
    end
    return OldNameCall(A, B, ...)
end)
end
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 23
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 16
game.Players.LocalPlayer.CharacterAdded:Connect(
    function()
        repeat
            wait()
        until game.Players.LocalPlayer.Character
        wait(3)
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 23
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 16
    end
)

local CurrentCamera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
function ClosestPlayer()
    local MaxDist, Closest = math.huge
    for i,v in pairs(Players.GetPlayers(Players)) do
            local Head = v.Character.FindFirstChild(v.Character, "Head")
            if Head then 
                local Pos, Vis = CurrentCamera.WorldToScreenPoint(CurrentCamera, Head.Position)
                if Vis then
                    local MousePos, TheirPos = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
                    local Dist = (TheirPos - MousePos).Magnitude
                    if Dist < MaxDist and Dist <= Client.Values.FOV then
                        MaxDist = Dist
                        Closest = v
                    end
                end
            end
        
    end
    return Closest
end

function GetAimPart()
    if Client.Values.AimPart == 'Head' then
        return 'Head'
    end
    if Client.Values.AimPart == 'LowerTorso' then
        return 'LowerTorso'
    end
    if Client.Values.AimPart == 'Random' then
        if math.random(1,4) == 1 then
            return 'Head'
        else
            return 'LowerTorso'
        end
    end
end

local mt = getrawmetatable(game)
local namecallold = mt.__namecall
local index = mt.__index
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local Args = {...}
    NamecallMethod = getnamecallmethod()
    if tostring(NamecallMethod) == "FindPartOnRayWithIgnoreList" and Client.Toggles.WallBang then
        table.insert(Args[2], workspace.Map)
    end
    if NamecallMethod == "FindPartOnRayWithIgnoreList" and not checkcaller() and Client.Toggles.SilentAim then
        local CP = ClosestPlayer()
        if CP and CP.Character and CP.Character.FindFirstChild(CP.Character, GetAimPart()) then
            Args[1] = Ray.new(CurrentCamera.CFrame.Position, (CP.Character[GetAimPart()].Position - CurrentCamera.CFrame.Position).Unit * 1000)
            return namecallold(self, unpack(Args))
        end
    end
    if tostring(NamecallMethod) == "FireServer" and tostring(self) == "ControlTurn" then
        if Client.Toggles.AntiAim == true then
            if Client.Values.LookMeth == "Look Up" then
                Args[1] = 1.3962564026167
            end
            if Client.Values.LookMeth == "Look Down" then
                Args[1] = -1.5962564026167
            end
            if Client.Values.LookMeth == "Smell Your Butt" then
                Args[1] = -8.1
            end
            if Client.Values.LookMeth == "Give Your Self Top" then
                Args[1] = -3.1 --3.1
            end
            if Client.Values.LookMeth == "Torso In Legs" then
                Args[1] = -6.1;
            end
            return namecallold(self, unpack(Args))
        end
    end
    return namecallold(self, ...)
end)
setreadonly(mt, true)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 460
FOVCircle.Filled = false
FOVCircle.Transparency = 0.6
FOVCircle.Radius = Client.Values.FOV
FOVCircle.Color = Color3.new(255,0,0)
game:GetService("RunService").Stepped:Connect(function()
    if Client.Toggles.FireRate == true then
        Client.Modules.ClientEnvoirment.DISABLED = false
        Client.Modules.ClientEnvoirment.DISABLED2 = false
    end
    if Client.Toggles.NoRecoil == true then
        Client.Modules.ClientEnvoirment.recoil = 0
    end
    if Client.Toggles.NoSpread == true then
        Client.Modules.ClientEnvoirment.currentspread = 0
        Client.Modules.ClientEnvoirment.spreadmodifier = 0
    end
    if Client.Toggles.AlwaysAuto == true then
        Client.Modules.ClientEnvoirment.mode = 'automatic'
    end
    if Client.Toggles.InfAmmo == true then
        debug.setupvalue(Client.Modules.ModsShit, 3, 70)
    end
    FOVCircle.Radius = Client.Values.FOV
    if Client.Toggles.FOV == true then
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end
    FOVCircle.Position = game:GetService('UserInputService'):GetMouseLocation()
end)

spawn(function()
    while true do
        wait()
        if Client.Toggles.BHop == true then
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
        end
        if Client.Toggles.JumpPower == true then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Client.Values.JumpPower
        end
        if Client.Toggles.InstantRespawn == true then
            if not game.Players.LocalPlayer.Character:FindFirstChild('Spawned') and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Cam") then
                if game.Players.LocalPlayer.PlayerGui.Menew.Enabled == false then
                    game:GetService("ReplicatedStorage").Events.LoadCharacter:FireServer()
                    wait()
                end
            end
        end
    end
end)

function RandomPlr()
    tempPlrs = {}
    for i,v in pairs(game.Players:GetPlayers()) do
        if v and v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Team ~= game.Players.LocalPlayer.Team and v.Character:FindFirstChild("Spawned") then
            table.insert(tempPlrs,v)
        end
    end
    return tempPlrs[math.random(1,#tempPlrs)]    
end
function SwitchToKnife()
	local N = game:GetService("VirtualInputManager")
	N:SendKeyEvent(true, 51, false, game)
	N:SendKeyEvent(false, 51, false, game)	
end
function KnifeKill()

    OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local Crit = math.random() > .6 and true or false;
    Target = RandomPlr()
    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(Target.Character.Head.CFrame * CFrame.new(2,0,0))
end

combatsection:addKeybind("TP To Random Person", Enum.KeyCode.T, function()
    KnifeKill()
    warn("Teleported to Random Person!")
end)

combatsection:addToggle("Kill All", false, function(state)
    if state then
                game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value = false
local Farming = false
local Hopped = false
local TimeLeft = 30
local TurnBack = 4
local CheckTick = tick()
local PlayerLocked
local Back = true

function DetectPlayer()
	local Blacklist = {workspace.CurrentCamera}
	if game:GetService("Players").LocalPlayer.Character then
		table.insert(Blacklist, game:GetService("Players").LocalPlayer.Character)
	end
	if workspace:FindFirstChild("Map") then
		table.insert(Blacklist, workspace.Map)
	end

	local RaycastParam = RaycastParams.new()
	RaycastParam.FilterType = Enum.RaycastFilterType.Blacklist
	RaycastParam.FilterDescendantsInstances = Blacklist

	local NewRay = Ray.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0), workspace.CurrentCamera.CFrame.LookVector * 50000, RaycastParam)
	local PlayerGot

	if NewRay.Instance then
		if NewRay.Instance:IsDescendantOf(workspace) then
			if NewRay.Instance.Parent:IsA("Model") then
				if game:GetService("Players"):GetPlayerFromCharacter(NewRay.Instance.Parent) then
					PlayerGot = game:GetService("Players"):GetPlayerFromCharacter(NewRay.Instance.Parent)
				end
			elseif NewRay.Instance.Parent:IsA("Accessory") then
				if game:GetService("Players"):GetPlayerFromCharacter(NewRay.Instance.Parent.Parent) then
					PlayerGot = game:GetService("Players"):GetPlayerFromCharacter(NewRay.Instance.Parent.Parent)
				end
			end
		end

		if PlayerGot and PlayerGot.Status.Team.Value ~= game:GetService("Players").LocalPlayer.Status.Team.Value and PlayerGot.NRPBS.Health.Value > 0 then
			return true
		end
	end

	return false
end


function StartAutofarm()
	repeat wait() until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == false
	if game:GetService("ReplicatedStorage").wkspc.Status.LastGamemode.Value:lower():find("hackula") then ServerHop() return end
	
	Farming = true
	print("running")



	spawn(function()
		repeat
			if game:GetService("Players").LocalPlayer.Status.Team.Value ~= "Spectator" then
				for i,v in pairs(game:GetService("Players"):GetPlayers()) do
					if v ~= game:GetService("Players").LocalPlayer then
						if v.Character then
							if v.NRPBS.Health.Value > 0 then
								if v.Status.Team.Value ~= "Spectator" then
									if v.Character:FindFirstChild("Spawned") and v.Status.Team.Value ~= game:GetService("Players").LocalPlayer.Status.Team.Value then
										TimeLeft = 25
										TurnBack = 4
										Back = true
										repeat
											PlayerLocked = v
											wait(.5)
											TurnBack = TurnBack - 0.1
											if TurnBack <= 0 then
												Back = false
											elseif TurnBack <= -4 then
												break
											end
										until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value or not v or not v.Character or not v.Character:FindFirstChild("Spawned") or v.NRPBS.Health.Value <= 0 or v.Status.Team.Value == "Spectator" or v.Status.Alive.Value == false or game:GetService("Players").LocalPlayer.Status.Team.Value == v.Status.Team.Value
									end
								end
							end
						end
					end
				end
			end
			wait(0.4)
		until game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == true

		wait(1)
		print("f")
	end)
end



spawn(function()
	while wait(1) do
		if game:GetService("Players").LocalPlayer.NRPBS.Health.Value <= 0 and game:GetService("Players").LocalPlayer.Status.Team.Value ~= "Spectator" then
			game:GetService("ReplicatedStorage").Events.LoadCharacter:FireServer()
		end
	end
end)
local num = 6
local up = 0
game:GetService("RunService").RenderStepped:Connect(function()
	if Farming then
		if workspace:FindFirstChild("Map") and PlayerLocked and PlayerLocked.Character and PlayerLocked.NRPBS.Health.Value > 0 and PlayerLocked.Character:FindFirstChild("HeadHB") then
			workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, PlayerLocked.Character.HeadHB.Position)
			if Back then num = 2 up = 0 else num = -2 up = 2 end
			game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(
				PlayerLocked.Character.HumanoidRootPart.CFrame * CFrame.new(-1.0, up, num)
			)
			
			local RayParams = RaycastParams.new()
			RayParams.FilterType = Enum.RaycastFilterType.Blacklist
			RayParams.FilterDescendantsInstances = {workspace.CurrentCamera, game:GetService("Players").LocalPlayer.Character, workspace.Map.Ignore, workspace.Map.Clips}
				
			local Result = workspace:Raycast(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.LookVector * 10000, RayParams)
			local Player
			
			if Result and Result.Instance then
				if Result.Instance:IsDescendantOf(PlayerLocked.Character) then
					game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				end
			end
		end
	end
	
	if game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value == true then PlayerLocked = nil end
	if not game:GetService("Players").LocalPlayer.Character then PlayerLocked = nil end
	if game:GetService("Players").LocalPlayer.NRPBS.Health.Value <= 0 then PlayerLocked = nil end
end)

StartAutofarm()
for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
for i,c in next, v:GetChildren() do 
for i,x in next, getconnections(c.Changed) do
x:Disable() -- probably not needed
end
if c.Name == "Ammo" or c.Name == "StoredAmmo" then
c.Value = 300 -- don't set this above 300 or else your guns wont work
elseif c.Name == "AReload" or c.Name == "RecoilControl" or c.Name == "EReload" or c.Name == "SReload" or c.Name == "ReloadTime" or c.Name == "EquipTime" or c.Name == "Spread" or c.Name == "MaxSpread" then
c.Value = 0
elseif c.Name == "Range" then
c.Value = 9e9
elseif c.Name == "Auto" then
c.Value = true
elseif c.Name == "FireRate" or c.Name == "BFireRate" then
c.Value = 0.02 -- don't set this lower than 0.02 or else your game will crash
end
end
end
game:GetService('RunService').Stepped:connect(function() -- Infinite Ammo by Frontman#9917
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount.Value = 999 -- dont do it higher then 999
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount2.Value = 999
        end)
    else
        game:GetService("ReplicatedStorage").wkspc.Status.RoundOver.Value = true
    end
end)

_G.aimbot = false
function closestplayer()
    local dist = math.huge -- math.huge means a really large number, 1M+.
    local target = nil --- nil means no value
    local localplayer = game.Players.LocalPlayer
	for i,v in pairs(game:GetService("Players"):GetPlayers()) do
		if v ~= localplayer then
			if v.Character and v.Character:FindFirstChild("Head") and v.TeamColor ~= localplayer.TeamColor and _G.aimbot and v.Character.Humanoid.Health > 0 then --- creating the checks
    			local magnitude = (v.Character.Head.Position - localplayer.Character.Head.Position).magnitude
				if magnitude < dist then
					dist = magnitude
					target = v
				end
			end
		end
    end
    return target
end
local settings = {
	keybind = Enum.UserInputType.MouseButton2
}

local UIS = game:GetService("UserInputService")
local aiming = false --- this toggle will make it so we lock on to the person when we press our keybind

UIS.InputBegan:Connect(function(inp)
	if inp.UserInputType == settings.keybind then
		aiming = true
	end
end)

UIS.InputEnded:Connect(function(inp)
	if inp.UserInputType == settings.keybind then ---- when we stop pressing the keybind it would unlock off the player
		aiming = false
	end
end)

combatsection:addToggle("Aimlock", false, function(state)
    _G.aimbot = state
end)
local camera = workspace.CurrentCamera
spawn(function()
game:GetService("RunService").RenderStepped:Connect(function()
	if aiming and _G.aimbot then
		camera.CFrame = CFrame.new(camera.CFrame.Position,closestplayer().Character.Head.Position) -- locks into the HEAD
	end
end)
end)

combatsection:addToggle('Silent Aim', false, function(state)
    Client.Toggles.SilentAim = state
end)

combatsection:addToggle('Semi-WallBang', false, function(state)
    Client.Toggles.WallBang = state
end)

combatsection:addDropdown('Aim Part', {'Head','LowerTorso'} ,function(Selected)
    Client.Values.AimPart = Selected
end)

combatsection:addToggle('Draw FOV', false, function(state)
    Client.Toggles.FOV = state
end)

-- these two are buggy.
--combatsection:addSlider('FOV Size', 1, 950, 690,function(num)
--    Client.Values.FOV = num
--end)
--
--combatsection:addSlider('FOV Num Sides', 1, 50, 27, function(num)
--    FOVCircle.NumSides = num
--end)

combatsection:addColorPicker(
	"FOV Cicrle Color",
	Color3.fromRGB(255, 0, 0),
	function(Color)
		FOVCircle.Color = Color
	end
)

Config = {
    Infammo = false,
    Automtatic = false,
    FireRate = false,
    NoRecoil = false,
    NoSpread = false
}
gunmodsection:addButton('Best Gun Mods', function()
    for i,v in next, game.ReplicatedStorage.Weapons:GetChildren() do
for i,c in next, v:GetChildren() do 
for i,x in next, getconnections(c.Changed) do
x:Disable() -- probably not needed
end
if c.Name == "Ammo" or c.Name == "StoredAmmo" then
c.Value = 300 -- don't set this above 300 or else your guns wont work
elseif c.Name == "AReload" or c.Name == "RecoilControl" or c.Name == "EReload" or c.Name == "SReload" or c.Name == "ReloadTime" or c.Name == "EquipTime" or c.Name == "Spread" or c.Name == "MaxSpread" then
c.Value = 0
elseif c.Name == "Range" then
c.Value = 9e9
elseif c.Name == "Auto" then
c.Value = true
elseif c.Name == "FireRate" or c.Name == "BFireRate" then
c.Value = 0.02 -- don't set this lower than 0.02 or else your game will crash
end
end
end
game:GetService('RunService').Stepped:connect(function() -- Infinite Ammo by Frontman#9917
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount.Value = 999 -- dont do it higher then 999
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount2.Value = 999
        end)
end)

gunmodsection:addToggle('Infinite Ammo', false, function(state)
Config.Infammo = state
game:GetService("RunService").Stepped:connect(function()
    task.spawn(function()
                if Config.Infammo then
                    getsenv(game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Functions.Weapons).ammocount.Value = 25
                    getsenv(game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Functions.Weapons).ammocount.Value = 26
                end
        end)
    end)
end)

gunmodsection:addToggle('Always Auto', false, function(state)
Config.Automtatic = state
for _, v in pairs(game.ReplicatedStorage.Weapons:GetDescendants()) do
    if v.Name == "Auto" or v.Name == "AutoFire" or v.Name == "Automtatic" or v.Name == "AutoShoot" or v.Name == "AutoGun" then
        if Config.Automtatic then
            v.Value = true 
        else
            v.Value = false
        end
    end
end
end)

gunmodsection:addToggle('Fast Firerate', false, function(state)
Config.FireRate = state
for _, v in pairs(game.ReplicatedStorage.Weapons:GetDescendants()) do
    if v.Name == "FireRate" then
        if Config.FireRate then
            v.Value = 0.02 -- Fast Firerate
        else
            return -- v.Value = 0.8
        end
    end
end
end)

gunmodsection:addToggle('No Recoil', false, function(state)
Config.NoRecoil = state
for i, v in pairs(game:GetService("ReplicatedStorage").Weapons:GetDescendants()) do
    if v.Name == "RecoilControl" or v.Name == "Recoil" then
        if Config.NoRecoil then
            v.Value = 0 
        else
            v.Value = 1
        end
    end
end
end)

gunmodsection:addToggle("No Spread", false, function(state)
Config.NoSpread = state
for i, v in pairs(game:GetService("ReplicatedStorage").Weapons:GetDescendants()) do
    if v.Name == "MaxSpread" or v.Name == "Spread" or v.Name == "SpreadControl" then
        if Config.NoSpread then
            v.Value = 0 
        else
            v.Value = 1
        end
    end
end
end)

playersection:addSlider('Walkspeed', 23, 0, 200, function(value)
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = value
end)

playersection:addSlider('Arsenal FOV', 90, 0, 120, function(num)
    game:GetService("Players").LocalPlayer.Settings.FOV.Value = num
end)

playersection:addToggle('Fast Heal', false, function()
    while game.RunService.RenderStepped:Wait()do
    pcall(function()
        if game.Players.LocalPlayer.Character then
            if game.Players.LocalPlayer.NRPBS.Health.Value<=99 then
                if game.Players.LocalPlayer.Character:FindFirstChild("Spawned")then
                    for _,v in pairs(game.Workspace.Debris:GetChildren())do
                        if v.Name=="DeadHP"then
                            v.CFrame=game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                            v.Transparency=1
                        end
                    end
local args = {
    [1] = game:GetService("ReplicatedStorage").Weapons["Stake Launcher"],
    [2] = "Rolled!"
}

game:GetService("ReplicatedStorage").Events.ApplyGun:FireServer(unpack(args))
game.ReplicatedStorage.Events.HealBoy:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart)
local args = {
    [1] = game.Players.LocalPlayer.PlayerGui.GUI.Client.Variables.gun.Value,
    [2] = "Rolled!"
}

game:GetService("ReplicatedStorage").Events.ApplyGun:FireServer(unpack(args))
                    
                    wait(0.1)
                end
            end
        end
    end)
end
end)

playersection:addToggle('Fly (X)', false, function(state)
repeat wait() 
	until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
local mouse = game.Players.LocalPlayer:GetMouse() 
repeat wait() until mouse
local plr = game.Players.LocalPlayer 
local torso = plr.Character.Head 
local flying = false
local deb = true 
local ctrl = {f = 0, b = 0, l = 0, r = 0} 
local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
local maxspeed = 100
local speed = 0 

function Fly() 
local bg = Instance.new("BodyGyro", torso) 
bg.P = 9e4 
bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
bg.cframe = torso.CFrame 
local bv = Instance.new("BodyVelocity", torso) 
bv.velocity = Vector3.new(0,0.1,0) 
bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
repeat wait() 
plr.Character.Humanoid.PlatformStand = true 
if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then 
speed = speed+.5+(speed/maxspeed) 
if speed > maxspeed then 
speed = maxspeed 
end 
elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then 
speed = speed-1 
if speed < 0 then 
speed = 0 
end 
end 
if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then 
bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then 
bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
else 
bv.velocity = Vector3.new(0,0.1,0) 
end 
bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
until not flying 
ctrl = {f = 0, b = 0, l = 0, r = 0} 
lastctrl = {f = 0, b = 0, l = 0, r = 0} 
speed = 0 
bg:Destroy() 
bv:Destroy() 
plr.Character.Humanoid.PlatformStand = false 
end 
mouse.KeyDown:connect(function(key) 
if key:lower() == "x" then 
if flying then flying = false 
else 
flying = true 
Fly() 
end 
elseif key:lower() == "w" then 
ctrl.f = 1 
elseif key:lower() == "s" then 
ctrl.b = -1 
elseif key:lower() == "a" then 
ctrl.l = -1 
elseif key:lower() == "d" then 
ctrl.r = 1 
end 
end) 
mouse.KeyUp:connect(function(key) 
if key:lower() == "w" then 
ctrl.f = 0 
elseif key:lower() == "s" then 
ctrl.b = 0 
elseif key:lower() == "a" then 
ctrl.l = 0 
elseif key:lower() == "d" then 
ctrl.r = 0 
end 
end)
Fly()
    end)
playersection:addToggle('Infinite Jump', false, function(state)
    Client.Toggles.InfJump = state
end)
playersection:addToggle('Third Person', false, function(state)
    if state then 
        game:GetService("Players")["LocalPlayer"].PlayerGui.GUI.Client.Variables.thirdperson.Value = true
    else
        game:GetService("Players")["LocalPlayer"].PlayerGui.GUI.Client.Variables.thirdperson.Value = false
    end
end)
game:GetService("UserInputService").JumpRequest:connect(function()
    if Client.Toggles.InfJump == true then
        game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
    end
end)

playersection:addToggle('Bhop', false, function(state)
    Client.Toggles.BHop = state
end)

playersection:addToggle('Instant Respawn', false, function(state)
    Client.Toggles.InstantRespawn = state
end)

playersection:addButton('Noclip', function()
local noclip = false
local Noclipping = nil
local Clip = false
local speaker = game.Players.LocalPlayer
wait(0.1)
local function NoclipLoop()
if Clip == false and speaker.Character ~= nil then
    for _, child in pairs(speaker.Character:GetDescendants()) do
        if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
            child.CanCollide = false
        end
    end
end
end
Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)
end)

playersection:addTextbox("Kick Reason", "nil", function(value, focusLost)
    if focusLost then
        game.Players.LocalPlayer:Kick(value)
    end
end)

visualssection:addToggle('Banana ESP', false, function(boltss)
for i,v in pairs(game.Workspace:GetDescendants()) do -- grabs everything from workspace
    if v.ClassName == 'TouchTransmitter' and v.Parent.Name == 'Banana' then -- checks if it has a handle and if its a touchtransmitter
    if boltss then 
        local BillboardGui = Instance.new('BillboardGui') -- Makes Billboardgui
        local TextLabel = Instance.new('TextLabel') -- makes text label
        
        BillboardGui.Parent = v.Parent -- what the billboardgui goes into
        BillboardGui.AlwaysOnTop = true -- if its on top or not
        BillboardGui.Size = UDim2.new(0, 50, 0, 50) -- size of it
        BillboardGui.StudsOffset = Vector3.new(0,2,0)
        BillboardGui.Name = bolts
        
        TextLabel.Parent = BillboardGui -- putting textlabel into billboardgui
        TextLabel.BackgroundColor3 = Color3.new(1,1,1) -- color
        TextLabel.BackgroundTransparency = 1 -- transparency
        TextLabel.Size = UDim2.new(1, 0, 1, 0) -- size
        TextLabel.Text = "🍌" -- what the label says
        TextLabel.TextColor3 = Color3.new(1, 0, 0) -- color
        TextLabel.TextScaled = false -- if the text is scaled or not
    else 
        v.Parent:FindFirstChild(bolts):Destroy()
    end
end
end
end)

visualssection:addToggle("Head Dot",false,function(state)
if state == true then
_G.HeadDotsVisible = true
else if state == false then
_G.HeadDotsVisible = false
end
end 
end)

visualssection:addColorPicker("Head Dot Color", HeadDotC, function(color)
   _G.DotColor = color
end)

visualssection:addToggle("2D Boxes",false,function(state)
if state == true then
_G.SquaresVisible = true
else if state == false then
_G.SquaresVisible = false
end
end 
end)

visualssection:addColorPicker("2D Boxes Color", DBoxesC, function(color2)
   _G.SquareColor = color2
end)

visualssection:addToggle("Boxes",false,function(state)
if state == true then
_G.BoxesVisible = true
else if state == false then
_G.BoxesVisible = false
end
end 
end)

visualssection:addColorPicker("Boxes Color", BoxesC, function(color3)
   _G.LineColor = color3
end)

visualssection:addToggle("Tracers",false,function(state)
if state == true then
_G.TracersVisible = true
else if state == false then
_G.TracersVisible = false
end
end 
end)

visualssection:addColorPicker("Tracers Color", TracersC, function(color4)
   _G.TracerColor = color4
end)

miscsection:addToggle('Banana AutoFarm', false, function(Enabled)
    _G.BananaAutoFarm = Enabled
while _G.BananaAutoFarm do
    wait(0.1)
pcall(function()
        if game.Players.LocalPlayer.Character then
            local lastcfpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    for _,v in pairs(game.Workspace.Debris.Bananas:GetChildren())do
                        if v.Name=="Banana"then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                            v.Transparency= 0.1
                            repeat wait() until v.Parent == nil or wait(0.3)
                        end
                end
            end
    end)
end
end)

miscsection:addButton('Rejoin', function()
    local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Rejoin = coroutine.create(function()
    local Success, ErrorMessage = pcall(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)

    if ErrorMessage and not Success then
        warn(ErrorMessage)
    end
end)

coroutine.resume(Rejoin)
end)

miscsection:addButton('Server Hop', function()
local a={}
for _,v in pairs(game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100")).data)do
    if v.playing<v.maxPlayers then
        table.insert(a,v.id)
    end
end
while wait(0.1)do
    game.TeleportService:TeleportToPlaceInstance(game.PlaceId,a[math.random(1,#a)])
end
end)

miscsection:addButton("Redeem All Codes", function()
local Codes = {
  "unusualbias",
  "POG",
  "BLOXY",
  "Bandites",
  "EPRIKA",
  "FLAMINGO",
  "JOHN",
  "KITTEN",
  "PET",
  "ANNA",
  "F00LISH",
  "CBROX",
  "POKE",
  "ROLVE",
  "GARCELLO"
}
local RedeemEvent = game:GetService("ReplicatedStorage").Redeem
for _, event in pairs(Codes) do
  wait(0.5)
  RedeemEvent:InvokeServer(event)
end
end)

miscsection:addButton("Debug", function()
print("DexHub | Debug!")
end)

miscsection:addButton('FE Sunglasses','Cool Sunglasses Every can see',function()
    while true do wait(0.1) game:GetService("ReplicatedStorage").Events.Sunglasses:FireServer() end
end)
    

miscsection:addButton('FE Headless', function()
if game.Players.LocalPlayer.Character:FindFirstChild("HeadHB")then
            game.Players.LocalPlayer.Character:FindFirstChild("HeadHB"):Destroy()
        end
        if game.Players.LocalPlayer.Character:FindFirstChild("FakeHead")then
            game.Players.LocalPlayer.Character:FindFirstChild("FakeHead"):Destroy()
        end

end)

miscsection:addButton('Free Badge', function()
game:GetService("ReplicatedStorage").Events.ReplicateGear2:FireServer("coffee");
end) 

miscsection:addButton('Destory Arms And Legs', function()

    game.Players.LocalPlayer.Character.LeftLowerArm:Destroy()

    game.Players.LocalPlayer.Character.LeftUpperArm:Destroy()

    game.Players.LocalPlayer.Character.RightLowerArm:Destroy()

    game.Players.LocalPlayer.Character.RightUpperArm:Destroy()

    game.Players.LocalPlayer.Character.LeftFoot:Destroy()

    game.Players.LocalPlayer.Character.LeftLowerLeg:Destroy()

    game.Players.LocalPlayer.Character.LeftUpperLeg:Destroy()

    game.Players.LocalPlayer.Character.RightFoot:Destroy()

    game.Players.LocalPlayer.Character.RightLowerLeg:Destroy()

    game.Players.LocalPlayer.Character.RightUpperLeg:Destroy()
end)


miscsection:addButton('NonExisty', function()
  game.Players.LocalPlayer.Character.LeftLowerArm:Destroy()

    game.Players.LocalPlayer.Character.LeftUpperArm:Destroy()

    game.Players.LocalPlayer.Character.RightLowerArm:Destroy()

    game.Players.LocalPlayer.Character.RightUpperArm:Destroy()

    game.Players.LocalPlayer.Character.LeftFoot:Destroy()

    game.Players.LocalPlayer.Character.LeftLowerLeg:Destroy()

    game.Players.LocalPlayer.Character.LeftUpperLeg:Destroy()

    game.Players.LocalPlayer.Character.RightFoot:Destroy()

    game.Players.LocalPlayer.Character.RightLowerLeg:Destroy()

    game.Players.LocalPlayer.Character.RightUpperLeg:Destroy()

    local esc = game.Players.LocalPlayer.Character.LowerTorso:GetChildren()

    for i, v in pairs(esc) do

        v:Destroy()

        wait()

    end

    local vm = game:GetService("ReplicatedStorage").Viewmodels.Arms.Delinquent

    vm.Name = "Holder"

    local toName = game:GetService("ReplicatedStorage").Viewmodels.Arms["Nonexisty"]

    toName.Name = "Delinquent"

    local Core = getsenv(game.Players.LocalPlayer.PlayerGui.Menew.LocalScript);


    local Loadout;

    for i,v in pairs(getupvalues(Core.ViewItems)) do

        if typeof(v) == "table" then

            if v.Skins then

                Loadout = v;

            end

        end

    end


    table.insert(Loadout.Skins, "Nonexisty")
end)

funsection:addTextbox("Notification", "Default", function(value, focusLost)
print("Input", value)

if focusLost then
venyx:Notify("DexHub", value)
end
end)

funsection:addButton("Rainbow Gun", function()
local c = 1
function zigzag(X)
 return math.acos(math.cos(X * math.pi)) / math.pi
end
game:GetService("RunService").RenderStepped:Connect(function()
 if game.Workspace.Camera:FindFirstChild('Arms') then
  for i,v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do
   if v.ClassName == 'MeshPart' then 
    v.Color = Color3.fromHSV(zigzag(c),1,1)
    c = c + .0001
   end
  end
 end
end)

end)

--funsection:Toggle('Chat Spam','Spams Chat',false,function(state)
--    Client.Toggles.SpamChat = state
--end)
--spawn(function()
--    while true do
--        wait(.01)
--        if Client.Toggles.SpamChat == true then
--
--local args = {
--    [1] = "Trolling42",
--    [2] = Client.Values.ChatMsg,
--    [3] = false,
--    [5] = false,
--    [6] = true
--}
--
--game:GetService("ReplicatedStorage").Events.PlayerChatted:FireServer(unpack(args))
--
--            wait(0.1)
--        end
--    end
--end)

settingssection:addKeybind("Toggle Keybind", Enum.KeyCode.RightShift, function()
print("Activated Keybind")
venyx:toggle()
end, function()
print("Changed Keybind")
end)

settingssection:addButton("Destroy GUI", function()
    game:GetService("CoreGui")["DexHub V2 | "..identifyexecutor()]:Destroy()
end)

for theme, color in pairs(themes) do
settingstheme:addColorPicker(theme, color, function(color3)
venyx:setTheme(theme, color3)
end)
end

creditssection:addButton("Credits to Bolts", function()
venyx:Notify("DexHub", "<3")
end)

creditssection:addButton("DexHub Website", function()
venyx:Notify("DexHub", "https://dexhub.xyz")
end)
creditssection:addButton("DexHub Discord", function()
venyx:Notify("DexHub", "https://discord.io/dexhub")
end)

-- tracers
local function API_Check()
    if Drawing == nil then
        return "No"
    else
        return "Yes"
    end
end

local Find_Required = API_Check()

if Find_Required == "No" then
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "DexHub";
        Text = "Tracer script could not be loaded because your exploit is unsupported.";
        Duration = math.huge;
        Button1 = "OK"
    })

    return
end

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = game:GetService("Workspace").CurrentCamera
local UserInputService = game:GetService("UserInputService")
local TestService = game:GetService("TestService")

local Typing = false

_G.SendNotifications = false   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
_G.DefaultSettings = false   -- If set to true then the tracer script would run with default settings regardless of any changes you made.

_G.TeamCheck = true   -- If set to true then the script would create tracers only for the enemy team members.

--[!]-- ONLY ONE OF THESE VALUES SHOULD BE SET TO TRUE TO NOT ERROR THE SCRIPT --[!]--

_G.FromMouse = false   -- If set to true, the tracers will come from the position of your mouse curson on your screen.
_G.FromCenter = false   -- If set to true, the tracers will come from the center of your screen.
_G.FromBottom = true   -- If set to true, the tracers will come from the bottom of your screen.

_G.TracersVisible = false   -- If set to true then the tracers will be visible and vice versa.
_G.TracerColor = Color3.fromRGB(255, 80, 10)   -- The color that the tracers would appear as.
_G.TracerThickness = 1   -- The thickness of the tracers.
_G.TracerTransparency = 0.7   -- The transparency of the tracers.

--_G.ModeSkipKey = Enum.KeyCode.E   -- The key that changes between modes that indicate where will the tracers come from.
--_G.DisableKey = Enum.KeyCode.LeftBracket   -- The key that disables / enables the tracers.

local function CreateTracers()
    for _, v in next, Players:GetPlayers() do
        if v.Name ~= game.Players.LocalPlayer.Name then
            local TracerLine = Drawing.new("Line")
    
            RunService.RenderStepped:Connect(function()
                if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                    local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * 1
                    local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(0, -HumanoidRootPart_Size.Y, 0).p)
                    
                    TracerLine.Thickness = _G.TracerThickness
                    TracerLine.Transparency = _G.TracerTransparency
                    TracerLine.Color = _G.TracerColor

                    if _G.FromMouse == true and _G.FromCenter == false and _G.FromBottom == false then
                        TracerLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                    elseif _G.FromMouse == false and _G.FromCenter == true and _G.FromBottom == false then
                        TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    elseif _G.FromMouse == false and _G.FromCenter == false and _G.FromBottom == true then
                        TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    end

                    if OnScreen == true  then
                        TracerLine.To = Vector2.new(Vector.X, Vector.Y)
                        if _G.TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                TracerLine.Visible = _G.TracersVisible
                            else
                                TracerLine.Visible = false
                            end
                        else
                            TracerLine.Visible = _G.TracersVisible
                        end
                    else
                        TracerLine.Visible = false
                    end
                else
                    TracerLine.Visible = false
                end
            end)

            Players.PlayerRemoving:Connect(function()
                TracerLine.Visible = false
            end)
        end
    end

    Players.PlayerAdded:Connect(function(Player)
        Player.CharacterAdded:Connect(function(v)
            if v.Name ~= game.Players.LocalPlayer.Name then
                local TracerLine = Drawing.new("Line")
        
                RunService.RenderStepped:Connect(function()
                    if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                        local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * 1
                    	local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(0, -HumanoidRootPart_Size.Y, 0).p)
                        
                        TracerLine.Thickness = _G.TracerThickness
                        TracerLine.Transparency = _G.TracerTransparency
                        TracerLine.Color = _G.TracerColor

                        if _G.FromMouse == true and _G.FromCenter == false and _G.FromBottom == false then
                            TracerLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                        elseif _G.FromMouse == false and _G.FromCenter == true and _G.FromBottom == false then
                            TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                        elseif _G.FromMouse == false and _G.FromCenter == false and _G.FromBottom == true then
                            TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        end

                        if OnScreen == true  then
                            TracerLine.To = Vector2.new(Vector.X, Vector.Y)
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
                                    TracerLine.Visible = _G.TracersVisible
                                else
                                    TracerLine.Visible = false
                                end
                            else
                                TracerLine.Visible = _G.TracersVisible
                            end
                        else
                            TracerLine.Visible = false
                        end
                    else
                        TracerLine.Visible = false
                    end
                end)

                Players.PlayerRemoving:Connect(function()
                    TracerLine.Visible = false
                end)
            end
        end)
    end)
end

UserInputService.TextBoxFocused:Connect(function()
    Typing = true
end)

UserInputService.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == _G.ModeSkipKey and Typing == false then
        if _G.FromMouse == true and _G.FromCenter == false and _G.FromBottom == false and _G.TracersVisible == true then
            _G.FromCenter = false
            _G.FromBottom = true
            _G.FromMouse = false

            if _G.SendNotifications == true then
                game:GetService("StarterGui"):SetCore("SendNotification",{
                    Title = "DexHub";
                    Text = "Tracers will be now coming from the bottom of your screen (Mode 1)";
                    Duration = 5;
                })
            end
        elseif _G.FromMouse == false and _G.FromCenter == false and _G.FromBottom == true and _G.TracersVisible == true then
            _G.FromCenter = true
            _G.FromBottom = false
            _G.FromMouse = false

            if _G.SendNotifications == true then
                game:GetService("StarterGui"):SetCore("SendNotification",{
                    Title = "DexHub";
                    Text = "Tracers will be now coming from the center of your screen (Mode 2)";
                    Duration = 5;
                })
            end
        elseif _G.FromMouse == false and _G.FromCenter == true and _G.FromBottom == false and _G.TracersVisible == true then
            _G.FromCenter = false
            _G.FromBottom = false
            _G.FromMouse = true

            if _G.SendNotifications == true then
                game:GetService("StarterGui"):SetCore("SendNotification",{
                    Title = "DexHub";
                    Text = "Tracers will be now coming from the position of your mouse cursor on your screen (Mode 3)";
                    Duration = 5;
                })
            end
        end
    elseif Input.KeyCode == _G.DisableKey and Typing == false then
        _G.TracersVisible = not _G.TracersVisible
        
        if _G.SendNotifications == true then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "DexHub";
                Text = "The tracers' visibility is now set to "..tostring(_G.TracersVisible)..".";
                Duration = 5;
            })
        end
    end
end)

if _G.DefaultSettings == true then
    _G.TeamCheck = false
    _G.FromMouse = false
    _G.FromCenter = false
    _G.FromBottom = true
    _G.TracersVisible = true
    _G.TracerColor = Color3.fromRGB(40, 90, 255)
    _G.TracerThickness = 1
    _G.TracerTransparency = 0.5
    _G.ModeSkipKey = Enum.KeyCode.E
    _G.DisableKey = Enum.KeyCode.Q
end

local Success, Errored = pcall(function()
    CreateTracers()
end)

if Success and not Errored then
    if _G.SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "DexHub";
            Text = "Tracer script has successfully loaded.";
            Duration = 5;
        })
    end
elseif Errored and not Success then
    if _G.SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "DexHub";
            Text = "Tracer script has errored while loading, please check the developer console! (F9)";
            Duration = 5;
        })
    end
end

-- boxes
local function API_Check()
    if Drawing == nil then
        return "No"
    else
        return "Yes"
    end
end

local Find_Required = API_Check()

if Find_Required == "No" then
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Text = "Boxes script could not be loaded because your exploit is unsupported.";
        Duration = math.huge;
        Button1 = "OK"
    })

    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local Typing = false

_G.SendNotifications = false   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
_G.DefaultSettings = false   -- If set to true then the boxes script would run with default settings regardless of any changes you made.

_G.TeamCheck = true   -- If set to true then the script would create boxes only for the enemy team members.

_G.BoxesVisible = false   -- If set to true then the boxes will be visible and vice versa.
_G.LineColor = Color3.fromRGB(255, 80, 10)   -- The color that the boxes would appear as.
_G.LineThickness = 1   -- The thickness of the boxes.
_G.LineTransparency = 0.7   -- The transparency of the boxes.
_G.SizeIncrease = 1   -- How much the box's size is increased (The size is multiplied by the value of this variable). (1 is default, anything more then 2 is not recommended) <float> / <int>

--_G.DisableKey = Enum.KeyCode.Q   -- The key that disables / enables the boxes.

local function CreateBoxes()
    for _, v in next, Players:GetPlayers() do
        if v.Name ~= Players.LocalPlayer.Name then
            local TopLeftLine = Drawing.new("Line")
            local TopRightLine = Drawing.new("Line")
            local BottomLeftLine = Drawing.new("Line")
            local BottomRightLine = Drawing.new("Line")

            RunService.RenderStepped:Connect(function()
                if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then 
                    TopLeftLine.Thickness = _G.LineThickness
                    TopLeftLine.Transparency = _G.LineTransparency
                    TopLeftLine.Color = _G.LineColor

                    TopRightLine.Thickness = _G.LineThickness
                    TopRightLine.Transparency = _G.LineTransparency
                    TopRightLine.Color = _G.LineColor

                    BottomLeftLine.Thickness = _G.LineThickness
                    BottomLeftLine.Transparency = _G.LineTransparency
                    BottomLeftLine.Color = _G.LineColor

                    BottomRightLine.Thickness = _G.LineThickness
                    BottomRightLine.Transparency = _G.LineTransparency
                    BottomRightLine.Color = _G.LineColor
                    
                    local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * _G.SizeIncrease

                    local TopLeftPosition, TopLeftVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(HumanoidRootPart_Size.X,  HumanoidRootPart_Size.Y, 0).p)
                    local TopRightPosition, TopRightVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(-HumanoidRootPart_Size.X,  HumanoidRootPart_Size.Y, 0).p)
                    local BottomLeftPosition, BottomLeftVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(HumanoidRootPart_Size.X, -HumanoidRootPart_Size.Y, 0).p)
                    local BottomRightPosition, BottomRightVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(-HumanoidRootPart_Size.X, -HumanoidRootPart_Size.Y, 0).p)

                    if TopLeftVisible == true then
                        TopLeftLine.From = Vector2.new(TopLeftPosition.X, TopLeftPosition.Y)
                        TopLeftLine.To = Vector2.new(TopRightPosition.X, TopRightPosition.Y)
                        if _G.TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                TopLeftLine.Visible = _G.BoxesVisible
                            else
                                TopLeftLine.Visible = false
                            end
                        else
                            TopLeftLine.Visible = _G.BoxesVisible
                        end
                    else
                        TopLeftLine.Visible = false
                    end

                    if TopRightVisible == true and _G.BoxesVisible == true then
                        TopRightLine.From = Vector2.new(TopRightPosition.X, TopRightPosition.Y)
                        TopRightLine.To = Vector2.new(BottomRightPosition.X, BottomRightPosition.Y)
                        if _G.TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                TopRightLine.Visible = _G.BoxesVisible
                            else
                                TopRightLine.Visible = false
                            end
                        else
                            TopRightLine.Visible = _G.BoxesVisible
                        end
                    else
                        TopRightLine.Visible = false
                    end

                    if BottomLeftVisible == true and _G.BoxesVisible == true then
                        BottomLeftLine.From = Vector2.new(BottomLeftPosition.X, BottomLeftPosition.Y)
                        BottomLeftLine.To = Vector2.new(TopLeftPosition.X, TopLeftPosition.Y)
                        if _G.TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                BottomLeftLine.Visible = _G.BoxesVisible
                            else
                                BottomLeftLine.Visible = false
                            end
                        else
                            BottomLeftLine.Visible = _G.BoxesVisible
                        end
                    else
                        BottomLeftLine.Visible = false
                    end

                    if BottomRightVisible == true and _G.BoxesVisible == true then
                        BottomRightLine.From = Vector2.new(BottomRightPosition.X, BottomRightPosition.Y)
                        BottomRightLine.To = Vector2.new(BottomLeftPosition.X, BottomLeftPosition.Y)
                        if _G.TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                BottomRightLine.Visible = _G.BoxesVisible
                            else
                                BottomRightLine.Visible = false
                            end
                        else
                            BottomRightLine.Visible = _G.BoxesVisible
                        end
                    else
                        BottomRightLine.Visible = false
                    end
                else
                    TopRightLine.Visible = false
                    TopLeftLine.Visible = false
                    BottomLeftLine.Visible = false
                    BottomRightLine.Visible = false
                end
            end)

            Players.PlayerRemoving:Connect(function()
                TopRightLine.Visible = false
                TopLeftLine.Visible = false
                BottomLeftLine.Visible = false
                BottomRightLine.Visible = false
            end)
        end
    end

    Players.PlayerAdded:Connect(function(Player)
        Player.CharacterAdded:Connect(function(v)
            if v.Name ~= Players.LocalPlayer.Name then
                local TopLeftLine = Drawing.new("Line")
                local TopRightLine = Drawing.new("Line")
                local BottomLeftLine = Drawing.new("Line")
                local BottomRightLine = Drawing.new("Line")
    
                RunService.RenderStepped:Connect(function()
                    if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then 
                        TopLeftLine.Thickness = _G.LineThickness
                        TopLeftLine.Transparency = _G.LineTransparency
                        TopLeftLine.Color = _G.LineColor
    
                        TopRightLine.Thickness = _G.LineThickness
                        TopRightLine.Transparency = _G.LineTransparency
                        TopRightLine.Color = _G.LineColor
    
                        BottomLeftLine.Thickness = _G.LineThickness
                        BottomLeftLine.Transparency = _G.LineTransparency
                        BottomLeftLine.Color = _G.LineColor
    
                        BottomRightLine.Thickness = _G.LineThickness
                        BottomRightLine.Transparency = _G.LineTransparency
                        BottomRightLine.Color = _G.LineColor
                        
                        local HumanoidRootPart_Position, HumanoidRootPart_Size = workspace[v.Name].HumanoidRootPart.CFrame, workspace[v.Name].HumanoidRootPart.Size * _G.SizeIncrease
    
                        local TopLeftPosition, TopLeftVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(HumanoidRootPart_Size.X,  HumanoidRootPart_Size.Y, 0).p)
                        local TopRightPosition, TopRightVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(-HumanoidRootPart_Size.X,  HumanoidRootPart_Size.Y, 0).p)
                        local BottomLeftPosition, BottomLeftVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(HumanoidRootPart_Size.X, -HumanoidRootPart_Size.Y, 0).p)
                        local BottomRightPosition, BottomRightVisible = Camera:WorldToViewportPoint(HumanoidRootPart_Position * CFrame.new(-HumanoidRootPart_Size.X, -HumanoidRootPart_Size.Y, 0).p)
    
                        if TopLeftVisible == true then
                            TopLeftLine.From = Vector2.new(TopLeftPosition.X, TopLeftPosition.Y)
                            TopLeftLine.To = Vector2.new(TopRightPosition.X, TopRightPosition.Y)
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
                                    TopLeftLine.Visible = _G.BoxesVisible
                                else
                                    TopLeftLine.Visible = false
                                end
                            else
                                TopLeftLine.Visible = _G.BoxesVisible
                            end
                        else
                            TopLeftLine.Visible = false
                        end
    
                        if TopRightVisible == true and _G.BoxesVisible == true then
                            TopRightLine.From = Vector2.new(TopRightPosition.X, TopRightPosition.Y)
                            TopRightLine.To = Vector2.new(BottomRightPosition.X, BottomRightPosition.Y)
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
                                    TopRightLine.Visible = _G.BoxesVisible
                                else
                                    TopRightLine.Visible = false
                                end
                            else
                                TopRightLine.Visible = _G.BoxesVisible
                            end
                        else
                            TopRightLine.Visible = false
                        end
    
                        if BottomLeftVisible == true and _G.BoxesVisible == true then
                            BottomLeftLine.From = Vector2.new(BottomLeftPosition.X, BottomLeftPosition.Y)
                            BottomLeftLine.To = Vector2.new(TopLeftPosition.X, TopLeftPosition.Y)
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
                                    BottomLeftLine.Visible = _G.BoxesVisible
                                else
                                    BottomLeftLine.Visible = false
                                end
                            else
                                BottomLeftLine.Visible = _G.BoxesVisible
                            end
                        else
                            BottomLeftLine.Visible = false
                        end
    
                        if BottomRightVisible == true and _G.BoxesVisible == true then
                            BottomRightLine.From = Vector2.new(BottomRightPosition.X, BottomRightPosition.Y)
                            BottomRightLine.To = Vector2.new(BottomLeftPosition.X, BottomLeftPosition.Y)
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
                                    BottomRightLine.Visible = _G.BoxesVisible
                                else
                                    BottomRightLine.Visible = false
                                end
                            else
                                BottomRightLine.Visible = _G.BoxesVisible
                            end
                        else
                            BottomRightLine.Visible = false
                        end
                    else
                        TopRightLine.Visible = false
                        TopLeftLine.Visible = false
                        BottomLeftLine.Visible = false
                        BottomRightLine.Visible = false
                    end
                end)
    
                Players.PlayerRemoving:Connect(function()
                    TopRightLine.Visible = false
                    TopLeftLine.Visible = false
                    BottomLeftLine.Visible = false
                    BottomRightLine.Visible = false
                end)
            end
        end)
    end)
end

if _G.DefaultSettings == true then
    _G.TeamCheck = false
    _G.BoxesVisible = true
    _G.LineColor = Color3.fromRGB(40, 90, 255)
    _G.LineThickness = 1
    _G.LineTransparency = 0.5
    _G.SizeIncrease = 1.5
    _G.DisableKey = Enum.KeyCode.Q
end

UserInputService.TextBoxFocused:Connect(function()
    Typing = true
end)

UserInputService.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == _G.DisableKey and Typing == false then
        _G.BoxesVisible = not _G.BoxesVisible
        
        if _G.SendNotifications == true then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Text = "The boxes' visibility is now set to "..tostring(_G.BoxesVisible)..".";
                Duration = 5;
            })
        end
    end
end)

local Success, Errored = pcall(function()
    CreateBoxes()
end)

if Success and not Errored then
    if _G.SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Text = "Boxes script has successfully loaded.";
            Duration = 5;
        })
    end
elseif Errored and not Success then
    if _G.SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Text = "Boxes script has errored while loading, please check the developer console! (F9)";
            Duration = 5;
        })
    end
end

-- 2d boxes
local function API_Check()
    if Drawing == nil then
        return "No"
    else
        return "Yes"
    end
end

local Find_Required = API_Check()

if Find_Required == "No" then
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Text = "Boxes script could not be loaded because your exploit is unsupported.";
        Duration = math.huge;
        Button1 = "OK"
    })

    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Typing = false

_G.SendNotifications = false   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
_G.DefaultSettings = false   -- If set to true then the 2D boxes script would run with default settings regardless of any changes you made.

_G.TeamCheck = true   -- If set to true then the script would create 2D boxes only for the enemy team members.

_G.SquaresVisible = false   -- If set to true then the 2D boxes will be visible and vice versa.
_G.SquareColor = Color3.fromRGB(255, 80, 10)   -- The color that the 2D boxes would appear as.
_G.SquareThickness = 1   -- The thickness of the 2D boxes.
_G.SquareFilled = false   -- If set to true then the squares would be filled and vice versa.
_G.SquareTransparency = 0.7   -- The transparency of the 2D boxes / squares.

--// Don't touch, needed for the correct size of the square.

_G.HeadOffset = Vector3.new(0, 0.5, 0)
_G.LegsOffset = Vector3.new(0, 3, 0)

--_G.DisableKey = Enum.KeyCode.Q   -- The key that disables / enables the 2D boxes.

local function CreateSquares()
	for _, v in next, Players:GetPlayers() do
		if v ~= LocalPlayer then
			if v.Character ~= nil then
				if v.Character:WaitForChild("HumanoidRootPart", math.huge) ~= nil then
					if v.Character:WaitForChild("Humanoid", math.huge) ~= nil and v.Character:WaitForChild("Humanoid", math.huge).Health > 0 then
						local Square = Drawing.new("Square")
						Square.Thickness = _G.SquareThickness
						Square.Transparency = _G.SquareTransparency
						Square.Color = _G.SquareColor
						Square.Filled = _G.SquareFilled

						RunService.RenderStepped:Connect(function()
							if v.Character ~= nil and v.Character.HumanoidRootPart ~= nil then
								local Victim_HumanoidRootPart, OnScreen = Camera:WorldToViewportPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
								local Victim_Head = Camera:WorldToViewportPoint(v.Character:WaitForChild("Head", math.huge).Position + _G.HeadOffset)
								local Victim_Legs = Camera:WorldToViewportPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position - _G.LegsOffset)

								if OnScreen == true and _G.SquaresVisible == true then
									Square.Size = Vector2.new(2000 / Victim_HumanoidRootPart.Z, Victim_Head.Y - Victim_Legs.Y)
									Square.Position = Vector2.new(Victim_HumanoidRootPart.X - Square.Size.X / 2, Victim_HumanoidRootPart.Y - Square.Size.Y / 2)

									Square.Thickness = _G.SquareThickness
									Square.Transparency = _G.SquareTransparency
									Square.Color = _G.SquareColor
									Square.Filled = _G.SquareFilled

									if _G.TeamCheck == true then
										if v.Team ~= LocalPlayer.Team then
											Square.Visible = true
										else
											Square.Visible = false
										end
									else
										Square.Visible = true
									end
								else
									Square.Visible = false
								end
							else
								Square.Visible = false
							end
						end)

						Players.PlayerRemoving:Connect(function(Player)
							if Player == v then
								Square.Visible = false
							end
						end)
					end
 				end
			end
		end
	end

	Players.PlayerAdded:Connect(function(v)
		repeat wait() until v.Character

		if v ~= LocalPlayer then
			if v.Character ~= nil then
				if v.Character:WaitForChild("HumanoidRootPart", math.huge) ~= nil then
					if v.Character:WaitForChild("Humanoid", math.huge) ~= nil and v.Character:WaitForChild("Humanoid", math.huge).Health > 0 then
						local Square = Drawing.new("Square")
						Square.Thickness = _G.SquareThickness
						Square.Transparency = _G.SquareTransparency
						Square.Color = _G.SquareColor
						Square.Filled = _G.SquareFilled

						RunService.RenderStepped:Connect(function()
							if v.Character ~= nil and v.Character.HumanoidRootPart ~= nil then
								local Victim_HumanoidRootPart, OnScreen = Camera:WorldToViewportPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
								local Victim_Head = Camera:WorldToViewportPoint(v.Character:WaitForChild("Head", math.huge).Position + _G.HeadOffset)
								local Victim_Legs = Camera:WorldToViewportPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position - _G.LegsOffset)

								if OnScreen == true and _G.SquaresVisible == true then
									Square.Size = Vector2.new(2000 / Victim_HumanoidRootPart.Z, Victim_Head.Y - Victim_Legs.Y)
									Square.Position = Vector2.new(Victim_HumanoidRootPart.X - Square.Size.X / 2, Victim_HumanoidRootPart.Y - Square.Size.Y / 2)

									Square.Thickness = _G.SquareThickness
									Square.Transparency = _G.SquareTransparency
									Square.Color = _G.SquareColor
									Square.Filled = _G.SquareFilled

									if _G.TeamCheck == true then
										if v.Team ~= LocalPlayer.Team then
											Square.Visible = true
										else
											Square.Visible = false
										end
									else
										Square.Visible = true
									end
								else
									Square.Visible = false
								end
							else
								Square.Visible = false
							end
						end)

						Players.PlayerRemoving:Connect(function(Player)
							if Player == v then
								Square.Visible = false
							end
						end)
					end
				end
			end
		end
	end)
end

if _G.DefaultSettings == true then
    _G.TeamCheck = false
    _G.SquaresVisible = true
    _G.SquareColor = Color3.fromRGB(40, 90, 255)
    _G.SquareThickness = 2
	_G.SquareFilled = false
    _G.SquareTransparency = 0.5
    _G.DisableKey = Enum.KeyCode.Q
end

UserInputService.TextBoxFocused:Connect(function()
    Typing = true
end)

UserInputService.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == _G.DisableKey and Typing == false then
        _G.SquaresVisible = not _G.SquaresVisible
        
        if _G.SendNotifications == true then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Text = "The 2D boxes' visibility is now set to "..tostring(_G.SquaresVisible)..".";
                Duration = 5;
            })
        end
    end
end)

local Success, Errored = pcall(function()
    CreateSquares()
end)

if Success and not Errored then
    if _G.SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Text = "2D Boxes script has successfully loaded.";
            Duration = 5;
        })
    end
elseif Errored and not Success then
    if _G.SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Text = "2D Boxes script has errored while loading, please check the developer console! (F9)";
            Duration = 5;
        })
    end
end

-- head dots
local function API_Check()
    if Drawing == nil then
        return "No"
    else
        return "Yes"
    end
end

local Find_Required = API_Check()

if Find_Required == "No" then
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Text = "Heads script could not be loaded because your exploit is unsupported.";
        Duration = math.huge;
        Button1 = "OK"
    })

    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local Typing = false

_G.SendNotifications = false   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
_G.DefaultSettings = false   -- If set to true then the heads script would run with default settings regardless of any changes you made.

_G.TeamCheck = true   -- If set to true then the script would create head dots only for the enemy team members.

_G.HeadDotsVisible = false   -- If set to true then the head dots will be visible and vice versa.
_G.DotColor = Color3.fromRGB(255, 80, 10)   -- The color that the head dots would appear as.
_G.DotSize = 5   -- The size of the head dot.
_G.DotTransparency = 0.7   -- The transparency of the head dot.
_G.DotSides = 100   -- How many sides will the dot have.
_G.DotThickness = 1   -- How thick will the head dot be.
_G.Filled = true   -- If set to true then the circle would be filled and vice versa.

--_G.DisableKey = Enum.KeyCode.Q   -- The key that disables / enables the head dots.

local function CreateHeadDots()
    for _, v in next, Players:GetPlayers() do
        if v.Name ~= Players.LocalPlayer.Name then
            local HeadDot = Drawing.new("Circle")

            RunService.RenderStepped:Connect(function()
                if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("Head") ~= nil then
                    local Vector, OnScreen = Camera:WorldToViewportPoint(workspace:WaitForChild(v.Name, math.huge).Head.Position)

                    HeadDot.Color = _G.DotColor
                    HeadDot.Radius = _G.DotSize
                    HeadDot.Transparency = _G.DotTransparency
                    HeadDot.NumSides = _G.DotSides
                    HeadDot.Thickness = _G.DotThickness
                    HeadDot.Filled = _G.Filled

                    if OnScreen == true then
                        HeadDot.Position = Vector2.new(Vector.X, Vector.Y)
                        if _G.TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                HeadDot.Visible = _G.HeadDotsVisible
                            else
                                HeadDot.Visible = false
                            end
                        else
                            HeadDot.Visible = _G.HeadDotsVisible
                        end
                    else
                        HeadDot.Visible = false
                    end
                else
                    HeadDot.Visible = false
                end
            end)

            Players.PlayerRemoving:Connect(function()
                HeadDot.Visible = false
            end)
        end
    end

    Players.PlayerAdded:Connect(function(Player)
        Player.CharacterAdded:Connect(function(v)
            if v.Name ~= Players.LocalPlayer.Name then
                local HeadDot = Drawing.new("Circle")
    
                RunService.RenderStepped:Connect(function()
                    if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("Head") ~= nil then
                        local Vector, OnScreen = Camera:WorldToViewportPoint(workspace:WaitForChild(v.Name, math.huge).Head.Position)
    
                        HeadDot.Color = _G.DotColor
                        HeadDot.Radius = _G.DotSize
                        HeadDot.Transparency = _G.DotTransparency
                        HeadDot.NumSides = _G.DotSides
                        HeadDot.Thickness = _G.DotThickness
                        HeadDot.Filled = _G.Filled
    
                        if OnScreen == true then
                            HeadDot.Position = Vector2.new(Vector.X, Vector.Y)
                            if _G.TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Players:GetPlayerFromCharacter(v).Team then
                                    HeadDot.Visible = _G.HeadDotsVisible
                                else
                                    HeadDot.Visible = false
                                end
                            else
                                HeadDot.Visible = _G.HeadDotsVisible
                            end
                        else
                            HeadDot.Visible = false
                        end
                    else
                        HeadDot.Visible = false
                    end
                end)

                Players.PlayerRemoving:Connect(function()
                    HeadDot.Visible = false
                end)
            end
        end)
    end)
end

if _G.DefaultSettings == true then
    _G.TeamCheck = false
    _G.HeadDotsVisible = true
    _G.DotColor = Color3.fromRGB(40, 90, 255)
    _G.DotSize = 5
    _G.DotTransparency = 0.65
    _G.DotSides = 100
    _G.DotThickness = 1
    _G.Filled = true
    _G.DisableKey = Enum.KeyCode.Q
end

UserInputService.TextBoxFocused:Connect(function()
    Typing = true
end)

UserInputService.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == _G.DisableKey and Typing == false then
        _G.HeadDotsVisible = not _G.HeadDotsVisible
        
        if _G.SendNotifications == true then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Text = "The Heads's visibility is now set to "..tostring(_G.HeadDotsVisible)..".";
                Duration = 5;
            })
        end
    end
end)

local Success, Errored = pcall(function()
    CreateHeadDots()
end)

if Success and not Errored then
    if _G.SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Text = "Heads script has successfully loaded.";
            Duration = 5;
        })
    end
elseif Errored and not Success then
    if _G.SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Text = "Heads script has errored while loading, please check the developer console! (F9)";
            Duration = 5;
        })
    end
end

CreateHeadDots()

-- load
venyx:SelectPage(venyx.pages[1], true)
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()
local loaded = Notification.new("success", "DexHub ☕", "Loaded Arsenal!")
wait(2)
loaded:delete()