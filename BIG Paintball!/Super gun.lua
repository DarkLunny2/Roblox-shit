for i,v in pairs(game:GetService("ReplicatedStorage").Framework.Modules["1 | Directory"].Guns:GetChildren()) do
pcall(function()
require(v)[tostring(i)].firerate = -math.huge
require(v)[tostring(i)].velocity = 9999999
require(v)[tostring(i)].additionalSpeed = 10
require(v)[tostring(i)].automatic = false
end)
end