local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Sense = loadstring(game:HttpGet('https://raw.githubusercontent.com/MoonDeveloping/MoonScripts/refs/heads/main/esp.lua'))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Teams = game:GetService("Teams")

local Window = Rayfield:CreateWindow({
    Name = "Moon Hub",
    Icon = "moon",
    LoadingTitle = "Moon Hub", 
    LoadingSubtitle = "by MrCaniwes, ` Hamzz",
    Theme = "Default", 

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, 

    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil,
       FileName = "Moon Hub"
    },

    Discord = {
       Enabled = true, 
       Invite = "nerontechgames",
       RememberJoins = true
    },

    KeySystem = false,
    KeySettings = {
       Title = "Moon Hub",
       Subtitle = "Key System", 
       Note = "No method of obtaining the key is provided", 
       FileName = "Key", 
       SaveKey = true, 
       GrabKeyFromSite = false,
       Key = {"Hello"}
    }
})

Rayfield:Notify({
            Title = "🌙 Moon Hub Loaded",
            Content = "Developed By MrCaniwes, `Hamzz",
            Duration = 5,
            Image = "circle-check"
        })

local MainTab = Window:CreateTab("Home 🏠")
local EspTab = Window:CreateTab("ESP 👁️")
local AimbotTab = Window:CreateTab("Aimbot 🎯")
local ScriptsTab = Window:CreateTab("Scripts 📜")
local SettingsTab = Window:CreateTab("Settings ⚙️")

local MainSection = EspTab:CreateSection("Main")
local MainSection2 = MainTab:CreateSection("Main")
local MainSection3 = AimbotTab:CreateSection("Main")
local MainSection4 = SettingsTab:CreateSection("Main")
local MainSection5 = ScriptsTab:CreateSection("Main")

local InfiniteJumpEnabled = false
local NoclipEnabled = false
local FlyEnabled = false
local ESPEnabled = false
local FlySpeed = 10
local BoxESPEnabled = false
local BoxESPColor = Color3.fromRGB(0, 64, 191)
local ChamsEnabled = false
local ChamsFillColor = Color3.fromRGB(0,64,191)
local ChamsOutlineColor = Color3.fromRGB(0,64,191)
local ChamsVisibleOnly = false
local HealtBarEnabled = false
local AimbotEnabled = false
local TeamCheckEnabled = false
local AimbotSmoothness = 1
local QTeleportEnabled = false
local CtrlTeleportEnabled = false
local ForceFieldEnabled = false

local InfToggle = MainTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
      InfiniteJumpEnabled = Value
      Rayfield:Notify({
         Title = "Infinite Jump",
         Content = Value and "Enabled" or "Disabled",
         Duration = 1.5,
         Image = Value and "circle-check" or "circle-x"
      })
   end,
})


local NoclipToggle = MainTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(Value)
        NoclipEnabled = Value
        Rayfield:Notify({
            Title = "Noclip",
            Content = Value and "Enabled" or "Disabled",
            Duration = 1.5,
            Image = Value and "circle-check" or "circle-x"
        })
    end,
})

local function startFlying()
    local player = Players.LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local flyForce = Instance.new("BodyVelocity")
    flyForce.Velocity = Vector3.new(0, 0, 0)
    flyForce.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    flyForce.Parent = hrp
    
    local flyGyro = Instance.new("BodyGyro")
    flyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    flyGyro.P = 3000
    flyGyro.Parent = hrp
    
    local flyConnection
    flyConnection = RunService.RenderStepped:Connect(function()
        if FlyEnabled then
            local camera = workspace.CurrentCamera
            local direction = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                direction = direction - camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                direction = direction - camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + camera.CFrame.RightVector
            end
            flyForce.Velocity = direction * FlySpeed
            flyGyro.CFrame = camera.CFrame
        else
            flyForce:Destroy()
            flyGyro:Destroy()
            if flyConnection then
                flyConnection:Disconnect()
            end
        end
    end)
end



