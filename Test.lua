-- Lock Camera v3.0 - Toggle & Switch with GhostHub style
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- UI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LockGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer.PlayerGui

-- Main Button (toggle list)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 50, 0, 50)
btn.Position = UDim2.new(0, 15, 0, 15)
btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
btn.BorderSizePixel = 0
btn.Text = "🔒"
btn.TextScaled = true
btn.TextColor3 = Color3.fromRGB(0, 200, 255)
btn.Parent = screenGui

-- Corner & Stroke for button
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(1, 0)
btnCorner.Parent = btn

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(0, 200, 255)
btnStroke.Thickness = 2
btnStroke.Parent = btn

-- Drop shadow (optional)
local btnShadow = Instance.new("UIShadow")
btnShadow.Color = Color3.fromRGB(0, 150, 200)
btnShadow.Offset = Vector2.new(0, 4)
btnShadow.Blur = 8
btnShadow.Parent = btn

-- Player List Frame (hidden by default)
local listFrame = Instance.new("Frame")
listFrame.Size = UDim2.new(0, 220, 0, 320)
listFrame.Position = UDim2.new(0, 75, 0, 15)
listFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
listFrame.BorderSizePixel = 0
listFrame.Visible = false
listFrame.Parent = screenGui

local listCorner = Instance.new("UICorner")
listCorner.CornerRadius = UDim.new(0, 10)
listCorner.Parent = listFrame

local listStroke = Instance.new("UIStroke")
listStroke.Color = Color3.fromRGB(0, 200, 255)
listStroke.Thickness = 2
listStroke.Parent = listFrame

local listShadow = Instance.new("UIShadow")
listShadow.Color = Color3.fromRGB(0, 150, 200)
listShadow.Offset = Vector2.new(0, 6)
listShadow.Blur = 12
listShadow.Parent = listFrame

-- Title label
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -10, 0, 30)
title.Position = UDim2.new(0, 5, 0, 5)
title.BackgroundTransparency = 1
title.Text = "🔒 LOCK CAMERA"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = listFrame

-- ScrollingFrame for player list
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -40)
scroll.Position = UDim2.new(0, 5, 0, 35)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
scroll.Parent = listFrame

local layout = Instance.new("UIListLayout")
layout.SortOrder = Enum.SortOrder.Name
layout.Padding = UDim.new(0, 6)
layout.Parent = scroll

-- State
local target = nil
local locked = false
local listVisible = false
local selectedButton = nil

-- Helper: tween transparency/color
local function tweenObject(obj, properties, duration)
    local tween = TweenService:Create(obj, TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

-- Update player list
local function updateList()
    -- Clear old buttons
    for _, child in ipairs(scroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    selectedButton = nil

    local players = Players:GetPlayers()
    local count = 0

    for _, plr in ipairs(players) do
        if plr ~= LocalPlayer then
            count = count + 1
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, -4, 0, 32)
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            b.BorderSizePixel = 0
            b.Text = plr.Name
            b.TextColor3 = Color3.fromRGB(200, 200, 220)
            b.Font = Enum.Font.Gotham
            b.TextSize = 16
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.Parent = scroll

            -- Corner for button
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = b

            -- Stroke
            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.fromRGB(70, 70, 90)
            stroke.Thickness = 1
            stroke.Parent = b

            -- Hover effect
            local function onHover(enter)
                if enter then
                    if b ~= selectedButton then
                        b.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
                    end
                else
                    if b ~= selectedButton then
                        b.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
                    end
                end
            end
            b.MouseEnter:Connect(function() onHover(true) end)
            b.MouseLeave:Connect(function() onHover(false) end)

            -- Click handler
            b.MouseButton1Click:Connect(function()
                local clickedPlayer = plr

                -- If already locking this player, unlock
                if locked and target == clickedPlayer then
                    locked = false
                    target = nil
                    btn.Text = "🔒"
                    if selectedButton then
                        selectedButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
                        selectedButton = nil
                    end
                    return
                end

                -- If locking a different player, switch
                if locked and target ~= clickedPlayer then
                    locked = false
                    target = nil
                    if selectedButton then
                        selectedButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
                        selectedButton = nil
                    end
                end

                -- Set new target
                target = clickedPlayer
                locked = true
                btn.Text = "🔓"

                -- Highlight selected button
                if selectedButton then
                    selectedButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
                end
                b.BackgroundColor3 = Color3.fromRGB(0, 120, 220)
                selectedButton = b

                -- Optionally close list after selection (uncomment to enable)
                -- listVisible = false
                -- listFrame.Visible = false
            end)
        end
    end

    -- Update canvas size
    scroll.CanvasSize = UDim2.new(0, 0, 0, count * 38 + 10)

    -- If we have a locked target, find its button and highlight it
    if locked and target then
        for _, child in ipairs(scroll:GetChildren()) do
            if child:IsA("TextButton") and child.Text == target.Name then
                child.BackgroundColor3 = Color3.fromRGB(0, 120, 220)
                selectedButton = child
                break
            end
        end
    end
end

-- Events for player changes
Players.PlayerAdded:Connect(updateList)
Players.PlayerRemoving:Connect(updateList)

-- Toggle list visibility on button click
btn.MouseButton1Click:Connect(function()
    listVisible = not listVisible
    listFrame.Visible = listVisible
    if listVisible then
        updateList()
        -- Animate opening (scale)
        listFrame.Size = UDim2.new(0, 0, 0, 0)
        tweenObject(listFrame, {Size = UDim2.new(0, 220, 0, 320)}, 0.25)
    else
        -- Animate closing
        tweenObject(listFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
        wait(0.2)
        listFrame.Visible = false
    end
end)

-- Camera follow loop
RunService.RenderStepped:Connect(function()
    if not locked or not target then return end
    local char = target.Character
    if not char then
        -- Target left, unlock
        locked = false
        target = nil
        btn.Text = "🔒"
        if selectedButton then
            selectedButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            selectedButton = nil
        end
        return
    end
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, root.Position)
    end
end)

-- Hotkey L to unlock
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.L and locked then
        locked = false
        target = nil
        btn.Text = "🔒"
        if selectedButton then
            selectedButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            selectedButton = nil
        end
    end
end)

-- Initial list (will be empty until first open)
updateList()
