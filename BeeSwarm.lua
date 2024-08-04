-- Load additional scripts
loadstring(game:HttpGet("https://raw.githubusercontent.com/Historia00012/HISTORIAHUB/main/BSS%20FREE"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Gshock3700/BSS/main/BeeSwarm.lua"))()

-- Configuration
local CONFIG = {
    DEFAULT_SPEED = 16,
    DEFAULT_JUMP_POWER = 50,
    GUI_WIDTH = 220,
    GUI_HEIGHT = 300,
    CORNER_RADIUS = UDim.new(0, 10),
    PRIMARY_COLOR = Color3.fromRGB(30, 30, 30),
    SECONDARY_COLOR = Color3.fromRGB(50, 50, 50),
    ACCENT_COLOR = Color3.fromRGB(0, 170, 255),
    TEXT_COLOR = Color3.fromRGB(255, 255, 255),
    BSS_PLACE_ID = 1537690962,
    HONEY_DUPE_INTERVAL = 0.2,
    UPDATE_INTERVAL = 0.1,
    AUTO_HIT_INTERVAL = 0.2
}

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Variables
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local speedValue = CONFIG.DEFAULT_SPEED
local jumpPowerValue = CONFIG.DEFAULT_JUMP_POWER
local isDuping = false
local isAutoHitting = false
local gui, mainFrame, contentFrame

-- Utility Functions
local function createButton(name, size, position, parent)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = CONFIG.SECONDARY_COLOR
    button.TextColor3 = CONFIG.TEXT_COLOR
    button.TextSize = 14
    button.Font = Enum.Font.SourceSansBold
    button.Parent = parent
    Instance.new("UICorner", button).CornerRadius = CONFIG.CORNER_RADIUS
    return button
end

local function createLabel(name, size, position, parent)
    local label = Instance.new("TextLabel")
    label.Name = name
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.TextColor3 = CONFIG.TEXT_COLOR
    label.TextSize = 14
    label.Font = Enum.Font.SourceSans
    label.Parent = parent
    return label
end

-- GUI Creation
local function createGUI()
    gui = Instance.new("ScreenGui")
    gui.Name = "EnhancedPlayerGUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, CONFIG.GUI_WIDTH, 0, CONFIG.GUI_HEIGHT)
    mainFrame.Position = UDim2.new(0.5, -CONFIG.GUI_WIDTH/2, 0.5, -CONFIG.GUI_HEIGHT/2)
    mainFrame.BackgroundColor3 = CONFIG.PRIMARY_COLOR
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = gui
    Instance.new("UICorner", mainFrame).CornerRadius = CONFIG.CORNER_RADIUS

    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = CONFIG.ACCENT_COLOR
    titleBar.Parent = mainFrame
    Instance.new("UICorner", titleBar).CornerRadius = CONFIG.CORNER_RADIUS

    local titleLabel = createLabel("TitleLabel", UDim2.new(1, -60, 1, 0), UDim2.new(0, 10, 0, 0), titleBar)
    titleLabel.Text = "Enhanced Player GUI"
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.SourceSansBold

    local closeButton = createButton("CloseButton", UDim2.new(0, 30, 0, 30), UDim2.new(1, -30, 0, 0), titleBar)
    closeButton.Text = "X"
    closeButton.BackgroundTransparency = 1

    local minimizeButton = createButton("MinimizeButton", UDim2.new(0, 30, 0, 30), UDim2.new(1, -60, 0, 0), titleBar)
    minimizeButton.Text = "-"
    minimizeButton.BackgroundTransparency = 1

    contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -20, 1, -70)
    contentFrame.Position = UDim2.new(0, 10, 0, 40)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local speedLabel = createLabel("SpeedLabel", UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 10), contentFrame)
    local jumpPowerLabel = createLabel("JumpPowerLabel", UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 70), contentFrame)

    local decreaseSpeedButton = createButton("DecreaseSpeedButton", UDim2.new(0, 50, 0, 30), UDim2.new(0, 0, 0, 35), contentFrame)
    decreaseSpeedButton.Text = "-"

    local increaseSpeedButton = createButton("IncreaseSpeedButton", UDim2.new(0, 50, 0, 30), UDim2.new(1, -50, 0, 35), contentFrame)
    increaseSpeedButton.Text = "+"

    local decreaseJumpPowerButton = createButton("DecreaseJumpPowerButton", UDim2.new(0, 50, 0, 30), UDim2.new(0, 0, 0, 95), contentFrame)
    decreaseJumpPowerButton.Text = "-"

    local increaseJumpPowerButton = createButton("IncreaseJumpPowerButton", UDim2.new(0, 50, 0, 30), UDim2.new(1, -50, 0, 95), contentFrame)
    increaseJumpPowerButton.Text = "+"

    local textureRemoverButton = createButton("TextureRemoverButton", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 135), contentFrame)
    textureRemoverButton.Text = "Remove Textures"

    local honeyDupeButton = createButton("HoneyDupeButton", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 175), contentFrame)
    honeyDupeButton.Text = "Honey Dupe: OFF"

    local autoHitButton = createButton("AutoHitButton", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 215), contentFrame)
    autoHitButton.Text = "Auto Hit: OFF"

    local footer = createLabel("Footer", UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 1, -20), mainFrame)
    footer.Text = "Made by Spartan"
    footer.TextSize = 12

    return {
        speedLabel = speedLabel,
        jumpPowerLabel = jumpPowerLabel,
        decreaseSpeedButton = decreaseSpeedButton,
        increaseSpeedButton = increaseSpeedButton,
        decreaseJumpPowerButton = decreaseJumpPowerButton,
        increaseJumpPowerButton = increaseJumpPowerButton,
        textureRemoverButton = textureRemoverButton,
        honeyDupeButton = honeyDupeButton,
        autoHitButton = autoHitButton,
        closeButton = closeButton,
        minimizeButton = minimizeButton
    }