local FlyToggle = MainTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(Value)
        FlyEnabled = Value
        if FlyEnabled then
            startFlying()
        end
        Rayfield:Notify({
            Title = "Fly",
            Content = Value and "Enabled" or "Disabled",
            Duration = 1.5,
            Image = Value and "circle-check" or "circle-x"
        })
    end,
})


local Slider = MainTab:CreateSlider({
    Name = "Fly Speed",
    Range = {0, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 30,
    Flag = "FlySpeed",
    Callback = function(Value)
        FlySpeed = Value
    end,
})


local QTeleportToggle, CtrlTeleportToggle

QTeleportToggle = MainTab:CreateToggle({
    Name = "Q to Teleport",
    CurrentValue = false,
    Flag = "QTeleport", 
    Callback = function(Value)
        QTeleportEnabled = Value
        Rayfield:Notify({
            Title = "Q Teleport",
            Content = Value and "Enabled" or "Disabled",
            Duration = 1.5,
            Image = Value and "circle-check" or "circle-x"
        })
    end,
})

CtrlTeleportToggle = MainTab:CreateToggle({
    Name = "CTRL to Teleport",
    CurrentValue = false,
    Flag = "CtrlTeleport", 
    Callback = function(Value)
        CtrlTeleportEnabled = Value
        Rayfield:Notify({
            Title = "CTRL Teleport",
            Content = Value and "Enabled" or "Disabled",
            Duration = 1.5,
            Image = Value and "circle-check" or "circle-x"
        })
    end,
})

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if CtrlTeleportEnabled and input.KeyCode == Enum.KeyCode.LeftControl then
            local hum = plr.Character:FindFirstChild("HumanoidRootPart")
            if hum and mouse.Target then
                hum.CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z)
            end
        elseif QTeleportEnabled and input.KeyCode == Enum.KeyCode.Q then
            local hum = plr.Character:FindFirstChild("HumanoidRootPart")
            if hum and mouse.Target then
                hum.CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z)
            end
        end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
   if InfiniteJumpEnabled then
      game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
   end
end)

RunService.Stepped:Connect(function()
    local player = Players.LocalPlayer
    if player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not NoclipEnabled
            end
        end
    end
end)



local Slider = MainTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {0, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})


local Slider = MainTab:CreateSlider({
    Name = "JumpHeight",
    Range = {0, 200},
    Increment = 1,
    Suffix = "JumpHeight",
    CurrentValue = 16,
    Flag = "JumpHeight",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpHeight = Value
    end,
})

local ESPToggle = EspTab:CreateToggle({
    Name = "ESP Master Toggle",
    CurrentValue = false,
    Flag = "ESP",
    Callback = function(Value)
        ESPEnabled = Value
        if ESPEnabled then
            ESPEnabled = true   
            Sense.Load()
        else
            ESPEnabled = false
            Sense.Unload()
        end
        Rayfield:Notify({
            Title = "ESP",
            Content = Value and "Enabled" or "Disabled",
            Duration = 1.5,
            Image = Value and "circle-check" or "circle-x"
        })
    end,
})

local BoxESPToggle = EspTab:CreateToggle({
    Name = "Box ESP Toggle",
    CurrentValue = false,
    Flag = "boxesp",
    Callback = function(Value)
        BoxESPEnabled = Value
        if ESPEnabled and BoxESPEnabled then
            Sense.teamSettings.enemy.enabled = true
            Sense.teamSettings.enemy.box = true
            Sense.teamSettings.enemy.boxOutline = false
            Sense.teamSettings.enemy.boxColor[1] = BoxESPColor
            Sense.teamSettings.friendly.enabled = true
            Sense.teamSettings.friendly.box = true
            Sense.teamSettings.friendly.boxOutline = false
            Sense.teamSettings.friendly.boxColor[1] = BoxESPColor
        else
            Sense.teamSettings.enemy.box = false
            Sense.teamSettings.friendly.box = false
        end
        Rayfield:Notify({
            Title = "Box ESP",
            Content = Value and "Enabled" or "Disabled",
            Duration = 1.5,
            Image = Value and "circle-check" or "circle-x"
        })
    end,
})

