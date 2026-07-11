-- Lock & Avatars Hub v2.0
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- SETTINGS
local SMOOTHNESS = 0.2  -- Lock smoothness

-- GUI (persistent)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LockGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer.PlayerGui

-- Main Button (toggle main menu)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 50, 0, 50)
btn.Position = UDim2.new(0, 10, 0, 10)
btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
btn.BorderSizePixel = 0
btn.Text = "⚙"
btn.TextScaled = true
btn.TextColor3 = Color3.fromRGB(0, 200, 255)
btn.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(1, 0)
btnCorner.Parent = btn

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(0, 200, 255)
btnStroke.Thickness = 2
btnStroke.Parent = btn

-- MAIN MENU FRAME
local mainMenu = Instance.new("Frame")
mainMenu.Size = UDim2.new(0, 250, 0, 150)
mainMenu.Position = UDim2.new(0, 70, 0, 10)
mainMenu.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
mainMenu.BorderSizePixel = 0
mainMenu.Visible = false
mainMenu.Parent = screenGui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 10)
menuCorner.Parent = mainMenu

local menuStroke = Instance.new("UIStroke")
menuStroke.Color = Color3.fromRGB(0, 200, 255)
menuStroke.Thickness = 2
menuStroke.Parent = mainMenu

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚙️ HUB"
titleLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.Parent = mainMenu

-- Buttons inside main menu
local lockBtn = Instance.new("TextButton")
lockBtn.Size = UDim2.new(0.8, 0, 0, 35)
lockBtn.Position = UDim2.new(0.1, 0, 0, 45)
lockBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
lockBtn.BorderSizePixel = 0
lockBtn.Text = "🔒 Lock"
lockBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
lockBtn.Font = Enum.Font.Gotham
lockBtn.TextSize = 16
lockBtn.Parent = mainMenu
local lockCorner = Instance.new("UICorner")
lockCorner.CornerRadius = UDim.new(0, 6)
lockCorner.Parent = lockBtn

local avatarBtn = Instance.new("TextButton")
avatarBtn.Size = UDim2.new(0.8, 0, 0, 35)
avatarBtn.Position = UDim2.new(0.1, 0, 0, 90)
avatarBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
avatarBtn.BorderSizePixel = 0
avatarBtn.Text = "👤 Avatars"
avatarBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
avatarBtn.Font = Enum.Font.Gotham
avatarBtn.TextSize = 16
avatarBtn.Parent = mainMenu
local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 6)
avatarCorner.Parent = avatarBtn

-- LOCK SUB-MENU (same as v1.2 but with back button)
local lockSub = Instance.new("Frame")
lockSub.Size = UDim2.new(0, 220, 0, 320)
lockSub.Position = UDim2.new(0, 70, 0, 10)
lockSub.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
lockSub.BorderSizePixel = 0
lockSub.Visible = false
lockSub.Parent = screenGui
local lockSubCorner = Instance.new("UICorner")
lockSubCorner.CornerRadius = UDim.new(0, 10)
lockSubCorner.Parent = lockSub
local lockSubStroke = Instance.new("UIStroke")
lockSubStroke.Color = Color3.fromRGB(0, 200, 255)
lockSubStroke.Thickness = 2
lockSubStroke.Parent = lockSub

local lockTitle = Instance.new("TextLabel")
lockTitle.Size = UDim2.new(1, -10, 0, 30)
lockTitle.Position = UDim2.new(0, 5, 0, 5)
lockTitle.BackgroundTransparency = 1
lockTitle.Text = "🔒 LOCK"
lockTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
lockTitle.Font = Enum.Font.GothamBold
lockTitle.TextSize = 18
lockTitle.TextXAlignment = Enum.TextXAlignment.Left
lockTitle.Parent = lockSub

local backLock = Instance.new("TextButton")
backLock.Size = UDim2.new(0, 40, 0, 25)
backLock.Position = UDim2.new(1, -45, 0, 5)
backLock.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
backLock.BorderSizePixel = 0
backLock.Text = "←"
backLock.TextColor3 = Color3.fromRGB(200, 200, 220)
backLock.Font = Enum.Font.Gotham
backLock.TextSize = 18
backLock.Parent = lockSub
local backLockCorner = Instance.new("UICorner")
backLockCorner.CornerRadius = UDim.new(0, 4)
backLockCorner.Parent = backLock

