-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("ImageLabel")
local moonu = Instance.new("TextLabel")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Name = "Frame"
Frame.Parent = ScreenGui
Frame.Active = true
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.BorderColor3 = Color3.fromRGB(25, 25, 25)
Frame.Position = UDim2.new(0.308425039, 0, 0.298507452, 0)
Frame.Size = UDim2.new(0, 489, 0, 324)
Frame.Image = "rbxassetid://3570695787"
Frame.ImageColor3 = Color3.fromRGB(25, 25, 25)
Frame.ScaleType = Enum.ScaleType.Slice
Frame.SliceCenter = Rect.new(100, 100, 100, 100)
Frame.SliceScale = 0.100

moonu.Name = "moonuı"
moonu.Parent = ScreenGui
moonu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
moonu.BorderColor3 = Color3.fromRGB(0, 0, 0)
moonu.BorderSizePixel = 0
moonu.Position = UDim2.new(0.457321852, 0, 0.478855729, 0)
moonu.Size = UDim2.new(0, 108, 0, 33)
moonu.Font = Enum.Font.Michroma
moonu.Text = "Moon UI"
moonu.TextColor3 = Color3.fromRGB(255, 255, 255)
moonu.TextSize = 14.000