local ColorPicker = EspTab:CreateColorPicker({
    Name = "Box ESP Color",
    Color = Color3.fromRGB(0, 64, 191), -- Default color (0, 0.25, 0.75)
    Flag = "BoxESPColor",
    Callback = function(Value)
        if ESPEnabled and BoxESPEnabled then
            Sense.teamSettings.enemy.boxColor[1] = Value
            Sense.teamSettings.friendly.boxColor[1] = Value
            BoxESPColor = Value
        end
    end
})

local HealtBarToggle = EspTab:CreateToggle({
    Name = "Health Bar Toggle",
    CurrentValue = false,
    Flag = "healtbar",
    Callback = function(Value)
        HealtBarEnabled = Value
        if ESPEnabled and HealtBarEnabled then
            Sense.teamSettings.enemy.healthBar = true
            Sense.teamSettings.friendly.healthBar = true
        else
            Sense.teamSettings.enemy.healthBar = false  
            Sense.teamSettings.friendly.healthBar = false
        end
        Rayfield:Notify({
            Title = "Health Bar",
            Content = Value and "Enabled" or "Disabled",
            Duration = 1.5,
            Image = Value and "circle-check" or "circle-x"
        })
    end,
})

local ChamsToggle = EspTab:CreateToggle({
    Name = "Chams Toggle",
    CurrentValue = false,
    Flag = "chams",
    Callback = function(Value)
        ChamsEnabled = Value
        if ESPEnabled and ChamsEnabled then
            Sense.teamSettings.enemy.enabled = true           
            Sense.teamSettings.enemy.chams = true
            Sense.teamSettings.enemy.chamsFillColor[1] = ChamsFillColor
            Sense.teamSettings.enemy.chamsOutlineColor[1] = ChamsOutlineColor
            Sense.teamSettings.friendly.enabled = true
            Sense.teamSettings.friendly.chams = true
            Sense.teamSettings.friendly.chamsFillColor[1] = ChamsFillColor
            Sense.teamSettings.friendly.chamsOutlineColor[1] = ChamsOutlineColor
        else
            Sense.teamSettings.enemy.chams = false
            Sense.teamSettings.friendly.chams = false
        end
        Rayfield:Notify({
            Title = "Chams",
            Content = Value and "Enabled" or "Disabled",
            Duration = 1.5,
            Image = Value and "circle-check" or "circle-x"
        })
    end,
})

local ColorPicker = EspTab:CreateColorPicker({
    Name = "Chams Fill Color",
    Color = Color3.fromRGB(0, 64, 191), -- Default color (0, 0.25, 0.75)
    Flag = "ChamsFillColor",
    Callback = function(Value)
        if ESPEnabled and ChamsEnabled then
            Sense.teamSettings.enemy.chamsFillColor[1] = Value
            Sense.teamSettings.friendly.chamsFillColor[1] = Value
            ChamsFillColor = Value
        end
    end
})


local ColorPicker = EspTab:CreateColorPicker({
    Name = "Chams Outline Color",
    Color = Color3.fromRGB(0, 64, 191), -- Default color (0, 0.25, 0.75)
    Flag = "ChamsOutlineColor",
    Callback = function(Value)
        if ESPEnabled and ChamsEnabled then
            Sense.teamSettings.enemy.chamsOutlineColor[1] = Value
            Sense.teamSettings.friendly.chamsOutlineColor[1] = Value
            ChamsOutlineColor = Value
        end
    end
})

local ChamsVisibleToggle = EspTab:CreateToggle({
    Name = "Chams Visible Only Toggle",
    CurrentValue = false,
    Flag = "chamsvisibleonly",
    Callback = function(Value)
        ChamsVisibleOnly = Value
        if ESPEnabled and ChamsEnabled then
            Sense.teamSettings.enemy.chamsVisibleOnly = ChamsVisibleOnly
            Sense.teamSettings.friendly.chamsVisibleOnly = ChamsVisibleOnly
        end
        Rayfield:Notify({
            Title = "Chams Visibility",
            Content = Value and "Visible Only" or "All Visible",
            Duration = 1.5,
            Image = Value and "circle-check" or "circle-x"
        })
    end,
})