local lockScroll = Instance.new("ScrollingFrame")
lockScroll.Size = UDim2.new(1, -10, 1, -40)
lockScroll.Position = UDim2.new(0, 5, 0, 35)
lockScroll.BackgroundTransparency = 1
lockScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
lockScroll.ScrollBarThickness = 4
lockScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
lockScroll.Parent = lockSub

local lockLayout = Instance.new("UIListLayout")
lockLayout.SortOrder = Enum.SortOrder.Name
lockLayout.Padding = UDim.new(0, 6)
lockLayout.Parent = lockScroll

-- AVATARS SUB-MENU
local avatarSub = Instance.new("Frame")
avatarSub.Size = UDim2.new(0, 220, 0, 180)
avatarSub.Position = UDim2.new(0, 70, 0, 10)
avatarSub.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
avatarSub.BorderSizePixel = 0
avatarSub.Visible = false
avatarSub.Parent = screenGui
local avatarSubCorner = Instance.new("UICorner")
avatarSubCorner.CornerRadius = UDim.new(0, 10)
avatarSubCorner.Parent = avatarSub
local avatarSubStroke = Instance.new("UIStroke")
avatarSubStroke.Color = Color3.fromRGB(0, 200, 255)
avatarSubStroke.Thickness = 2
avatarSubStroke.Parent = avatarSub

local avatarTitle = Instance.new("TextLabel")
avatarTitle.Size = UDim2.new(1, -10, 0, 30)
avatarTitle.Position = UDim2.new(0, 5, 0, 5)
avatarTitle.BackgroundTransparency = 1
avatarTitle.Text = "👤 AVATARS"
avatarTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
avatarTitle.Font = Enum.Font.GothamBold
avatarTitle.TextSize = 18
avatarTitle.TextXAlignment = Enum.TextXAlignment.Left
avatarTitle.Parent = avatarSub

local backAvatar = Instance.new("TextButton")
backAvatar.Size = UDim2.new(0, 40, 0, 25)
backAvatar.Position = UDim2.new(1, -45, 0, 5)
backAvatar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
backAvatar.BorderSizePixel = 0
backAvatar.Text = "←"
backAvatar.TextColor3 = Color3.fromRGB(200, 200, 220)
backAvatar.Font = Enum.Font.Gotham
backAvatar.TextSize = 18
backAvatar.Parent = avatarSub
local backAvatarCorner = Instance.new("UICorner")
backAvatarCorner.CornerRadius = UDim.new(0, 4)
backAvatarCorner.Parent = backAvatar

-- Speed slider
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -10, 0, 20)
speedLabel.Position = UDim2.new(0, 5, 0, 40)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed: 16"
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 14
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = avatarSub

local speedSlider = Instance.new("TextButton") -- using TextButton as slider track
speedSlider.Size = UDim2.new(1, -10, 0, 6)
speedSlider.Position = UDim2.new(0, 5, 0, 65)
speedSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
speedSlider.BorderSizePixel = 0
speedSlider.Text = ""
speedSlider.Parent = avatarSub
local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(1, 0)
sliderCorner.Parent = speedSlider

-- Indicator (draggable)
local speedIndicator = Instance.new("TextButton")
speedIndicator.Size = UDim2.new(0, 12, 0, 12)
speedIndicator.Position = UDim2.new(0, 0, 0, -3)
speedIndicator.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
speedIndicator.BorderSizePixel = 0
speedIndicator.Text = ""
speedIndicator.Parent = speedSlider
local indCorner = Instance.new("UICorner")
indCorner.CornerRadius = UDim.new(1, 0)
indCorner.Parent = speedIndicator

-- Jump slider
local jumpLabel = Instance.new("TextLabel")
jumpLabel.Size = UDim2.new(1, -10, 0, 20)
jumpLabel.Position = UDim2.new(0, 5, 0, 80)
jumpLabel.BackgroundTransparency = 1
jumpLabel.Text = "Jump: 50"
jumpLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
jumpLabel.Font = Enum.Font.Gotham
jumpLabel.TextSize = 14
jumpLabel.TextXAlignment = Enum.TextXAlignment.Left
jumpLabel.Parent = avatarSub

