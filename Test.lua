-- Lock Camera v2.0 - Toggle & Switch
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LockGui"
screenGui.Parent = LocalPlayer.PlayerGui

-- Main button (toggle list)
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
local target = nil          -- current target player
local locked = false        -- is lock active?
local listVisible = false   -- is list open?
local selectedButton = nil  -- reference to the button of current target

-- Update player list
local function updateList()
    -- Clear old buttons
    for _, child in ipairs(scroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    selectedButton = nil

    -- Create buttons for each player (excluding self)
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

            -- Store player reference in button
            b:SetAttribute("Player", plr)

            -- Click handler
            b.MouseButton1Click:Connect(function()
                local clickedPlayer = b:GetAttribute("Player")
                if not clickedPlayer then return end

                -- If we are already locking this player, unlock
                if locked and target == clickedPlayer then
                    locked = false
                    target = nil
                    btn.Text = "🔒"
                    if selectedButton then
                        selectedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                        selectedButton = nil
                    end
                    return
                end

                -- If locking a different player, switch target
                if locked and target ~= clickedPlayer then
                    -- Unlock old target (no need to change button highlight yet)
                    locked = false
                    target = nil
                    if selectedButton then
                        selectedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                        selectedButton = nil
                    end
                end

                -- Set new target
                target = clickedPlayer
                locked = true
                btn.Text = "🔓"
                -- Highlight selected button
                if selectedButton then
                    selectedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                end
                b.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
                selectedButton = b

                -- Close list after selection (optional)
                -- listVisible = false
                -- listFrame.Visible = false
            end)
        end
    end

    -- Update canvas size
    local count = #scroll:GetChildren() - 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, count * 34 + 10)

    -- If we have a locked target, find its button and highlight it
    if locked and target then
        for _, child in ipairs(scroll:GetChildren()) do
            if child:IsA("TextButton") and child:GetAttribute("Player") == target then
                child.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
                selectedButton = child
                break
            end
        end
    end
end

-- Events for player changes
Players.PlayerAdded:Connect(updateList)
Players.PlayerRemoving:Connect(updateList)

-- Toggle list when button is clicked
btn.MouseButton1Click:Connect(function()
    listVisible = not listVisible
    listFrame.Visible = listVisible
    if listVisible then
        updateList()
    end
end)

-- Camera follow loop
RunService.RenderStepped:Connect(function()
    if not locked or not target then
        return
    end
    local char = target.Character
    if not char then
        -- Target left, unlock
        locked = false
        target = nil
        btn.Text = "🔒"
        if selectedButton then
            selectedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
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
            selectedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            selectedButton = nil
        end
    end
end)

-- Initial list
updateList()
