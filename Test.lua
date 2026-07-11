-- Lock & Avatars Hub v10.0 (ANTI-DETECT + DRAGGABLE ICON)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local SMOOTHNESS = 0.2

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LockGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer.PlayerGui

-- ===== ПЕРЕТАСКИВАЕМАЯ ИКОНКА =====
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

-- DRAG LOGIC
local dragging = false
local dragStart = nil
local iconStartPos = nil

btn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        iconStartPos = btn.Position
    end
end)

btn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

btn.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        btn.Position = UDim2.new(
            iconStartPos.X.Scale,
            iconStartPos.X.Offset + delta.X,
            iconStartPos.Y.Scale,
            iconStartPos.Y.Offset + delta.Y
        )
    end
end)

-- ===== ОСТАЛЬНОЙ GUI (без изменений) =====
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

-- AVATARS SUB-MENU
local avatarSub = Instance.new("Frame")
avatarSub.Size = UDim2.new(0, 260, 0, 200)
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

-- SPEED SLIDER
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -10, 0, 25)
speedLabel.Position = UDim2.new(0, 5, 0, 40)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed: 16"
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 16
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = avatarSub

local speedTrack = Instance.new("Frame")
speedTrack.Size = UDim2.new(1, -10, 0, 12)
speedTrack.Position = UDim2.new(0, 5, 0, 70)
speedTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
speedTrack.BorderSizePixel = 0
speedTrack.Parent = avatarSub
local speedTrackCorner = Instance.new("UICorner")
speedTrackCorner.CornerRadius = UDim.new(1, 0)
speedTrackCorner.Parent = speedTrack

local speedIndicator = Instance.new("ImageButton")
speedIndicator.Size = UDim2.new(0, 20, 0, 20)
speedIndicator.Position = UDim2.new(0, -10, 0, -4)
speedIndicator.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
speedIndicator.BorderSizePixel = 0
speedIndicator.Image = ""
speedIndicator.Parent = speedTrack
local speedIndCorner = Instance.new("UICorner")
speedIndCorner.CornerRadius = UDim.new(1, 0)
speedIndCorner.Parent = speedIndicator

-- JUMP SLIDER
local jumpLabel = Instance.new("TextLabel")
jumpLabel.Size = UDim2.new(1, -10, 0, 25)
jumpLabel.Position = UDim2.new(0, 5, 0, 100)
jumpLabel.BackgroundTransparency = 1
jumpLabel.Text = "Jump: 50"
jumpLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
jumpLabel.Font = Enum.Font.Gotham
jumpLabel.TextSize = 16
jumpLabel.TextXAlignment = Enum.TextXAlignment.Left
jumpLabel.Parent = avatarSub

local jumpTrack = Instance.new("Frame")
jumpTrack.Size = UDim2.new(1, -10, 0, 12)
jumpTrack.Position = UDim2.new(0, 5, 0, 130)
jumpTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
jumpTrack.BorderSizePixel = 0
jumpTrack.Parent = avatarSub
local jumpTrackCorner = Instance.new("UICorner")
jumpTrackCorner.CornerRadius = UDim.new(1, 0)
jumpTrackCorner.Parent = jumpTrack

local jumpIndicator = Instance.new("ImageButton")
jumpIndicator.Size = UDim2.new(0, 20, 0, 20)
jumpIndicator.Position = UDim2.new(0, -10, 0, -4)
jumpIndicator.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
jumpIndicator.BorderSizePixel = 0
jumpIndicator.Image = ""
jumpIndicator.Parent = jumpTrack
local jumpIndCorner = Instance.new("UICorner")
jumpIndCorner.CornerRadius = UDim.new(1, 0)
jumpIndCorner.Parent = jumpIndicator

-- ===== STATE =====
local target = nil
local locked = false
local selectedButton = nil
local smoothCamCFrame = Camera.CFrame

local speedValue = 16
local jumpValue = 50
local currentSpeed = 16  -- для плавного изменения

-- ===== ПЛАВНОЕ ПРИМЕНЕНИЕ СКОРОСТИ (АНТИ-ДЕТЕКТ) =====
local function applySpeedSmoothly(targetSpeed)
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end

    -- Если скорость изменилась слишком резко, античит может заметить
    -- Делаем плавное изменение через Tween
    local diff = math.abs(targetSpeed - currentSpeed)
    if diff > 20 then
        -- Резкое изменение — разбиваем на шаги
        local steps = math.ceil(diff / 5)
        local stepSize = (targetSpeed - currentSpeed) / steps
        for i = 1, steps do
            currentSpeed = currentSpeed + stepSize
            humanoid.WalkSpeed = math.floor(currentSpeed)
            task.wait(0.05)
        end
    else
        -- Маленькое изменение — применяем сразу
        currentSpeed = targetSpeed
        humanoid.WalkSpeed = targetSpeed
    end
end

-- ===== ПРИМЕНЕНИЕ СТАТОВ =====
local function applyStats(char)
    local humanoid = char and char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speedValue
        humanoid.JumpPower = jumpValue
        currentSpeed = speedValue
    end
end

-- ===== ОБНОВЛЕНИЕ ТЕКСТА =====
local function updateSpeedDisplay()
    speedLabel.Text = "Speed: " .. math.floor(speedValue)