local jumpSlider = Instance.new("TextButton")
jumpSlider.Size = UDim2.new(1, -10, 0, 6)
jumpSlider.Position = UDim2.new(0, 5, 0, 105)
jumpSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
jumpSlider.BorderSizePixel = 0
jumpSlider.Text = ""
jumpSlider.Parent = avatarSub
local jumpCorner = Instance.new("UICorner")
jumpCorner.CornerRadius = UDim.new(1, 0)
jumpCorner.Parent = jumpSlider

local jumpIndicator = Instance.new("TextButton")
jumpIndicator.Size = UDim2.new(0, 12, 0, 12)
jumpIndicator.Position = UDim2.new(0, 0, 0, -3)
jumpIndicator.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
jumpIndicator.BorderSizePixel = 0
jumpIndicator.Text = ""
jumpIndicator.Parent = jumpSlider
local jumpIndCorner = Instance.new("UICorner")
jumpIndCorner.CornerRadius = UDim.new(1, 0)
jumpIndCorner.Parent = jumpIndicator

-- Fly toggle
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.8, 0, 0, 30)
flyBtn.Position = UDim2.new(0.1, 0, 0, 125)
flyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
flyBtn.BorderSizePixel = 0
flyBtn.Text = "Fly: OFF"
flyBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
flyBtn.Font = Enum.Font.Gotham
flyBtn.TextSize = 14
flyBtn.Parent = avatarSub
local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 6)
flyCorner.Parent = flyBtn

-- STATE
local target = nil
local locked = false
local currentCFrame = Camera.CFrame

-- Fly state
local flying = false
local flyBodyVelocity = nil
local flyBodyGyro = nil

-- Slider values
local speedValue = 16
local jumpValue = 50

-- Helper functions
local function updateSpeedDisplay()
    speedLabel.Text = "Speed: " .. math.floor(speedValue)
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speedValue
    end
end

local function updateJumpDisplay()
    jumpLabel.Text = "Jump: " .. math.floor(jumpValue)
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.JumpPower = jumpValue
    end
end

-- Fly functions
local function startFly()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")
    if not root or not humanoid then return end

    flying = true
    flyBtn.Text = "Fly: ON"
    flyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)

    -- BodyVelocity for upward movement
    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.MaxForce = Vector3.new(0, 4000, 0)
    flyBodyVelocity.Velocity = Vector3.new(0, 10, 0)  -- initial upward
    flyBodyVelocity.Parent = root

    -- BodyGyro to keep upright
    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
    flyBodyGyro.CFrame = CFrame.new(root.Position, root.Position + Vector3.new(0, 1, 0))
    flyBodyGyro.Parent = root

    -- Movement using WASD (will be handled in RenderStepped)
end

local function stopFly()
    flying = false
    flyBtn.Text = "Fly: OFF"
    flyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
    if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
end

-- Toggle fly
local function toggleFly()
    if flying then
        stopFly()
    else
        startFly()
    end
end

-- Handle fly movement (WASD)
local function handleFlyMovement()
    if not flying then return end
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root or not flyBodyVelocity then return end

    local moveDirection = Vector3.new()
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + Camera.CFrame.LookVector * Vector3.new(1,0,1) end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - Camera.CFrame.LookVector * Vector3.new(1,0,1) end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - Camera.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + Camera.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDirection = moveDirection - Vector3.new(0, 1, 0) end

    if moveDirection.Magnitude > 0 then
        moveDirection = moveDirection.Unit * 50  -- speed
        flyBodyVelocity.Velocity = Vector3.new(moveDirection.X, moveDirection.Y, moveDirection.Z)
    else
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)  -- hover
    end

    -- Keep upright
    if flyBodyGyro then
        flyBodyGyro.CFrame = CFrame.new(root.Position, root.Position + Vector3.new(0, 1, 0))
    end
end