end

-- GUI Functions
local function updateSpeedLabel(label)
    label.Text = "Speed: " .. speedValue
end

local function updateJumpPowerLabel(label)
    label.Text = "Jump Power: " .. jumpPowerValue
end

local function removeTextures()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        end
    end
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").FogEnd = 9e9
    settings().Rendering.QualityLevel = 1
end

local function toggleHoneyDupe(button)
    isDuping = not isDuping
    button.Text = isDuping and "Honey Dupe: ON" or "Honey Dupe: OFF"
end

local function toggleAutoHit(button)
    isAutoHitting = not isAutoHitting
    button.Text = isAutoHitting and "Auto Hit: ON" or "Auto Hit: OFF"
end

local function closeGUI()
    gui:Destroy()
end

local function minimizeGUI()
    contentFrame.Visible = not contentFrame.Visible
    mainFrame.Size = contentFrame.Visible and UDim2.new(0, CONFIG.GUI_WIDTH, 0, CONFIG.GUI_HEIGHT) or UDim2.new(0, CONFIG.GUI_WIDTH, 0, 30)
end

-- Player ESP
local function createESP(player)
    local esp = Instance.new("Highlight")
    esp.Name = player.Name .. "_ESP"
    esp.FillColor = Color3.new(1, 0, 0) -- Red
    esp.OutlineColor = Color3.new(1, 1, 1) -- White
    esp.FillTransparency = 0.5
    esp.OutlineTransparency = 0
    esp.Adornee = player.Character
    esp.Parent = player.Character
end

local function playerAdded(player)
    player.CharacterAdded:Connect(function(character)
        createESP(player)
    end)
    if player.Character then
        createESP(player)
    end
end

-- Auto Hit Function
local function autoHit()
    local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
    if tool and tool:FindFirstChild("Handle") then
        tool:Activate()
    end
end

-- Main
local function init()
    local guiElements = createGUI()

    -- Set up connections
    guiElements.decreaseSpeedButton.MouseButton1Click:Connect(function()
        if speedValue > 1 then
            speedValue = speedValue - 1
            updateSpeedLabel(guiElements.speedLabel)
        end
    end)

    guiElements.increaseSpeedButton.MouseButton1Click:Connect(function()
        speedValue = speedValue + 1
        updateSpeedLabel(guiElements.speedLabel)
    end)

    guiElements.decreaseJumpPowerButton.MouseButton1Click:Connect(function()
        if jumpPowerValue > 1 then
            jumpPowerValue = jumpPowerValue - 1
            updateJumpPowerLabel(guiElements.jumpPowerLabel)
        end
    end)

    guiElements.increaseJumpPowerButton.MouseButton1Click:Connect(function()
        jumpPowerValue = jumpPowerValue + 1
        updateJumpPowerLabel(guiElements.jumpPowerLabel)
    end)

    guiElements.textureRemoverButton.MouseButton1Click:Connect(removeTextures)
    guiElements.honeyDupeButton.MouseButton1Click:Connect(function()
        toggleHoneyDupe(guiElements.honeyDupeButton)
    end)
    guiElements.autoHitButton.MouseButton1Click:Connect(function()
        toggleAutoHit(guiElements.autoHitButton)
    end)
    guiElements.closeButton.MouseButton1Click:Connect(closeGUI)
    guiElements.minimizeButton.MouseButton1Click:Connect(minimizeGUI)

    -- Set up ESP
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            playerAdded(player)
        end
    end
    Players.PlayerAdded:Connect(playerAdded)

    -- Main loop
    RunService.Heartbeat:Connect(function()
        if character and character:FindFirstChild("Humanoid") then
            humanoid = character.Humanoid
            humanoid.WalkSpeed = speedValue
            humanoid.JumpPower = jumpPowerValue
        end

        if isAutoHitting then
            autoHit()
        end
    end)

    -- Honey dupe loop
    spawn(function()
        while true do
            if isDuping and game.PlaceId == CONFIG.BSS_PLACE_ID then
                pcall(function()
                    ReplicatedStorage.Events.ClientToServer.ClaimHoneyToken:FireServer(10000)
                end)
            end
            wait(CONFIG.HONEY_DUPE_INTERVAL)
        end
    end)

    -- Character respawn handler
    player.CharacterAdded:Connect(function(newCharacter)
        character = newCharacter
        humanoid = character:WaitForChild("Humanoid")
    end)

    -- Anti-AFK
    local virtualUser = game:GetService("VirtualUser")
    player.Idled:Connect(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
    end)

    -- Update labels
    updateSpeedLabel(guiElements.speedLabel)
    updateJumpPowerLabel(guiElements.jumpPowerLabel)
end

-- Run the script
init()
