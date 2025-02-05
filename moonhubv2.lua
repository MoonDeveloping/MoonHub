local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local Sense = loadstring(game:HttpGet('https://raw.githubusercontent.com/MoonDeveloping/MoonScripts/refs/heads/main/esp.lua'))()
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Teams = game:GetService("Teams")

local Window = Fluent:CreateWindow({
    Title = "Moon Hub V2",
    SubTitle = "by MrCaniwes",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Variables
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

-- Create Tabs
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    ESP = Window:AddTab({ Title = "ESP", Icon = "eye" }),
    Aimbot = Window:AddTab({ Title = "Aimbot", Icon = "target" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Main Tab Features
local InfToggle = Tabs.Main:AddToggle("InfJump", {
    Title = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end
})

local NoclipToggle = Tabs.Main:AddToggle("Noclip", {
    Title = "Noclip",
    Default = false,
    Callback = function(Value)
        NoclipEnabled = Value
    end
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

local FlyToggle = Tabs.Main:AddToggle("Fly", {
    Title = "Fly",
    Default = false,
    Callback = function(Value)
        FlyEnabled = Value
        if FlyEnabled then
            startFlying()
        end
    end
})

local FlySpeedSlider = Tabs.Main:AddSlider("FlySpeed", {
    Title = "Fly Speed",
    Description = "Adjust flying speed",
    Default = 30,
    Min = 0,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        FlySpeed = Value
    end
})

local WalkSpeedSlider = Tabs.Main:AddSlider("WalkSpeed", {
    Title = "Walk Speed",
    Description = "Adjust walking speed",
    Default = 16,
    Min = 0,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

local JumpHeightSlider = Tabs.Main:AddSlider("JumpHeight", {
    Title = "Jump Height",
    Description = "Adjust jump height",
    Default = 16,
    Min = 0,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpHeight = Value
    end
})

local QTeleportToggle = Tabs.Main:AddToggle("QTeleport", {
    Title = "Q to Teleport",
    Default = false,
    Callback = function(Value)
        QTeleportEnabled = Value
        if Value and CtrlTeleportEnabled then
            CtrlTeleportEnabled = false
            CtrlTeleportToggle:SetValue(false)
        end
    end
})

local CtrlTeleportToggle = Tabs.Main:AddToggle("CtrlTeleport", {
    Title = "CTRL to Teleport",
    Default = false,
    Callback = function(Value)
        CtrlTeleportEnabled = Value
        if Value and QTeleportEnabled then
            QTeleportEnabled = false
            QTeleportToggle:SetValue(false)
        end
    end
})

-- ESP Tab Features
local ESPToggle = Tabs.ESP:AddToggle("ESP", {
    Title = "ESP Master Toggle",
    Default = false,
    Callback = function(Value)
        ESPEnabled = Value
        if ESPEnabled then
            ESPEnabled = true   
            Sense.Load()
        else
            ESPEnabled = false
            Sense.Unload()
        end
    end
})

local BoxESPToggle = Tabs.ESP:AddToggle("BoxESP", {
    Title = "Box ESP",
    Default = false,
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
    end
})

local BoxESPColorPicker = Tabs.ESP:AddColorpicker("BoxESPColor", {
    Title = "Box ESP Color",
    Default = Color3.fromRGB(0, 64, 191),
    Callback = function(Value)
        if ESPEnabled and BoxESPEnabled then
            Sense.teamSettings.enemy.boxColor[1] = Value
            Sense.teamSettings.friendly.boxColor[1] = Value
            BoxESPColor = Value
        end
    end
})

local ChamsToggle = Tabs.ESP:AddToggle("Chams", {
    Title = "Chams",
    Default = false,
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
    end
})

local ChamsFillColorPicker = Tabs.ESP:AddColorpicker("ChamsFillColor", {
    Title = "Chams Fill Color",
    Default = Color3.fromRGB(0, 64, 191),
    Callback = function(Value)
        if ESPEnabled and ChamsEnabled then
            Sense.teamSettings.enemy.chamsFillColor[1] = Value
            Sense.teamSettings.friendly.chamsFillColor[1] = Value
            ChamsFillColor = Value
        end
    end
})

local ChamsOutlineColorPicker = Tabs.ESP:AddColorpicker("ChamsOutlineColor", {
    Title = "Chams Outline Color",
    Default = Color3.fromRGB(0, 64, 191),
    Callback = function(Value)
        if ESPEnabled and ChamsEnabled then
            Sense.teamSettings.enemy.chamsOutlineColor[1] = Value
            Sense.teamSettings.friendly.chamsOutlineColor[1] = Value
            ChamsOutlineColor = Value
        end
    end
})

local ChamsVisibleToggle = Tabs.ESP:AddToggle("ChamsVisible", {
    Title = "Chams Visible Only",
    Default = false,
    Callback = function(Value)
        ChamsVisibleOnly = Value
        if ESPEnabled and ChamsEnabled then
            Sense.teamSettings.enemy.chamsVisibleOnly = ChamsVisibleOnly
            Sense.teamSettings.friendly.chamsVisibleOnly = ChamsVisibleOnly
        end
    end
})

local HealthBarToggle = Tabs.ESP:AddToggle("HealthBar", {
    Title = "Health Bar",
    Default = false,
    Callback = function(Value)
        HealtBarEnabled = Value
        if ESPEnabled and HealtBarEnabled then
            Sense.teamSettings.enemy.healthBar = true
            Sense.teamSettings.friendly.healthBar = true
        else
            Sense.teamSettings.enemy.healthBar = false  
            Sense.teamSettings.friendly.healthBar = false
        end
    end
})

-- Aimbot Tab Features
local AimbotToggle = Tabs.Aimbot:AddToggle("Aimbot", {
    Title = "Aimbot",
    Default = false,
    Callback = function(Value)
        AimbotEnabled = Value
    end
})

local TeamCheckToggle = Tabs.Aimbot:AddToggle("TeamCheck", {
    Title = "Team Check",
    Default = false,
    Callback = function(Value)
        TeamCheckEnabled = Value
    end
})

local AimbotSmoothnessSlider = Tabs.Aimbot:AddSlider("AimbotSmoothness", {
    Title = "Aimbot Smoothness",
    Description = "Adjust aimbot smoothness",
    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Callback = function(Value)
        AimbotSmoothness = Value
    end
})

-- Settings Tab Features
local DestroyButton = Tabs.Settings:AddButton({
    Title = "Destroy GUI",
    Description = "Close the interface",
    Callback = function()
        Window:Destroy()
    end
})

-- Keybinds
local InfJumpKeybind = Tabs.Settings:AddKeybind("InfJumpKey", {
    Title = "Infinite Jump Keybind",
    Mode = "Toggle",
    Default = "J",
    Callback = function()
        InfiniteJumpEnabled = not InfiniteJumpEnabled
        InfToggle:SetValue(InfiniteJumpEnabled)
    end
})

local NoclipKeybind = Tabs.Settings:AddKeybind("NoclipKey", {
    Title = "Noclip Keybind",
    Mode = "Toggle",
    Default = "N",
    Callback = function()
        NoclipEnabled = not NoclipEnabled
        NoclipToggle:SetValue(NoclipEnabled)
    end
})

local FlyKeybind = Tabs.Settings:AddKeybind("FlyKey", {
    Title = "Fly Keybind",
    Mode = "Toggle",
    Default = "F",
    Callback = function()
        FlyEnabled = not FlyEnabled
        FlyToggle:SetValue(FlyEnabled)
    end
})

local AimbotKeybind = Tabs.Settings:AddKeybind("AimbotKey", {
    Title = "Aimbot Keybind",
    Mode = "Toggle",
    Default = "V",
    Callback = function()
        AimbotEnabled = not AimbotEnabled
        AimbotToggle:SetValue(AimbotEnabled)
    end
})

local QTeleportKeybind = Tabs.Settings:AddKeybind("QTeleportKey", {
    Title = "Q Teleport Keybind",
    Mode = "Toggle",
    Default = "Z",
    Callback = function()
        QTeleportEnabled = not QTeleportEnabled
        QTeleportToggle:SetValue(QTeleportEnabled)
    end
})

local CtrlTeleportKeybind = Tabs.Settings:AddKeybind("CtrlTeleportKey", {
    Title = "CTRL Teleport Keybind",
    Mode = "Toggle",
    Default = "X",
    Callback = function()
        CtrlTeleportEnabled = not CtrlTeleportEnabled
        CtrlTeleportToggle:SetValue(CtrlTeleportEnabled)
    end
})

-- Event Handlers
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
end)

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local localPlayer = Players.LocalPlayer
    local localCharacter = localPlayer.Character
    
    if not localCharacter or not localCharacter:FindFirstChild("Head") then return nil end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
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

-- Save Manager Setup
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("MoonHubV2")
SaveManager:SetFolder("MoonHubV2/configs")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Moon Hub V2",
    Content = "Script loaded successfully!",
    Duration = 3
})
