-- Lock Camera v1.2 - Improved (based on v1.1)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- SETTINGS
local SMOOTHNESS = 0.2  -- 0 = instant, 1 = very slow (Lerp alpha)

-- GUI (persistent)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LockGui"
screenGui.ResetOnSpawn = false  -- Keeps GUI after death
screenGui.Parent = LocalPlayer.PlayerGui

-- Main Button
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 60, 0, 60)
btn.Position = UDim2.new(0, 10, 0, 10)
btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
btn.BorderColor3 = Color3.fromRGB(0, 255, 255)
btn.BorderSizePixel = 2
btn.Text = "🔒"
btn.TextScaled = true
btn.TextColor3 = Color3.fromRGB(0, 255, 255)
btn.Parent = screenGui

-- Player list frame
local listFrame = Instance.new("Frame")
listFrame.Size = UDim2.new(0, 200, 0, 300)
listFrame.Position = UDim2.new(0, 80, 0, 10)
listFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
listFrame.BorderColor3 = Color3.fromRGB(0, 255, 255)
listFrame.BorderSizePixel = 2
listFrame.Visible = false
listFrame.Parent = screenGui

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -10)
scroll.Position = UDim2.new(0, 5, 0, 5)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 6
scroll.Parent = listFrame

local layout = Instance.new("UIListLayout")
layout.SortOrder = Enum.SortOrder.Name
layout.Padding = UDim.new(0, 4)
layout.Parent = scroll

-- State
local target = nil
local locked = false
local listVisible = false
local currentCFrame = Camera.CFrame  -- for smooth interpolation

-- Update player list
local function updateList()
    for _, child in ipairs(scroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, -4, 0, 30)
            b.Text = plr.Name
            b.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            b.BorderColor3 = Color3.fromRGB(100, 200, 255)
            b.BorderSizePixel = 1
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.Font = Enum.Font.SourceSans
            b.TextSize = 18
            b.Parent = scroll
            b.MouseButton1Click:Connect(function()
                -- If clicking the same player while locked, unlock
                if locked and target == plr then
                    locked = false
                    target = nil
                    btn.Text = "🔒"
                    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)  -- reset glow
                    return
                end
                -- Set new target
                target = plr
                locked = true
                listVisible = false
                listFrame.Visible = false
                btn.Text = "🔓"
                btn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)  -- glow effect
            end)
        end
    end
    local count = #scroll:GetChildren() - 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, count * 34 + 10)
end

Players.PlayerAdded:Connect(updateList)
Players.PlayerRemoving:Connect(updateList)

-- Button click: if locked -> unlock, else toggle list
btn.MouseButton1Click:Connect(function()
    if locked then
        locked = false
        target = nil
        btn.Text = "🔒"
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        return
    end
    listVisible = not listVisible
    listFrame.Visible = listVisible
    if listVisible then
        updateList()
    end
end)

-- Camera follow with smooth interpolation
RunService.RenderStepped:Connect(function()
    if not locked or not target then
        currentCFrame = Camera.CFrame  -- reset when not locked
        return
    end
    local char = target.Character
    if not char then
        locked = false
        target = nil
        btn.Text = "🔒"
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        return
    end
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        local targetPos = root.Position
        local desiredCFrame = CFrame.lookAt(Camera.CFrame.Position, targetPos)
        -- Smooth interpolation
        currentCFrame = currentCFrame:Lerp(desiredCFrame, SMOOTHNESS)
        Camera.CFrame = currentCFrame
    end
end)

-- Hotkey L to unlock
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.L and locked then
        locked = false
        target = nil
        btn.Text = "🔒"
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    end
end)

-- Initial list
updateList()

-- Set initial CFrame
currentCFrame = Camera.CFrame
