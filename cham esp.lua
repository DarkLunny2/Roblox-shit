       _G.FriendColor = Color3.fromRGB(0, 0, 255)
            _G.EnemyColor = Color3.fromRGB(255, 0, 0)
            _G.UseTeamColor = true
          
            if _G.Reantheajfdfjdgs then
                return
            end
            
            _G.Reantheajfdfjdgs = suifayhgvsdghfsfkajewfrhk321rk213kjrgkhj432rj34f67df
            
            local players = gameGetService(Players)
            local plr = players.LocalPlayer
            
            function esp(target, color)
                if target.Character then
                    if not target.CharacterFindFirstChild(GetReal) then
                        local highlight = Instance.new(Highlight)
                        highlight.RobloxLocked = true
                        highlight.Name = GetReal
                        highlight.Adornee = target.Character
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.FillColor = color
                        highlight.Parent = target.Character
                    else
                        target.Character.GetReal.FillColor = color
                    end
                end
            end
            
            while task.wait() do
                for i, v in pairs(playersGetPlayers()) do
                    if v ~= plr then
                        esp(v, _G.UseTeamColor and v.TeamColor.Color or ((plr.TeamColor == v.TeamColor) and _G.FriendColor or _G.EnemyColor))
                    end
                end
            end
            
         