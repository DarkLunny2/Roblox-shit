local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("  ", "BloodTheme")

-- MAIN
local Main = Window:NewTab("Credits")
local MainSection = Main:NewSection("Credits")
MainSection:NewLabel("Developer ")
local Visual = Window:NewTab("Visuals")
local VisualSection = Visual:NewSection("Visuals")
VisualSection:NewButton("Box Esp", "Box Esp", function()
    print("Clicked")
    local Box_Color = Color3.fromRGB(255, 0, 0)
    local HealthBar_Color = Color3.fromRGB(255, 0, 0)
    
    local Tracer_Thickness = 1
    local Box_Thickness = 2
    
    local teamcheck = {
        teamcheck = true,
        green = Color3.fromRGB(8, 0, 255),
        red = Color3.fromRGB(255, 0, 0 )
    }
    
    --//Locals
    local plr = game.Players.LocalPlayer
    local camera = game.Workspace.CurrentCamera
    
    local function NewQuad(thickness, color)
        local quad = Drawing.new("Quad")
        quad.Visible = false
        quad.PointA = Vector2.new(0,0)
        quad.PointB = Vector2.new(0,0)
        quad.PointC = Vector2.new(0,0)
        quad.PointD = Vector2.new(0,0)
        quad.Color = color
        quad.Filled = false
        quad.Thickness = thickness
        quad.Transparency = 1
        return quad
    end
    
    local function NewLine(thickness, color)
        local line = Drawing.new("Line")
        line.Visible = false
        line.From = Vector2.new(0, 0)
        line.To = Vector2.new(0, 0)
        line.Color = color
        line.Thickness = thickness
        line.Transparency = 1
        return line
    end
    
    local black = Color3.fromRGB(0, 0, 0)
    
    for i, v in pairs(game.Players:GetChildren()) do
        local library = {
            --//Box and Black Box(black border)
            black = NewQuad(Box_Thickness*2, black),
            box = NewQuad(Box_Thickness, Box_Color),
            --//Bar and Green Health Bar (part that moves up/down)
            healthbar = NewLine(8, black),
            greenhealth = NewLine(4, HealthBar_Color)
        }
    
        local function Visibility(state)
            for u, x in pairs(library) do
                x.Visible = state
            end
        end
    
        local function ESP()
            local connection
            connection = game:GetService("RunService").RenderStepped:Connect(function()
                if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Name ~= plr.Name and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("Head") ~= nil then
                    local ScreenPos, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                    if OnScreen then
                        local head = camera:WorldToViewportPoint(v.Character.Head.Position)
                        local rootpos = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
    
                        local ratio = math.clamp((Vector2.new(head.X, head.Y) - Vector2.new(rootpos.X, rootpos.Y)).magnitude, 2, math.huge)
    
                        local head2 = camera:WorldToViewportPoint(Vector3.new(v.Character.Head.Position.X, v.Character.Head.Position.Y + 2, v.Character.Head.Position.Z))
    
                        local root2 = camera:WorldToViewportPoint(Vector3.new(v.Character.Head.Position.X, v.Character.HumanoidRootPart.Position.Y - 3, v.Character.Head.Position.Z))
    
                        library.black.PointA = Vector2.new(head2.X + ratio*1.6, head2.Y - ratio*0.05)
                        library.black.PointB = Vector2.new(head2.X - ratio*1.6, head2.Y - ratio*0.05)
                        library.black.PointC = Vector2.new(head2.X - ratio*1.6, root2.Y + ratio*0.5)
                        library.black.PointD = Vector2.new(head2.X + ratio*1.6, root2.Y + ratio*0.5)
    
                        library.box.PointA = Vector2.new(head2.X + ratio*1.6, head2.Y - ratio*0.05)
                        library.box.PointB = Vector2.new(head2.X - ratio*1.6, head2.Y - ratio*0.05)
                        library.box.PointC = Vector2.new(head2.X - ratio*1.6, root2.Y + ratio*0.5)
                        library.box.PointD = Vector2.new(head2.X + ratio*1.6, root2.Y + ratio*0.5)
    
                        local d = (Vector2.new(head2.X - ratio*1.8, head2.Y - ratio*0.05) - Vector2.new(root2.X - ratio*1.8, root2.Y + ratio*0.5)).magnitude
                        local green = (100-v.Character.Humanoid.Health) *d /100
    
                        library.greenhealth.Thickness = math.clamp(ratio/4, 1, 4)
                        library.healthbar.Thickness = math.clamp(ratio * 1.2 / 4, 1.5, 6)
    
                        library.healthbar.To = Vector2.new(head2.X - ratio*1.8, head2.Y - ratio*0.05)
                        library.healthbar.From = Vector2.new(head2.X - ratio*1.8, root2.Y + ratio*0.5)
    
                        library.greenhealth.To = Vector2.new(head2.X - ratio*1.8, head2.Y + green - ratio*0.05)
                        library.greenhealth.From = Vector2.new(head2.X - ratio*1.8, root2.Y + ratio*0.5)
    
                        if teamcheck.teamcheck == true then
                            if v.TeamColor == plr.TeamColor then
                                library.box.Color = teamcheck.green
                        
                            else 
                                library.box.Color = teamcheck.red
                             
                            end
                        end
    
                        Visibility(true)
                    else 
                        Visibility(false)
                    end
                else 
                    Visibility(false)
                    if game.Players:FindFirstChild(v.Name) == nil then
                        connection:Disconnect()
                    end
                end
            end)
        end
        coroutine.wrap(ESP)()
    end
    
    game.Players.PlayerAdded:Connect(function(newplr) 
        local library = {
            black = NewQuad(Box_Thickness*2, black),
            box = NewQuad(Box_Thickness, Box_Color),
            healthbar = NewLine(8, black),
            greenhealth = NewLine(4, HealthBar_Color)
        }
    
        local function Visibility(state)
            for u, x in pairs(library) do
                x.Visible = state
            end
        end
    
        local function ESP()
            local connection
            connection = game:GetService("RunService").RenderStepped:Connect(function()
                if newplr.Character ~= nil and newplr.Character:FindFirstChild("Humanoid") ~= nil and newplr.Character:FindFirstChild("HumanoidRootPart") ~= nil and newplr.Name ~= plr.Name and newplr.Character.Humanoid.Health > 0 and newplr.Character:FindFirstChild("Head") ~= nil then
                    local ScreenPos, OnScreen = camera:WorldToViewportPoint(newplr.Character.HumanoidRootPart.Position)
                    if OnScreen then
                        local head = camera:WorldToViewportPoint(newplr.Character.Head.Position)
                        local rootpos = camera:WorldToViewportPoint(newplr.Character.HumanoidRootPart.Position)
    
                        local ratio = math.clamp((Vector2.new(head.X, head.Y) - Vector2.new(rootpos.X, rootpos.Y)).magnitude, 2, math.huge)
    
                        local head2 = camera:WorldToViewportPoint(Vector3.new(newplr.Character.Head.Position.X, newplr.Character.Head.Position.Y + 2, newplr.Character.Head.Position.Z))
    
                        local root2 = camera:WorldToViewportPoint(Vector3.new(newplr.Character.Head.Position.X, newplr.Character.HumanoidRootPart.Position.Y - 3, newplr.Character.Head.Position.Z))
    
                        library.black.PointA = Vector2.new(head2.X + ratio*1.6, head2.Y - ratio*0.05)
                        library.black.PointB = Vector2.new(head2.X - ratio*1.6, head2.Y - ratio*0.05)
                        library.black.PointC = Vector2.new(head2.X - ratio*1.6, root2.Y + ratio*0.5)
                        library.black.PointD = Vector2.new(head2.X + ratio*1.6, root2.Y + ratio*0.5)
    
                        library.box.PointA = Vector2.new(head2.X + ratio*1.6, head2.Y - ratio*0.05)
                        library.box.PointB = Vector2.new(head2.X - ratio*1.6, head2.Y - ratio*0.05)
                        library.box.PointC = Vector2.new(head2.X - ratio*1.6, root2.Y + ratio*0.5)
                        library.box.PointD = Vector2.new(head2.X + ratio*1.6, root2.Y + ratio*0.5)
    
                        
    
                     
    
                        local d = (Vector2.new(head2.X - ratio*1.8, head2.Y - ratio*0.05) - Vector2.new(root2.X - ratio*1.8, root2.Y + ratio*0.5)).magnitude
                        local green = (100-newplr.Character.Humanoid.Health) *d /100
    
                        library.greenhealth.Thickness = math.clamp(ratio/4, 1, 4)
                        library.healthbar.Thickness = math.clamp(ratio * 1.2 / 4, 1.5, 6)
    
                        library.healthbar.To = Vector2.new(head2.X - ratio*1.8, head2.Y - ratio*0.05)
                        library.healthbar.From = Vector2.new(head2.X - ratio*1.8, root2.Y + ratio*0.5)
    
                        library.greenhealth.To = Vector2.new(head2.X - ratio*1.8, head2.Y + green - ratio*0.05)
                        library.greenhealth.From = Vector2.new(head2.X - ratio*1.8, root2.Y + ratio*0.5)
    
                        if teamcheck.teamcheck == true then
                            if newplr.TeamColor == plr.TeamColor then
                                library.box.Color = teamcheck.green
                               
                            else 
                                library.box.Color = teamcheck.red
                               
                            end
                        end
    
                        Visibility(true)
                    else 
                        Visibility(false)
                    end
                else 
                    Visibility(false)
                    if game.Players:FindFirstChild(newplr.Name) == nil then
                        connection:Disconnect()
                    end
                end
            end)
        end
        coroutine.wrap(ESP)()
    end)
        
        
        
        end)