end

local function updateJumpDisplay()
    jumpLabel.Text = "Jump: " .. math.floor(jumpValue)
end

-- ===== СЛАЙДЕРЫ =====
local function setupSlider(track, indicator, label, minVal, maxVal, callback)
    local dragging = false
    local dragConn = nil
    local endConn = nil

    local function updateFromPosition(inputPos)
        local trackAbsPos = track.AbsolutePosition
        local trackSize = track.AbsoluteSize.X
        local rel = (inputPos.X - trackAbsPos.X) / trackSize
        rel = math.clamp(rel, 0, 1)
        local val = minVal + (maxVal - minVal) * rel
        callback(math.floor(val))
        indicator.Position = UDim2.new(rel, -10, 0, -4)
        local labelText = label.Text:gsub("%d+$", "") .. math.floor(val)
        label.Text = labelText
    end

    local function startDrag(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromPosition(input.Position)
            if dragConn then dragConn:Disconnect() end
            if endConn then endConn:Disconnect() end
            dragConn = UserInputService.InputChanged:Connect(function(inputChanged)
                if dragging and (inputChanged.UserInputType == Enum.UserInputType.MouseMovement or inputChanged.UserInputType == Enum.UserInputType.Touch) then
                    updateFromPosition(inputChanged.Position)
                end
            end)
            endConn = UserInputService.InputEnded:Connect(function(inputEnded)
                if inputEnded.UserInputType == Enum.UserInputType.MouseButton1 or inputEnded.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                    if dragConn then dragConn:Disconnect() dragConn = nil end
                    if endConn then endConn:Disconnect() endConn = nil end
                end
            end)
        end
    end

    track.InputBegan:Connect(startDrag)
    indicator.InputBegan:Connect(startDrag)
end

setupSlider(speedTrack, speedIndicator, speedLabel, 16, 100, function(val)
    speedValue = val
    -- Применяем скорость плавно
    applySpeedSmoothly(val)
    updateSpeedDisplay()
end)

setupSlider(jumpTrack, jumpIndicator, jumpLabel, 40, 200, function(val)
    jumpValue = val
    applyStats(LocalPlayer.Character)
    updateJumpDisplay()
end)

-- ===== LOCK LIST =====
local function updateLockList()
    for _, child in ipairs(lockScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    selectedButton = nil

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

            if locked and target == plr then
                b.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
                selectedButton = b
            end

            b.MouseButton1Click:Connect(function()
                if locked and target == plr then
                    locked = false
                    target = nil
                    btn.Text = "⚙"
                    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                    if selectedButton then
                        selectedButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
                        selectedButton = nil
                    end
                    return
                end
                if selectedButton then
                    selectedButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
                    selectedButton = nil
                end
                target = plr
                locked = true
                btn.Text = "🔓"
                btn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
                b.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
                selectedButton = b
                lockSub.Visible = false
                smoothCamCFrame = Camera.CFrame
            end)
        end
    end

    local count = #lockScroll:GetChildren() - 1
    lockScroll.CanvasSize = UDim2.new(0, 0, 0, count * 38 + 10)
end

-- ===== NAVIGATION =====
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

-- ===== BUTTON EVENTS =====
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

-- ===== CAMERA LOCK =====
RunService.RenderStepped:Connect(function()
    if not locked or not target then
        return
    end
    local targetChar = target.Character
    if not targetChar then
        locked = false
        target = nil
        btn.Text = "⚙"
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        if selectedButton then
            selectedButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            selectedButton = nil
        end
        return
    end
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end

    local localChar = LocalPlayer.Character
    if not localChar then return end
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return end

    local targetPos = targetRoot.Position
    local localPos = localRoot.Position

    local dir = (targetPos - localPos)
    if dir.Magnitude < 0.1 then
        dir = Camera.CFrame.LookVector
    else
        dir = dir.Unit
    end

    local desiredPos = localPos - dir * 10 + Vector3.new(0, 3, 0)
    local desiredCFrame = CFrame.lookAt(desiredPos, targetPos)

    smoothCamCFrame = smoothCamCFrame:Lerp(desiredCFrame, SMOOTHNESS)
    Camera.CFrame = smoothCamCFrame
end)

-- ===== HOTKEY L =====
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.L and locked then
        locked = false
        target = nil
        btn.Text = "⚙"
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        if selectedButton then
            selectedButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            selectedButton = nil
        end
    end
end)

-- ===== RESPAWN =====
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if speedValue ~= 16 or jumpValue ~= 50 then
        applyStats(char)
    end
end)

-- ===== PROTECT STATS =====
local function protectStats(char)
    local humanoid = char and char:FindFirstChild("Humanoid")
    if not humanoid then return end

    humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if humanoid.WalkSpeed ~= speedValue then
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
    task.wait(0.5)
    protectStats(char)
end)

if LocalPlayer.Character then
    task.wait(0.5)
    protectStats(LocalPlayer.Character)
end

-- ===== INIT =====
smoothCamCFrame = Camera.CFrame
updateSpeedDisplay()
updateJumpDisplay()
currentSpeed = 16
