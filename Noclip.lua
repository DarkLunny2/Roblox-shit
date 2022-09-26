
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