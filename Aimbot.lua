-- Localizing
local game = game
local pairs = pairs
local workspace = workspace

--Namecalls
local GetService = game.GetService
local FindFirstChild = game.FindFirstChild


-- services
local players = GetService(game, "Players")
local RunService = GetService(game, "RunService")
local UserInputService = GetService(game, "UserInputService")


-- Variables
local client = players.LocalPlayer
local camera = workspace.CurrentCamera
local WorldToViewportPoint = camera.WorldToViewportPoint
local mouseLocation = UserInputService.GetMouseLocation

getgenv().smoothness = 4
getgenv().fov = 100
getgenv().team_check = true

local circle = Drawing.new("Circle")
circle.Thickness = 2
circle.NumSides = 12
circle.Radius = getgenv().fov
circle.Filled = false
circle.Transparency = 1
circle.Color = Color3.new(1, 0.5, 0)
circle.Visible = true





local rootPart = "HumanoidRootPart"
for _, v in pairs(players:GetPlayers()) do
  if v ~= client and v.Character then
    if v.Character:FindFirstChild("HumanoidRootPart") then
      rootPart = "HumanoidRootPart"
    elseif v.Character:FindFirstChild("Torso") then
      rootPart = "Torso"
    elseif v.Character:FindFirstChild("PrimaryPart") then
      rootPart = "PrimaryPart"
    end
  end
end



local function isTeam(plr : Player)
    if getgenv().team_check == false then
        return false
    end
    return plr.Team == client.Team
end


local function isAlive(plr : Player)
    if FindFirstChild(plr.Character, "Humanoid") then
        return plr.Character.Humanoid.Health > 0
    else
        return true
    end
end

local function get_closest_player(fov)
    local target
    local magnitude = fov or math.huge
    for _, plr in pairs(players:GetPlayers()) do
        if plr.Name ~= client.Name and plr.Character ~= nil and FindFirstChild(plr.Character, "Head") and isTeam(plr) == false and FindFirstChild(plr.Character, rootPart) and isAlive(plr) then
            local character = plr.Character
            local screen_pos, on_screen = WorldToViewportPoint(camera, character.Head.Position)
            local screen_pos = Vector2.new(screen_pos.X, screen_pos.Y)
            local new_magnitude = (screen_pos - mouseLocation(UserInputService)).Magnitude
            if new_magnitude < magnitude and on_screen then
                magnitude = new_magnitude
                target = plr
            end
        end
    end
    return target
end


local function aim_at(position, smoothness)
    local smoothness = smoothness or 1
    local pos, _ = WorldToViewportPoint(camera, position)
    local mouse_pos = mouseLocation(UserInputService)
    mousemoverel((pos.X - mouse_pos.X) / smoothness, (pos.Y - mouse_pos.Y) / smoothness)
end

game.StarterGui:SetCore("ChatMakeSystemMessage", {
    Text = "Available commands:\n!setfov [number] \n!setsm [number] \n!teamcheck [true/false]";
    Color = Color3.fromRGB(255,0,0);
    Font = Enum.Font.SourceSansBold;
    FontSize = Enum.FontSize.Size60;
})


local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if tostring(Self) == "SayMessageRequest" and method == "FireServer" then
        if string.find(args[1]:lower(), "!setfov") then
            local command = string.split(args[1], " ")
            getgenv().fov = tonumber(command[2])
            return
        elseif string.find(args[1]:lower(), "!setsm") then
            local command = string.split(args[1], " ")
            getgenv().smoothness = tonumber(command[2])
            return
        elseif string.find(args[1]:lower(), "!teamcheck") then
            local command = string.split(args[1], " ")
            if command[2] == "true" then
                getgenv().team_check = true
            else
                getgenv().team_check = false
            end
            return
        end
    end
    return OldNamecall(Self, ...)
end)


RunService.RenderStepped:Connect(function()
    if circle.__OBJECT_EXISTS then
        circle.Radius = getgenv().fov
        circle.Position = mouseLocation(UserInputService)
    end
    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = get_closest_player(getgenv().fov)
        if target then
            aim_at(target.Character.Head.Position, getgenv().smoothness)
        end
    end
end)