local AimbotToggle = AimbotTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Flag = "aimbot",
    Callback = function(Value)
        AimbotEnabled = Value
        Rayfield:Notify({
            Title = "Aimbot",
            Content = Value and "Enabled" or "Disabled",
            Duration = 1.5,
            Image = Value and "circle-check" or "circle-x"
        })
    end,
})

local TeamCheckToggle = AimbotTab:CreateToggle({
    Name = "Team Check",
    CurrentValue = false,
    Flag = "aimbotteamcheck",
    Callback = function(Value)
        TeamCheckEnabled = Value
        Rayfield:Notify({
            Title = "Team Check",
            Content = Value and "Enabled" or "Disabled",
            Duration = 1.5,
            Image = Value and "circle-check" or "circle-x"
        })
    end,
})




local Slider = AimbotTab:CreateSlider({
    Name = "Aimbot Smoothness",
    Range = {1, 10},
    Increment = 1,
    Suffix = "Smoothness",
    CurrentValue = 1,
    Flag = "AimbotSmoothness",
    Callback = function(Value)
        AimbotSmoothness = Value
    end,
})

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local localPlayer = Players.LocalPlayer
    local localCharacter = localPlayer.Character
    
    if not localCharacter or not localCharacter:FindFirstChild("Head") then return nil end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            -- Team Check
            if TeamCheckEnabled and player.Team == localPlayer.Team then
                continue
            end

            local character = player.Character
            if character and character:FindFirstChild("Head") then
                local magnitude = (character.Head.Position - localCharacter.Head.Position).Magnitude
                if magnitude < shortestDistance then
                    closestPlayer = player
                    shortestDistance = magnitude
                end
            end
        end
    end

    return closestPlayer
end

local AimbotConnection = RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        local closestPlayer = getClosestPlayer()
        if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
            local camera = workspace.CurrentCamera
            local targetPosition = closestPlayer.Character.Head.Position
            local smoothness = 1 / AimbotSmoothness
            
            if camera then
                local targetCFrame = CFrame.new(camera.CFrame.Position, targetPosition)
                camera.CFrame = camera.CFrame:Lerp(targetCFrame, smoothness)
            end
        end
    end
end)

local function createScriptButtons()
    local success, scriptData = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/MoonDeveloping/MoonScripts/refs/heads/main/scripts.json")
    end)

    if success then
        local decodedData = game:GetService("HttpService"):JSONDecode(scriptData)
        
        if decodedData and decodedData.scripts then
            for _, scriptInfo in ipairs(decodedData.scripts) do
                ScriptsTab:CreateButton({
                    Name = scriptInfo.name,
                    Callback = function()
                        loadstring(game:HttpGet(scriptInfo.link))()
                        Rayfield:Notify({
                            Title = "Script Loaded",
                            Content = scriptInfo.name .. " successfully loaded!",
                            Duration = 1.5,
                            Image = "circle-check"
                        })
                    end,
                })
            end
        end
    else
        Rayfield:Notify({
            Title = "Error",
            Content = "Script verileri yüklenemedi!",
            Duration = 3,
            Image = "circle-x"
        })
    end
end

createScriptButtons()

local Button = SettingsTab:CreateButton({
    Name = "Destroy GUI",
    Callback = function()
        Rayfield:Destroy()
    end,
})


local InfJumpKeybind = SettingsTab:CreateKeybind({
    Name = "Infinite Jump Keybind",
    CurrentKeybind = "J",
    HoldToInteract = false,
    Flag = "InfJumpKey",
    Callback = function(Keybind)
       InfiniteJumpEnabled = not InfiniteJumpEnabled
       InfToggle:Set(InfiniteJumpEnabled) -- Toggle'ı güncelle
    end,
 })

 
