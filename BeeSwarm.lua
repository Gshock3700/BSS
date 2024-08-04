-- Load the original script
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Historia00012/HISTORIAHUB/main/BSS%20FREE"))()
end)

-- Variables
local speedValue = 16 -- Default speed value
local jumpPowerValue = 50 -- Default jump power value
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local isDuping = false

-- Colors
local primaryColor = Color3.new(0, 0, 0) -- Black
local secondaryColor = Color3.fromRGB(128, 0, 0) -- Maroon

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "PlayerGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 200, 0, 260)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -130)
mainFrame.BackgroundColor3 = primaryColor
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

local cornerRadius = UDim.new(0, 10)
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = cornerRadius
uiCorner.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = secondaryColor
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.TextSize = 18
titleLabel.Text = "Player GUI"
titleLabel.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextSize = 18
closeButton.Text = "X"
closeButton.Parent = titleBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -60, 0, 0)
minimizeButton.BackgroundTransparency = 1
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.TextSize = 18
minimizeButton.Text = "-"
minimizeButton.Parent = titleBar

local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -30)
contentFrame.Position = UDim2.new(0, 0, 0, 30)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Speed Controls
local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(0, 180, 0, 30)
speedLabel.Position = UDim2.new(0, 10, 0, 10)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.TextSize = 18
speedLabel.Text = "Speed: " .. speedValue
speedLabel.Parent = contentFrame

local decreaseSpeedButton = Instance.new("TextButton")
decreaseSpeedButton.Name = "DecreaseSpeedButton"
decreaseSpeedButton.Size = UDim2.new(0, 50, 0, 30)
decreaseSpeedButton.Position = UDim2.new(0, 10, 0, 50)
decreaseSpeedButton.BackgroundColor3 = secondaryColor
decreaseSpeedButton.TextColor3 = Color3.new(1, 1, 1)
decreaseSpeedButton.TextSize = 14
decreaseSpeedButton.Text = "-"
decreaseSpeedButton.Parent = contentFrame
Instance.new("UICorner", decreaseSpeedButton).CornerRadius = cornerRadius

local increaseSpeedButton = Instance.new("TextButton")
increaseSpeedButton.Name = "IncreaseSpeedButton"
increaseSpeedButton.Size = UDim2.new(0, 50, 0, 30)
increaseSpeedButton.Position = UDim2.new(0, 140, 0, 50)
increaseSpeedButton.BackgroundColor3 = secondaryColor
increaseSpeedButton.TextColor3 = Color3.new(1, 1, 1)
increaseSpeedButton.TextSize = 14
increaseSpeedButton.Text = "+"
increaseSpeedButton.Parent = contentFrame
Instance.new("UICorner", increaseSpeedButton).CornerRadius = cornerRadius

-- Jump Power Controls
local jumpPowerLabel = Instance.new("TextLabel")
jumpPowerLabel.Name = "JumpPowerLabel"
jumpPowerLabel.Size = UDim2.new(0, 180, 0, 30)
jumpPowerLabel.Position = UDim2.new(0, 10, 0, 90)
jumpPowerLabel.BackgroundTransparency = 1
jumpPowerLabel.TextColor3 = Color3.new(1, 1, 1)
jumpPowerLabel.TextSize = 18
jumpPowerLabel.Text = "Jump Power: " .. jumpPowerValue
jumpPowerLabel.Parent = contentFrame

local decreaseJumpPowerButton = Instance.new("TextButton")
decreaseJumpPowerButton.Name = "DecreaseJumpPowerButton"
decreaseJumpPowerButton.Size = UDim2.new(0, 50, 0, 30)
decreaseJumpPowerButton.Position = UDim2.new(0, 10, 0, 130)
decreaseJumpPowerButton.BackgroundColor3 = secondaryColor
decreaseJumpPowerButton.TextColor3 = Color3.new(1, 1, 1)
decreaseJumpPowerButton.TextSize = 14
decreaseJumpPowerButton.Text = "-"
decreaseJumpPowerButton.Parent = contentFrame
Instance.new("UICorner", decreaseJumpPowerButton).CornerRadius = cornerRadius

local increaseJumpPowerButton = Instance.new("TextButton")
increaseJumpPowerButton.Name = "IncreaseJumpPowerButton"
increaseJumpPowerButton.Size = UDim2.new(0, 50, 0, 30)
increaseJumpPowerButton.Position = UDim2.new(0, 140, 0, 130)
increaseJumpPowerButton.BackgroundColor3 = secondaryColor
increaseJumpPowerButton.TextColor3 = Color3.new(1, 1, 1)
increaseJumpPowerButton.TextSize = 14
increaseJumpPowerButton.Text = "+"
increaseJumpPowerButton.Parent = contentFrame
Instance.new("UICorner", increaseJumpPowerButton).CornerRadius = cornerRadius