-- LOCK functions (same as v1.2)
local function updateLockList()
    for _, child in ipairs(lockScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, -4, 0, 30)
            b.Text = plr.Name
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            b.BorderSizePixel = 0
            b.TextColor3 = Color3.fromRGB(200, 200, 220)
            b.Font = Enum.Font.Gotham
            b.TextSize = 16
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.Parent = lockScroll
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = b
            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.fromRGB(70, 70, 90)
            stroke.Thickness = 1
            stroke.Parent = b

            b.MouseButton1Click:Connect(function()
                if locked and target == plr then
                    locked = false
                    target = nil
                    btn.Text = "⚙"
                    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    return
                end
                target = plr
                locked = true
                btn.Text = "🔓"
                btn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
                lockSub.Visible = false
            end)
        end
    end
    local count = #lockScroll:GetChildren() - 1
    lockScroll.CanvasSize = UDim2.new(0, 0, 0, count * 38 + 10)
end

-- UI navigation
local function showMainMenu()
    mainMenu.Visible = true
    lockSub.Visible = false
    avatarSub.Visible = false
end

local function showLock()
    mainMenu.Visible = false
    lockSub.Visible = true
    updateLockList()
end

local function showAvatar()
    mainMenu.Visible = false
    avatarSub.Visible = true
end

-- Button clicks
btn.MouseButton1Click:Connect(function()
    if mainMenu.Visible or lockSub.Visible or avatarSub.Visible then
        -- Close all
        mainMenu.Visible = false
        lockSub.Visible = false
        avatarSub.Visible = false
        return
    end
    showMainMenu()
end)

lockBtn.MouseButton1Click:Connect(showLock)
avatarBtn.MouseButton1Click:Connect(showAvatar)

backLock.MouseButton1Click:Connect(showMainMenu)
backAvatar.MouseButton1Click:Connect(showMainMenu)

-- Fly button
flyBtn.MouseButton1Click:Connect(toggleFly)

-- Slider dragging functions
local function setupSlider(slider, indicator, label, minVal, maxVal, callback)
    local dragging = false
    slider.MouseButton1Down:Connect(function()
        dragging = true
    end)
    slider.MouseButton1Up:Connect(function()
        dragging = false
    end)
    slider.MouseLeave:Connect(function()
        dragging = false
    end)

    local function update(pos)
        local relativeX = (pos.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
        relativeX = math.clamp(relativeX, 0, 1)
        local value = minVal + (maxVal - minVal) * relativeX
        callback(math.floor(value))
        indicator.Position = UDim2.new(relativeX, -6, 0, -3)
    end

    slider.MouseMoved:Connect(function(x, y)
        if dragging then
            update(Vector2.new(x, y))
        end
    end)
end

-- Speed slider callback
setupSlider(speedSlider, speedIndicator, speedLabel, 16, 100, function(val)
    speedValue = val
    updateSpeedDisplay()
end)

-- Jump slider callback
setupSlider(jumpSlider, jumpIndicator, jumpLabel, 40, 200, function(val)
    jumpValue = val
    updateJumpDisplay()
end)

-- Camera follow loop (Lock)
RunService.RenderStepped:Connect(function()
    if not locked or not target then
        currentCFrame = Camera.CFrame
        return
    end
    local char = target.Character
    if not char then
        locked = false
        target = nil
        btn.Text = "⚙"
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        return
    end
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        local targetPos = root.Position
        local desiredCFrame = CFrame.lookAt(Camera.CFrame.Position, targetPos)
        currentCFrame = currentCFrame:Lerp(desiredCFrame, SMOOTHNESS)
        Camera.CFrame = currentCFrame
    end
end)

-- Fly movement update (every frame)
RunService.RenderStepped:Connect(handleFlyMovement)

-- Hotkey L to unlock
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.L and locked then
        locked = false
        target = nil
        btn.Text = "⚙"
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    end
end)

-- Apply speed/jump when character respawns
LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.5)
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speedValue
        humanoid.JumpPower = jumpValue
    end
    -- If fly was on, restart
    if flying then
        wait(0.5)
        startFly()
    end
end)

-- Initial setup
currentCFrame = Camera.CFrame
updateSpeedDisplay()
updateJumpDisplay()