local NoclipKeybind = SettingsTab:CreateKeybind({
    Name = "Noclip Keybind",
    CurrentKeybind = "N",
    HoldToInteract = false,
    Flag = "NoclipKey",
    Callback = function(Keybind)
       NoclipEnabled = not NoclipEnabled
       NoclipToggle:Set(NoclipEnabled) -- Toggle'ı güncelle
    end,
 })

  
local FlyKeybind = SettingsTab:CreateKeybind({
    Name = "Fly Keybind",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Flag = "FlyKey",
    Callback = function(Keybind)
       FlyEnabled = not FlyEnabled
       FlyToggle:Set(FlyEnabled) -- Toggle'ı güncelle
    end,
 })

local QTeleportKeybind = SettingsTab:CreateKeybind({
    Name = "Toggle Q Teleport",
    CurrentKeybind = "Z",
    HoldToInteract = false,
    Flag = "QTeleportKey",
    Callback = function(Keybind)
        QTeleportEnabled = not QTeleportEnabled
        QTeleportToggle:Set(QTeleportEnabled)
    end,
})

local CtrlTeleportKeybind = SettingsTab:CreateKeybind({
    Name = "Toggle CTRL Teleport",
    CurrentKeybind = "X",
    HoldToInteract = false,
    Flag = "CtrlTeleportKey",
    Callback = function(Keybind)
        CtrlTeleportEnabled = not CtrlTeleportEnabled
        CtrlTeleportToggle:Set(CtrlTeleportEnabled)
    end,
})

local AimbotKeybind = SettingsTab:CreateKeybind({
    Name = "Toggle Aimbot",
    CurrentKeybind = "V",
    HoldToInteract = false,
    Flag = "AimbotKey",
    Callback = function(Keybind)
        AimbotEnabled = not AimbotEnabled
        AimbotToggle:Set(AimbotEnabled)
    end,
})

local TeamCheckKeybind = SettingsTab:CreateKeybind({
    Name = "Toggle Team Check",
    CurrentKeybind = "B",
    HoldToInteract = false,
    Flag = "TeamCheckKey",
    Callback = function(Keybind)
        TeamCheckEnabled = not TeamCheckEnabled
        TeamCheckToggle:Set(TeamCheckEnabled)
    end,
})

local selectedPlayer = nil

local function updatePlayerList()
    local playerList = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    table.sort(playerList)
    return playerList
end

local PlayerDropdown = MainTab:CreateDropdown({
    Name = "Player List",
    Options = updatePlayerList(),
    CurrentOption = "",
    Flag = "PlayerList",
    Callback = function(Option)
        if type(Option) == "table" then
            selectedPlayer = Option[1]
        else
            selectedPlayer = Option
        end
    end,
})

local TeleportButton = MainTab:CreateButton({
    Name = "Teleport to Selected Player",
    Callback = function()
        if selectedPlayer then
            local targetPlayer = Players:FindFirstChild(tostring(selectedPlayer))
            if targetPlayer then
                if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local localPlayer = Players.LocalPlayer
                    if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        localPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    else
                    end
                else
                end
            else
            end
        else
        end
    end,
})

local RefreshButton = MainTab:CreateButton({
    Name = "Refresh Player List",
    Callback = function()
        local newList = updatePlayerList()
        PlayerDropdown:Refresh(newList, true)
    end,
})

Players.PlayerAdded:Connect(function(player)
    PlayerDropdown:Refresh(updatePlayerList(), true)
end)

Players.PlayerRemoving:Connect(function(player)
    if selectedPlayer == player.Name then
        selectedPlayer = nil
    end
    PlayerDropdown:Refresh(updatePlayerList(), true)
end)

local PlayerListKeybind = SettingsTab:CreateKeybind({
    Name = "Teleport to Selected Player",
    CurrentKeybind = "P",
    HoldToInteract = false,
    Flag = "PlayerListKey",
    Callback = function(Keybind)
        if selectedPlayer then
            local targetPlayer = Players:FindFirstChild(tostring(selectedPlayer))
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local localPlayer = Players.LocalPlayer
                if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    localPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                end
            end
        end
    end,
})