local textureRemoverButton = Instance.new("TextButton")
textureRemoverButton.Name = "TextureRemoverButton"
textureRemoverButton.Size = UDim2.new(0, 180, 0, 30)
textureRemoverButton.Position = UDim2.new(0, 10, 0, 170)
textureRemoverButton.BackgroundColor3 = secondaryColor
textureRemoverButton.TextColor3 = Color3.new(1, 1, 1)
textureRemoverButton.TextSize = 14
textureRemoverButton.Text = "Remove Textures"
textureRemoverButton.Parent = contentFrame
Instance.new("UICorner", textureRemoverButton).CornerRadius = cornerRadius

local honeyDupeButton = Instance.new("TextButton")
honeyDupeButton.Name = "HoneyDupeButton"
honeyDupeButton.Size = UDim2.new(0, 180, 0, 30)
honeyDupeButton.Position = UDim2.new(0, 10, 0, 210)
honeyDupeButton.BackgroundColor3 = secondaryColor
honeyDupeButton.TextColor3 = Color3.new(1, 1, 1)
honeyDupeButton.TextSize = 14
honeyDupeButton.Text = "Honey Dupe: OFF"
honeyDupeButton.Parent = contentFrame
Instance.new("UICorner", honeyDupeButton).CornerRadius = cornerRadius

local footer = Instance.new("TextLabel")
footer.Name = "Footer"
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -20)
footer.BackgroundTransparency = 1
footer.TextColor3 = Color3.new(1, 1, 1)
footer.TextSize = 14
footer.Text = "Made by Spartan"
footer.Parent = contentFrame

-- Functions
local function updateSpeedLabel()
    speedLabel.Text = "Speed: " .. speedValue
end

local function updateJumpPowerLabel()
    jumpPowerLabel.Text = "Jump Power: " .. jumpPowerValue
end

local function decreaseSpeed()
    if speedValue > 1 then
        speedValue = speedValue - 1
        updateSpeedLabel()
    end
end

local function increaseSpeed()
    speedValue = speedValue + 1
    updateSpeedLabel()
end

local function decreaseJumpPower()
    if jumpPowerValue > 1 then
        jumpPowerValue = jumpPowerValue - 1
        updateJumpPowerLabel()
    end
end

local function increaseJumpPower()
    jumpPowerValue = jumpPowerValue + 1
    updateJumpPowerLabel()
end

local function removeTextures()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:isA("Trail") then
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

local function toggleHoneyDupe()
    isDuping = not isDuping
    honeyDupeButton.Text = isDuping and "Honey Dupe: ON" or "Honey Dupe: OFF"
end

local function closeGUI()
    gui:Destroy()
end

local function minimizeGUI()
    contentFrame.Visible = not contentFrame.Visible
    mainFrame.Size = contentFrame.Visible and UDim2.new(0, 200, 0, 260) or UDim2.new(0, 200, 0, 30)
end

-- Event connections
decreaseSpeedButton.MouseButton1Click:Connect(decreaseSpeed)
increaseSpeedButton.MouseButton1Click:Connect(increaseSpeed)
decreaseJumpPowerButton.MouseButton1Click:Connect(decreaseJumpPower)
increaseJumpPowerButton.MouseButton1Click:Connect(increaseJumpPower)
textureRemoverButton.MouseButton1Click:Connect(removeTextures)
honeyDupeButton.MouseButton1Click:Connect(toggleHoneyDupe)
closeButton.MouseButton1Click:Connect(closeGUI)
minimizeButton.MouseButton1Click:Connect(minimizeGUI)

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

for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        playerAdded(player)
    end
end

game.Players.PlayerAdded:Connect(playerAdded)

-- Main loop
task.spawn(function()
    while true do
        if character and character:FindFirstChild("Humanoid") then
            humanoid = character.Humanoid
            humanoid.WalkSpeed = speedValue
            humanoid.JumpPower = jumpPowerValue
        end
        task.wait(0.1)
    end
end)

-- Honey dupe loop
task.spawn(function()
    while true do
        if isDuping and game.PlaceId == 1537690962 then -- Check if it's Bee Swarm Simulator
            game:GetService("ReplicatedStorage").Events.ClientToServer.ClaimHoneyToken:FireServer(10000)
        end
        task.wait(0.2)
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
