-- Lock & Avatars Hub v4.1 (Fly Speed added)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- SETTINGS
local SMOOTHNESS = 0.2
local DEFAULT_FLY_SPEED = 50

-- GUI (persistent)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LockGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer.PlayerGui

-- Main Button
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

-- MAIN MENU
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

-- LOCK SUB-MENU
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

-- AVATARS SUB-MENU (now with Fly Speed slider)
local avatarSub = Instance.new("Frame")
avatarSub.Size = UDim2.new(0, 220, 0, 250)  -- increased height
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

-- Speed
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

local speedSlider = Instance.new("TextButton")
speedSlider.Size = UDim2.new(1, -10, 0, 6)
speedSlider.Position = UDim2.new(0, 5, 0, 65)
speedSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
speedSlider.BorderSizePixel = 0
speedSlider.Text = ""
speedSlider.Parent = avatarSub
local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(1, 0)
speedCorner.Parent = speedSlider

local speedIndicator = Instance.new("TextButton")
speedIndicator.Size = UDim2.new(0, 12, 0, 12)
speedIndicator.Position = UDim2.new(0, 0, 0, -3)
speedIndicator.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
speedIndicator.BorderSizePixel = 0
speedIndicator.Text = ""
speedIndicator.Parent = speedSlider
local speedIndCorner = Instance.new("UICorner")
speedIndCorner.CornerRadius = UDim.new(1, 0)
speedIndCorner.Parent = speedIndicator

-- Jump
local jumpLabel = Instance.new("TextLabel")
jumpLabel.Size = UDim2.new(1, -10, 0, 20)
jumpLabel.Position = UDim2.new(0, 5, 0, 85)
jumpLabel.BackgroundTransparency = 1
jumpLabel.Text = "Jump: 50"
jumpLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
jumpLabel.Font = Enum.Font.Gotham
jumpLabel.TextSize = 14
jumpLabel.TextXAlignment = Enum.TextXAlignment.Left
jumpLabel.Parent = avatarSub

local jumpSlider = Instance.new("TextButton")
jumpSlider.Size = UDim2.new(1, -10, 0, 6)
jumpSlider.Position = UDim2.new(0, 5, 0, 110)
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

-- Fly button
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.8, 0, 0, 30)
flyBtn.Position = UDim2.new(0.1, 0, 0, 135)
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

-- NEW: Fly Speed slider
local flySpeedLabel = Instance.new("TextLabel")
flySpeedLabel.Size = UDim2.new(1, -10, 0, 20)
flySpeedLabel.Position = UDim2.new(0, 5, 0, 175)
flySpeedLabel.BackgroundTransparency = 1
flySpeedLabel.Text = "Fly Speed: 50"
flySpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
flySpeedLabel.Font = Enum.Font.Gotham
flySpeedLabel.TextSize = 14
flySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
flySpeedLabel.Parent = avatarSub

local flySpeedSlider = Instance.new("TextButton")
flySpeedSlider.Size = UDim2.new(1, -10, 0, 6)
flySpeedSlider.Position = UDim2.new(0, 5, 0, 200)
flySpeedSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
flySpeedSlider.BorderSizePixel = 0
flySpeedSlider.Text = ""
flySpeedSlider.Parent = avatarSub
local flySpeedCorner = Instance.new("UICorner")
flySpeedCorner.CornerRadius = UDim.new(1, 0)
flySpeedCorner.Parent = flySpeedSlider

local flySpeedIndicator = Instance.new("TextButton")
flySpeedIndicator.Size = UDim2.new(0, 12, 0, 12)
flySpeedIndicator.Position = UDim2.new(0, 0, 0, -3)
flySpeedIndicator.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
flySpeedIndicator.BorderSizePixel = 0
flySpeedIndicator.Text = ""
flySpeedIndicator.Parent = flySpeedSlider
local flySpeedIndCorner = Instance.new("UICorner")
flySpeedIndCorner.CornerRadius = UDim.new(1, 0)
flySpeedIndCorner.Parent = flySpeedIndicator

-- STATE
local target = nil
local locked = false
local currentCFrame = Camera.CFrame
local flying = false
local flyLV = nil
local flyAV = nil

-- Values
local speedValue = 16
local jumpValue = 50
local flySpeedValue = DEFAULT_FLY_SPEED

-- Apply speed & jump to character
local function applyStats(char)
    local humanoid = char and char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speedValue
        humanoid.JumpPower = jumpValue
    end
end

-- Update displays
local function updateSpeedDisplay()
    speedLabel.Text = "Speed: " .. math.floor(speedValue)
    local char = LocalPlayer.Character
    if char then applyStats(char) end
end

local function updateJumpDisplay()
    jumpLabel.Text = "Jump: " .. math.floor(jumpValue)
    local char = LocalPlayer.Character
    if char then applyStats(char) end
end

local function updateFlySpeedDisplay()
    flySpeedLabel.Text = "Fly Speed: " .. math.floor(flySpeedValue)
end

