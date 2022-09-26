InfiniteJumpEnabled = State
local Player = game:GetService("Players").LocalPlayer
        game:GetService("UserInputService").JumpRequest:Connect(function()
             if InfiniteJumpEnabled then
                 Player.Character:WaitForChild("Humanoid"):ChangeState("Jumping")
             end
        end)
          