VisualSection:NewButton("Skeleron Esp", "Skeleron Esp", function()
    print("Clicked")
   
    local Player = game:GetService("Players").LocalPlayer
    local Mouse = Player:GetMouse()
    local Camera = game:GetService("Workspace").CurrentCamera
    
    local function DrawLine()
        local l = Drawing.new("Line")
        l.Visible = false
        l.From = Vector2.new(0, 0)
        l.To = Vector2.new(1, 1)
        l.Color = Color3.fromRGB(8, 0, 255)
        l.Thickness = 1
        l.Transparency = 1
        return l
    end
    
    local function DrawESP(plr)
        repeat wait() until plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil
        local limbs = {}
        local R15 = (plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R15) and true or false
        if R15 then 
            limbs = {
                -- Spine
                Head_UpperTorso = DrawLine(),
                UpperTorso_LowerTorso = DrawLine(),
                -- Left Arm
                UpperTorso_LeftUpperArm = DrawLine(),
                LeftUpperArm_LeftLowerArm = DrawLine(),
                LeftLowerArm_LeftHand = DrawLine(),
                -- Right Arm
                UpperTorso_RightUpperArm = DrawLine(),
                RightUpperArm_RightLowerArm = DrawLine(),
                RightLowerArm_RightHand = DrawLine(),
                -- Left Leg
                LowerTorso_LeftUpperLeg = DrawLine(),
                LeftUpperLeg_LeftLowerLeg = DrawLine(),
                LeftLowerLeg_LeftFoot = DrawLine(),
                -- Right Leg
                LowerTorso_RightUpperLeg = DrawLine(),
                RightUpperLeg_RightLowerLeg = DrawLine(),
                RightLowerLeg_RightFoot = DrawLine(),
            }
        else 
            limbs = {
                Head_Spine = DrawLine(),
                Spine = DrawLine(),
                LeftArm = DrawLine(),
                LeftArm_UpperTorso = DrawLine(),
                RightArm = DrawLine(),
                RightArm_UpperTorso = DrawLine(),
                LeftLeg = DrawLine(),
                LeftLeg_LowerTorso = DrawLine(),
                RightLeg = DrawLine(),
                RightLeg_LowerTorso = DrawLine()
            }
        end
        local function Visibility(state)
            for i, v in pairs(limbs) do
                v.Visible = state
            end
        end
    
        local function Colorize(color)
            for i, v in pairs(limbs) do
                v.Color = color
            end
        end
    
        local function UpdaterR15()
            local connection
            connection = game:GetService("RunService").RenderStepped:Connect(function()
                if plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character.Humanoid.Health > 0 then
                    local HUM, vis = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                    if vis then
                        -- Head
                        local H = Camera:WorldToViewportPoint(plr.Character.Head.Position)
                        if limbs.Head_UpperTorso.From ~= Vector2.new(H.X, H.Y) then
                            --Spine
                            local UT = Camera:WorldToViewportPoint(plr.Character.UpperTorso.Position)
                            local LT = Camera:WorldToViewportPoint(plr.Character.LowerTorso.Position)
                            -- Left Arm
                            local LUA = Camera:WorldToViewportPoint(plr.Character.LeftUpperArm.Position)
                            local LLA = Camera:WorldToViewportPoint(plr.Character.LeftLowerArm.Position)
                            local LH = Camera:WorldToViewportPoint(plr.Character.LeftHand.Position)
                            -- Right Arm
                            local RUA = Camera:WorldToViewportPoint(plr.Character.RightUpperArm.Position)
                            local RLA = Camera:WorldToViewportPoint(plr.Character.RightLowerArm.Position)
                            local RH = Camera:WorldToViewportPoint(plr.Character.RightHand.Position)
                            -- Left leg
                            local LUL = Camera:WorldToViewportPoint(plr.Character.LeftUpperLeg.Position)
                            local LLL = Camera:WorldToViewportPoint(plr.Character.LeftLowerLeg.Position)
                            local LF = Camera:WorldToViewportPoint(plr.Character.LeftFoot.Position)
                            -- Right leg
                            local RUL = Camera:WorldToViewportPoint(plr.Character.RightUpperLeg.Position)
                            local RLL = Camera:WorldToViewportPoint(plr.Character.RightLowerLeg.Position)
                            local RF = Camera:WorldToViewportPoint(plr.Character.RightFoot.Position)
    
                            --Head
                            limbs.Head_UpperTorso.From = Vector2.new(H.X, H.Y)
                            limbs.Head_UpperTorso.To = Vector2.new(UT.X, UT.Y)
    
                            --Spine
                            limbs.UpperTorso_LowerTorso.From = Vector2.new(UT.X, UT.Y)
                            limbs.UpperTorso_LowerTorso.To = Vector2.new(LT.X, LT.Y)
    
                            -- Left Arm
                            limbs.UpperTorso_LeftUpperArm.From = Vector2.new(UT.X, UT.Y)
                            limbs.UpperTorso_LeftUpperArm.To = Vector2.new(LUA.X, LUA.Y)
    
                            limbs.LeftUpperArm_LeftLowerArm.From = Vector2.new(LUA.X, LUA.Y)
                            limbs.LeftUpperArm_LeftLowerArm.To = Vector2.new(LLA.X, LLA.Y)
    
                            limbs.LeftLowerArm_LeftHand.From = Vector2.new(LLA.X, LLA.Y)
                            limbs.LeftLowerArm_LeftHand.To = Vector2.new(LH.X, LH.Y)
    
                            -- Right Arm
                            limbs.UpperTorso_RightUpperArm.From = Vector2.new(UT.X, UT.Y)
                            limbs.UpperTorso_RightUpperArm.To = Vector2.new(RUA.X, RUA.Y)
    
                            limbs.RightUpperArm_RightLowerArm.From = Vector2.new(RUA.X, RUA.Y)
                            limbs.RightUpperArm_RightLowerArm.To = Vector2.new(RLA.X, RLA.Y)
    
                            limbs.RightLowerArm_RightHand.From = Vector2.new(RLA.X, RLA.Y)
                            limbs.RightLowerArm_RightHand.To = Vector2.new(RH.X, RH.Y)
    
                            -- Left Leg
                            limbs.LowerTorso_LeftUpperLeg.From = Vector2.new(LT.X, LT.Y)
                            limbs.LowerTorso_LeftUpperLeg.To = Vector2.new(LUL.X, LUL.Y)
    
                            limbs.LeftUpperLeg_LeftLowerLeg.From = Vector2.new(LUL.X, LUL.Y)
                            limbs.LeftUpperLeg_LeftLowerLeg.To = Vector2.new(LLL.X, LLL.Y)
    
                            limbs.LeftLowerLeg_LeftFoot.From = Vector2.new(LLL.X, LLL.Y)
                            limbs.LeftLowerLeg_LeftFoot.To = Vector2.new(LF.X, LF.Y)
    
                            -- Right Leg
                            limbs.LowerTorso_RightUpperLeg.From = Vector2.new(LT.X, LT.Y)
                            limbs.LowerTorso_RightUpperLeg.To = Vector2.new(RUL.X, RUL.Y)
    
                            limbs.RightUpperLeg_RightLowerLeg.From = Vector2.new(RUL.X, RUL.Y)
                            limbs.RightUpperLeg_RightLowerLeg.To = Vector2.new(RLL.X, RLL.Y)
    
                            limbs.RightLowerLeg_RightFoot.From = Vector2.new(RLL.X, RLL.Y)
                            limbs.RightLowerLeg_RightFoot.To = Vector2.new(RF.X, RF.Y)
                        end
    
                        if limbs.Head_UpperTorso.Visible ~= true then
                            Visibility(true)
                        end
                    else 
                        if limbs.Head_UpperTorso.Visible ~= false then
                            Visibility(false)
                        end
                    end
                else 
                    if limbs.Head_UpperTorso.Visible ~= false then
                        Visibility(false)
                    end
                    if game.Players:FindFirstChild(plr.Name) == nil then 
                        for i, v in pairs(limbs) do
                            v:Remove()
                        end
                        connection:Disconnect()
                    end
                end
            end)
        end
    
        local function UpdaterR6()
            local connection
            connection = game:GetService("RunService").RenderStepped:Connect(function()
                if plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character.Humanoid.Health > 0 then
                    local HUM, vis = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                    if vis then
                        local H = Camera:WorldToViewportPoint(plr.Character.Head.Position)
                        if limbs.Head_Spine.From ~= Vector2.new(H.X, H.Y) then
                            local T_Height = plr.Character.Torso.Size.Y/2 - 0.2
                            local UT = Camera:WorldToViewportPoint((plr.Character.Torso.CFrame * CFrame.new(0, T_Height, 0)).p)
                            local LT = Camera:WorldToViewportPoint((plr.Character.Torso.CFrame * CFrame.new(0, -T_Height, 0)).p)
    
                            local LA_Height = plr.Character["Left Arm"].Size.Y/2 - 0.2
                            local LUA = Camera:WorldToViewportPoint((plr.Character["Left Arm"].CFrame * CFrame.new(0, LA_Height, 0)).p)
                            local LLA = Camera:WorldToViewportPoint((plr.Character["Left Arm"].CFrame * CFrame.new(0, -LA_Height, 0)).p)
    
                            local RA_Height = plr.Character["Right Arm"].Size.Y/2 - 0.2
                            local RUA = Camera:WorldToViewportPoint((plr.Character["Right Arm"].CFrame * CFrame.new(0, RA_Height, 0)).p)
                            local RLA = Camera:WorldToViewportPoint((plr.Character["Right Arm"].CFrame * CFrame.new(0, -RA_Height, 0)).p)
    
                            local LL_Height = plr.Character["Left Leg"].Size.Y/2 - 0.2
                            local LUL = Camera:WorldToViewportPoint((plr.Character["Left Leg"].CFrame * CFrame.new(0, LL_Height, 0)).p)
                            local LLL = Camera:WorldToViewportPoint((plr.Character["Left Leg"].CFrame * CFrame.new(0, -LL_Height, 0)).p)
    
                            local RL_Height = plr.Character["Right Leg"].Size.Y/2 - 0.2
                            local RUL = Camera:WorldToViewportPoint((plr.Character["Right Leg"].CFrame * CFrame.new(0, RL_Height, 0)).p)
                            local RLL = Camera:WorldToViewportPoint((plr.Character["Right Leg"].CFrame * CFrame.new(0, -RL_Height, 0)).p)
    
                            -- Head
                            limbs.Head_Spine.From = Vector2.new(H.X, H.Y)
                            limbs.Head_Spine.To = Vector2.new(UT.X, UT.Y)
    
                            --Spine
                            limbs.Spine.From = Vector2.new(UT.X, UT.Y)
                            limbs.Spine.To = Vector2.new(LT.X, LT.Y)
    
                            --Left Arm
                            limbs.LeftArm.From = Vector2.new(LUA.X, LUA.Y)
                            limbs.LeftArm.To = Vector2.new(LLA.X, LLA.Y)
    
                            limbs.LeftArm_UpperTorso.From = Vector2.new(UT.X, UT.Y)
                            limbs.LeftArm_UpperTorso.To = Vector2.new(LUA.X, LUA.Y)
    
                            --Right Arm
                            limbs.RightArm.From = Vector2.new(RUA.X, RUA.Y)
                            limbs.RightArm.To = Vector2.new(RLA.X, RLA.Y)
    
                            limbs.RightArm_UpperTorso.From = Vector2.new(UT.X, UT.Y)
                            limbs.RightArm_UpperTorso.To = Vector2.new(RUA.X, RUA.Y)
    
                            --Left Leg
                            limbs.LeftLeg.From = Vector2.new(LUL.X, LUL.Y)
                            limbs.LeftLeg.To = Vector2.new(LLL.X, LLL.Y)
    
                            limbs.LeftLeg_LowerTorso.From = Vector2.new(LT.X, LT.Y)
                            limbs.LeftLeg_LowerTorso.To = Vector2.new(LUL.X, LUL.Y)
    
                            --Right Leg
                            limbs.RightLeg.From = Vector2.new(RUL.X, RUL.Y)
                            limbs.RightLeg.To = Vector2.new(RLL.X, RLL.Y)
    
                            limbs.RightLeg_LowerTorso.From = Vector2.new(LT.X, LT.Y)
                            limbs.RightLeg_LowerTorso.To = Vector2.new(RUL.X, RUL.Y)
                        end
    
                        if limbs.Head_Spine.Visible ~= true then
                            Visibility(true)
                        end
                    else 
                        if limbs.Head_Spine.Visible ~= false then
                            Visibility(false)
                        end
                    end
                else 
                    if limbs.Head_Spine.Visible ~= false then
                        Visibility(false)
                    end
                    if game.Players:FindFirstChild(plr.Name) == nil then 
                        for i, v in pairs(limbs) do
                            v:Remove()
                        end
                        connection:Disconnect()
                    end
                end
            end)
        end
    
        if R15 then
            coroutine.wrap(UpdaterR15)()
        else 
            coroutine.wrap(UpdaterR6)()
        end
    end
    
    for i, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v.Name ~= Player.Name then
            DrawESP(v)
        end
    end
    
    game.Players.PlayerAdded:Connect(function(newplr)
        if newplr.Name ~= Player.Name then
            DrawESP(newplr)
        end
    end)
    
       
       
       
       
        end)
      
       
        local Misc = Window:NewTab("Misc")
        local Misc = Misc:NewSection("Misc")
        Misc:NewButton("Auto Farm", "Auto Farm", function()
            print("Clicked")
        
getgenv().TreasureAutoFarm = {
    Enabled = true, 
    Teleport = 2, 
    TimeBetweenRuns = 5 
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")


local LocalPlayer = Players.LocalPlayer


local autoFarm = function(currentRun)

    local Character = LocalPlayer.Character
    local NormalStages = Workspace.BoatStages.NormalStages

    for i = 1, 10 do
        local Stage = NormalStages["CaveStage" .. i]
        local DarknessPart = Stage:FindFirstChild("DarknessPart")

        if (DarknessPart) then

            print("Teleporting to next stage: Stage " .. i)
            Character.HumanoidRootPart.CFrame = DarknessPart.CFrame

            local Part = Instance.new("Part", LocalPlayer.Character)
            Part.Anchored = true
            Part.Position = LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 6, 0)

            wait(getgenv().TreasureAutoFarm.Teleport)
            Part:Destroy()
        end
    end


    print("Teleporting to the end")
    repeat wait()
        Character.HumanoidRootPart.CFrame = NormalStages.TheEnd.GoldenChest.Trigger.CFrame
    until Lighting.ClockTime ~= 14


    local Respawned = false
    local Connection
    Connection = LocalPlayer.CharacterAdded:Connect(function()
        Respawned = true
        Connection:Disconnect()
    end)

    repeat wait() until Respawned
    wait(getgenv().TreasureAutoFarm.TimeBetweenRuns)
    print("Auto Farm: Run " .. currentRun .. " finished")
end


local autoFarmRun = 1
while wait() do
    if (getgenv().TreasureAutoFarm.Enabled) then
        print("Initialising Auto Farm: Run " .. autoFarmRun)
        autoFarm(autoFarmRun)
        autoFarmRun = autoFarmRun + 1
    end
end

        end)


        Misc:NewButton("Anti Afk", "Anti Afk", function()
    print("Clicked")
    local unafk = game:GetService("ReplicatedStorage"):WaitForChild("UnAFK")
    unafk.OnClientEvent:Connect(function()
         wait(2)
         unafk:FireServer()
     end)
     game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("gaming"):Destroy()
    end)


















































































































































local KeyBinds = Window:NewTab("KeyBinds")
local KeyBinds = KeyBinds:NewSection("KeyBinds")
KeyBinds:NewKeybind("Toggle UI", "", Enum.KeyCode.Insert, function()
    Library:ToggleUI()
end)