-- FLY functions
local function startFly()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")
    if not root or not humanoid then return end

    if flying then return end
    flying = true
    flyBtn.Text = "Fly: ON"
    flyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)

    humanoid.PlatformStand = true

    flyLV = Instance.new("LinearVelocity")
    flyLV.MaxForce = 4000
    flyLV.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
    flyLV.VectorVelocity = Vector3.new(0, 0, 0)
    flyLV.Parent = root

    flyAV = Instance.new("AngularVelocity")
    flyAV.MaxTorque = 4000
    flyAV.AngularVelocity = Vector3.new(0, 0, 0)
    flyAV.Parent = root
end

local function stopFly()
    flying = false
    flyBtn.Text = "Fly: OFF"
    flyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)

    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
    if flyLV then flyLV:Destroy() flyLV = nil end
    if flyAV then flyAV:Destroy() flyAV = nil end
end

local function toggleFly()
    if flying then
        stopFly()
    else
        startFly()
    end
end

-- Fly movement update (uses flySpeedValue)
local function updateFlyMovement()
    if not flying then return end
    local char = LocalPlayer.Character
    if not char then
        stopFly()
        return
    end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root or not flyLV then return end

    local move = Vector3.new()
    local cam = Camera
    local forward = cam.CFrame.LookVector * Vector3.new(1,0,1)
    local right = cam.CFrame.RightVector
    local up = Vector3.new(0,1,0)

    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + forward end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - forward end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - right end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + right end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + up end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - up end

    if move.Magnitude > 0 then
        move = move.Unit * flySpeedValue
    end
    flyLV.VectorVelocity = move

    if flyAV then
        flyAV.AngularVelocity = Vector3.new(0, 0, 0)
    end
end

-- LOCK functions
local function updateLockList()
    for _, child in ipairs(lockScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
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

-- NAVIGATION
local function showMain()
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

-- BUTTON EVENTS
btn.MouseButton1Click:Connect(function()
    if mainMenu.Visible or lockSub.Visible or avatarSub.Visible then
        mainMenu.Visible = false
        lockSub.Visible = false
        avatarSub.Visible = false
        return
    end
    showMain()
end)

lockBtn.MouseButton1Click:Connect(showLock)
avatarBtn.MouseButton1Click:Connect(showAvatar)
backLock.MouseButton1Click:Connect(showMain)
backAvatar.MouseButton1Click:Connect(showMain)
flyBtn.MouseButton1Click:Connect(toggleFly)

-- SLIDER LOGIC
local function setupSlider(slider, indicator, label, min, max, callback)
    local dragging = false
    slider.MouseButton1Down:Connect(function() dragging = true end)
    slider.MouseButton1Up:Connect(function() dragging = false end)
    slider.MouseLeave:Connect(function() dragging = false end)

    local function update(posX)
        local rel = math.clamp((posX - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
        local val = min + (max - min) * rel
        callback(val)
        indicator.Position = UDim2.new(rel, -6, 0, -3)
        local currentText = label.Text
        local num = string.match(currentText, "(%d+)$")
        if num then
            label.Text = currentText:gsub("%d+$", "") .. math.floor(val)
        end
    end

    slider.MouseMoved:Connect(function(x, y)
        if dragging then update(x) end
    end)

    slider.MouseButton1Click:Connect(function(x, y)
        update(x)
    end)
end

setupSlider(speedSlider, speedIndicator, speedLabel, 16, 100, function(val)
    speedValue = math.floor(val)
    updateSpeedDisplay()
end)

setupSlider(jumpSlider, jumpIndicator, jumpLabel, 40, 200, function(val)
    jumpValue = math.floor(val)
    updateJumpDisplay()
end)

-- Fly Speed slider (min 5, max 120)
setupSlider(flySpeedSlider, flySpeedIndicator, flySpeedLabel, 5, 120, function(val)
    flySpeedValue = math.floor(val)
    updateFlySpeedDisplay()
end)

-- CAMERA LOCK
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
        local desired = CFrame.lookAt(Camera.CFrame.Position, targetPos)
        currentCFrame = currentCFrame:Lerp(desired, SMOOTHNESS)
        Camera.CFrame = currentCFrame
    end
end)

-- FLY UPDATE
RunService.RenderStepped:Connect(updateFlyMovement)

-- HOTKEYS
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.L and locked then
        locked = false
        target = nil
        btn.Text = "⚙"
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    end
    if input.KeyCode == Enum.KeyCode.F and not processed then
        toggleFly()
    end
end)

-- RESPAWN HANDLER
LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.5)
    applyStats(char)
    if flying then
        wait(0.5)
        startFly()
    end
end)

-- PROTECT Speed & Jump from being reset
local function protectStats(char)
    local humanoid = char and char:FindFirstChild("Humanoid")
    if not humanoid then return end

    humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if humanoid.WalkSpeed ~= speedValue and not flying then
            humanoid.WalkSpeed = speedValue
        end
    end)

    humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
        if humanoid.JumpPower ~= jumpValue then
            humanoid.JumpPower = jumpValue
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.5)
    protectStats(char)
end)

if LocalPlayer.Character then
    wait(0.5)
    protectStats(LocalPlayer.Character)
end

-- INIT
currentCFrame = Camera.CFrame
updateSpeedDisplay()
updateJumpDisplay()
updateFlySpeedDisplay()
