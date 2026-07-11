--[[
    ANONIUM SECT | Lock-On Camera v1.0
    Работает клиентски, требует запуска в LocalScript.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- === НАСТРОЙКИ ===
local ICON_IMAGE = "rbxassetid://1234567890" -- Замените на ID вашей иконки (или используйте текст)
local ICON_SIZE = UDim2.new(0, 50, 0, 50)
local LIST_SIZE = UDim2.new(0, 200, 0, 300)
local LIST_POSITION = UDim2.new(0, 60, 0, 10)

-- === СОЗДАНИЕ GUI ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LockGui"
screenGui.Parent = LocalPlayer.PlayerGui

-- Кнопка-иконка (ImageButton или TextButton)
local iconButton = Instance.new("ImageButton")
iconButton.Size = ICON_SIZE
iconButton.Position = UDim2.new(0, 10, 0, 10) -- левый верхний угол
iconButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
iconButton.BorderColor3 = Color3.fromRGB(0, 255, 255)
iconButton.BorderSizePixel = 2
iconButton.Image = ICON_IMAGE -- если нет картинки, можно оставить пустым и задать текст
iconButton.Text = "🔒" -- эмодзи замка
iconButton.TextScaled = true
iconButton.TextColor3 = Color3.fromRGB(0, 255, 255)
iconButton.Parent = screenGui

-- Контейнер списка (пока скрыт)
local listFrame = Instance.new("Frame")
listFrame.Size = LIST_SIZE
listFrame.Position = LIST_POSITION
listFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
listFrame.BorderColor3 = Color3.fromRGB(0, 255, 255)
listFrame.BorderSizePixel = 2
listFrame.Visible = false
listFrame.Parent = screenGui

-- ScrollingFrame для прокрутки списка
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -10)
scrollFrame.Position = UDim2.new(0, 5, 0, 5)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.Parent = listFrame

-- UIListLayout для автоматического расположения кнопок
local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Padding = UDim.new(0, 4)
listLayout.Parent = scrollFrame

-- === ПЕРЕМЕННЫЕ СОСТОЯНИЯ ===
local currentTarget = nil         -- текущий игрок-цель
local isLocked = false            -- активна ли фиксация
local listVisible = false         -- виден ли список

-- === ФУНКЦИЯ ОБНОВЛЕНИЯ СПИСКА ===
local function updatePlayerList()
    -- Удаляем старые кнопки (кроме Layout)
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local players = Players:GetPlayers()
    for _, player in ipairs(players) do
        if player ~= LocalPlayer then -- не показываем себя
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -4, 0, 30)
            btn.Text = player.Name
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            btn.BorderColor3 = Color3.fromRGB(100, 200, 255)
            btn.BorderSizePixel = 1
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 18
            btn.Parent = scrollFrame

            -- При нажатии на кнопку — выбираем цель
            btn.MouseButton1Click:Connect(function()
                currentTarget = player
                isLocked = true
                listVisible = false
                listFrame.Visible = false
                iconButton.Text = "🔓" -- меняем иконку, чтобы показать активный Lock
                print("Lock on: " .. player.Name)
            end)
        end
    end

    -- Обновляем CanvasSize
    local count = #scrollFrame:GetChildren() - 1 -- минус Layout
    local height = count * 34 + 10
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, height)
end

-- === ОБНОВЛЕНИЕ СПИСКА ПРИ ИЗМЕНЕНИИ ИГРОКОВ ===
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

-- === ОБРАБОТЧИК КНОПКИ-ИКОНКИ ===
iconButton.MouseButton1Click:Connect(function()
    if isLocked then
        -- Если есть цель — отключаем Lock
        isLocked = false
        currentTarget = nil
        iconButton.Text = "🔒"
        print("Lock disabled")
        return
    end

    -- Если нет цели — показываем/скрываем список
    listVisible = not listVisible
    listFrame.Visible = listVisible
    if listVisible then
        updatePlayerList() -- обновляем список перед показом
    end
end)

-- === ФУНКЦИЯ ОБНОВЛЕНИЯ КАМЕРЫ ===
local function updateCamera()
    if not isLocked or not currentTarget then
        -- Если Lock выключен или цель пропала, возвращаем стандартное поведение камеры
        -- Но мы не вмешиваемся, оставляем управление игроку.
        return
    end

    -- Проверяем, существует ли персонаж цели и его HumanoidRootPart
    local character = currentTarget.Character
    if not character then
        -- Если персонаж исчез (игрок вышел или умер), отключаем Lock
        isLocked = false
        currentTarget = nil
        iconButton.Text = "🔒"
        return
    end

    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        return
    end

    -- Получаем позицию цели
    local targetPos = rootPart.Position

    -- Получаем текущую позицию камеры (или можно использовать позицию игрока, чтобы камера была за спиной)
    -- Для простоты оставляем камеру на её текущем месте, но смотрим на цель.
    local camPos = Camera.CFrame.Position

    -- Устанавливаем CFrame камеры: смотрим из текущей позиции на цель
    Camera.CFrame = CFrame.lookAt(camPos, targetPos)
end

-- === ПОДПИСКА НА РЕНДЕР ===
RunService.RenderStepped:Connect(updateCamera)

-- === ОБРАБОТКА ОТКЛЮЧЕНИЯ ЛОКА ПО КЛАВИШЕ (дополнительно) ===
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.L then -- нажатие L отключает Lock
        if isLocked then
            isLocked = false
            currentTarget = nil
            iconButton.Text = "🔒"
            print("Lock disabled by key L")
        end
    end
end)

-- === ИНИЦИАЛИЗАЦИЯ: обновляем список при старте ===
updatePlayerList()

print("Lock Camera GUI загружен. Нажмите на иконку для выбора цели.")
