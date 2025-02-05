local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Glass Bridge",
    LoadingTitle = "Glass Bridge Script",
    LoadingSubtitle = "by MrCaniwes",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Glass Bridge Config"
    },
    Discord = {
        Enabled = false,
        Invite = "none",
        RememberJoins = true
    },
    KeySystem = false,
})

-- Create main tab
local MainTab = Window:CreateTab("Main Menu 🏠")
local MainSection = MainTab:CreateSection("Bridge Controls")

-- Variables for storing original colors
local originalColors = {}

-- Function to store original colors
local function storeOriginalColors()
    originalColors = {}
    local segments = workspace:GetDescendants()
    for _, segment in ipairs(segments) do
        if segment:IsA("Model") and segment.Name:match("^Segment%d+$") then
            for _, folder in ipairs(segment:GetChildren()) do
                if folder:IsA("Folder") then
                    for _, part in ipairs(folder:GetChildren()) do
                        if part:IsA("BasePart") then
                            originalColors[part] = part.Color
                        end
                    end
                end
            end
        end
    end
end

-- Store original colors when script starts
storeOriginalColors()

-- ESP feature
local ESPEnabled = false

local function updateESP()
    if ESPEnabled then
        local segments = workspace:GetDescendants()
        for _, segment in ipairs(segments) do
            if segment:IsA("Model") and segment.Name:match("^Segment%d+$") then
                for _, folder in ipairs(segment:GetChildren()) do
                    if folder:IsA("Folder") then
                        for _, part in ipairs(folder:GetChildren()) do
                            if part:IsA("BasePart") then
                                local breakableValue = part:FindFirstChild("breakable")
                                if breakableValue and breakableValue:IsA("BoolValue") then
                                    part.Color = Color3.fromRGB(255, 0, 0) -- Red for breakable
                                else
                                    part.Color = Color3.fromRGB(0, 255, 0) -- Green for safe
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        -- Restore original colors
        for part, color in pairs(originalColors) do
            if part and part:IsA("BasePart") then
                part.Color = color
            end
        end
    end
end

-- ESP Toggle button
local ESPToggle = MainTab:CreateToggle({
    Name = "Glass Bridge ESP",
    CurrentValue = false,
    Flag = "GlassESP",
    Callback = function(Value)
        ESPEnabled = Value
        updateESP()
        if Value then
            Rayfield:Notify({
                Title = "ESP",
                Content = "Glass Bridge ESP Enabled",
                Duration = 1.5,
                Image = "circle-check"
            })
        else
            Rayfield:Notify({
                Title = "ESP",
                Content = "Glass Bridge ESP Disabled",
                Duration = 1.5,
                Image = "circle-x"
            })
        end
    end,
})

-- Settings tab
local SettingsTab = Window:CreateTab("Settings ⚙️")
local SettingsSection = SettingsTab:CreateSection("Settings")

-- GUI destroy button
local DestroyButton = SettingsTab:CreateButton({
    Name = "Destroy GUI",
    Callback = function()
        Rayfield:Destroy()
    end,
})

-- ESP keybind
local ESPKeybind = SettingsTab:CreateKeybind({
    Name = "ESP Keybind",
    CurrentKeybind = "E",
    HoldToInteract = false,
    Flag = "ESPKey",
    Callback = function(Keybind)
        ESPEnabled = not ESPEnabled
        ESPToggle:Set(ESPEnabled)
    end,
})

-- Watch for new segments
workspace.DescendantAdded:Connect(function(descendant)
    if (descendant:IsA("Model") and descendant.Name:match("^Segment%d+$")) or
       descendant:IsA("BasePart") then
        wait(0.1)
        if descendant:IsA("BasePart") then
            originalColors[descendant] = descendant.Color
        end
        if ESPEnabled then
            updateESP()
        end
    end
end) 
