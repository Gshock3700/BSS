-- Load additional scripts
loadstring(game:HttpGet("https://raw.githubusercontent.com/Historia00012/HISTORIAHUB/main/BSS%20FREE"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()

-- Load autofarm functions
local autofarmFunctions = loadstring(game:HttpGet("https://raw.githubusercontent.com/Boxking776/kocmoc/main/games/bss.lua"))()

-- Configuration
local CONFIG = {
    DEFAULT_SPEED = 16,
    DEFAULT_JUMP_POWER = 50,
    GUI_WIDTH = 300,
    GUI_HEIGHT = 400,
    CORNER_RADIUS = UDim.new(0, 10),
    PRIMARY_COLOR = Color3.fromRGB(30, 30, 30),
    SECONDARY_COLOR = Color3.fromRGB(50, 50, 50),
    ACCENT_COLOR = Color3.fromRGB(128, 0, 0), -- Maroon
    TEXT_COLOR = Color3.fromRGB(255, 255, 255),
    BSS_PLACE_ID = 1537690962,
    HONEY_DUPE_INTERVAL = 0.2,
    AUTO_HIT_INTERVAL = 0.2
}

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- Variables
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local speedValue = CONFIG.DEFAULT_SPEED
local jumpPowerValue = CONFIG.DEFAULT_JUMP_POWER
local isDuping = false
local isAutoHitting = false
local isAutoQuesting = false
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
    gui.Name = "SpartaGUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, CONFIG.GUI_WIDTH, 0, CONFIG.GUI_HEIGHT)
    mainFrame.Position = UDim2.new(0.5, -CONFIG.GUI_WIDTH/2, 0.5, -CONFIG.GUI_HEIGHT/2)
    mainFrame.BackgroundColor3 = CONFIG.PRIMARY_COLOR
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = CONFIG.ACCENT_COLOR
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
    titleLabel.Text = "Sparta GUI"
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

    local tabButtons = Instance.new("Frame")
    tabButtons.Name = "TabButtons"
    tabButtons.Size = UDim2.new(1, 0, 0, 30)
    tabButtons.BackgroundTransparency = 1
    tabButtons.Parent = contentFrame

    local mainTabButton = createButton("MainTabButton", UDim2.new(0.25, -5, 1, 0), UDim2.new(0, 0, 0, 0), tabButtons)
    mainTabButton.Text = "Main"

    local farmingTabButton = createButton("FarmingTabButton", UDim2.new(0.25, -5, 1, 0), UDim2.new(0.25, 5, 0, 0), tabButtons)
    farmingTabButton.Text = "Farming"

    local miscTabButton = createButton("MiscTabButton", UDim2.new(0.25, -5, 1, 0), UDim2.new(0.5, 10, 0, 0), tabButtons)
    miscTabButton.Text = "Misc"

    local autofarmTabButton = createButton("AutofarmTabButton", UDim2.new(0.25, -5, 1, 0), UDim2.new(0.75, 15, 0, 0), tabButtons)
    autofarmTabButton.Text = "Autofarm"

    local mainTab = Instance.new("Frame")
    mainTab.Name = "MainTab"
    mainTab.Size = UDim2.new(1, 0, 1, -40)
    mainTab.Position = UDim2.new(0, 0, 0, 40)
    mainTab.BackgroundTransparency = 1
    mainTab.Parent = contentFrame

    local farmingTab = Instance.new("Frame")
    farmingTab.Name = "FarmingTab"
    farmingTab.Size = UDim2.new(1, 0, 1, -40)
    farmingTab.Position = UDim2.new(0, 0, 0, 40)
    farmingTab.BackgroundTransparency = 1
    farmingTab.Visible = false
    farmingTab.Parent = contentFrame

    local miscTab = Instance.new("Frame")
    miscTab.Name = "MiscTab"
    miscTab.Size = UDim2.new(1, 0, 1, -40)
    miscTab.Position = UDim2.new(0, 0, 0, 40)
    miscTab.BackgroundTransparency = 1
    miscTab.Visible = false
    miscTab.Parent = contentFrame

    local autofarmTab = Instance.new("Frame")
    autofarmTab.Name = "AutofarmTab"
    autofarmTab.Size = UDim2.new(1, 0, 1, -40)
    autofarmTab.Position = UDim2.new(0, 0, 0, 40)
    autofarmTab.BackgroundTransparency = 1
    autofarmTab.Visible = false
    autofarmTab.Parent = contentFrame

    local speedLabel = createLabel("SpeedLabel", UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 10), mainTab)
    local jumpPowerLabel = createLabel("JumpPowerLabel", UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 70), mainTab)

    local decreaseSpeedButton = createButton("DecreaseSpeedButton", UDim2.new(0, 50, 0, 30), UDim2.new(0, 0, 0, 35), mainTab)
    decreaseSpeedButton.Text = "-"

    local increaseSpeedButton = createButton("IncreaseSpeedButton", UDim2.new(0, 50, 0, 30), UDim2.new(1, -50, 0, 35), mainTab)
    increaseSpeedButton.Text = "+"

    local decreaseJumpPowerButton = createButton("DecreaseJumpPowerButton", UDim2.new(0, 50, 0, 30), UDim2.new(0, 0, 0, 95), mainTab)
    decreaseJumpPowerButton.Text = "-"

    local increaseJumpPowerButton = createButton("IncreaseJumpPowerButton", UDim2.new(0, 50, 0, 30), UDim2.new(1, -50, 0, 95), mainTab)
    increaseJumpPowerButton.Text = "+"

    local textureRemoverButton = createButton("TextureRemoverButton", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 135), mainTab)
    textureRemoverButton.Text = "Remove Textures"

    local honeyDupeButton = createButton("HoneyDupeButton", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 175), mainTab)
    honeyDupeButton.Text = "Honey Dupe: OFF"

    local autoHitButton = createButton("AutoHitButton", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 215), mainTab)
    autoHitButton.Text = "Auto Hit: OFF"

    local autoQuestButton = createButton("AutoQuestButton", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 255), mainTab)
    autoQuestButton.Text = "Auto Quest: OFF"

    local godModeButton = createButton("GodModeButton", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 295), mainTab)
    godModeButton.Text = "God Mode: OFF"

    local redeemCodesButton = createButton("RedeemCodesButton", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 335), mainTab)
    redeemCodesButton.Text = "Redeem Codes"

    local farmingLabel = createLabel("FarmingLabel", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), farmingTab)
    farmingLabel.Text = "cumming soon dirty nigger yes, you nick ;)"
    farmingLabel.TextSize = 18
    farmingLabel.Font = Enum.Font.SourceSansBold

    -- Add autofarm buttons
    local autofarmButtons = {
        "Honey", "Tokens", "Goo", "Coconuts", "Stingers", "Pineapples",
        "Collect Tokens", "Collect Bubbles", "Farm Sprouts", "Farm Ants",
        "Farm Fireflies", "Farm Snowflakes", "Farm Fuzzy Bombs",
        "Farm Coconuts", "Farm Strawberries", "Farm Pineapples"
    }

    for i, farmType in ipairs(autofarmButtons) do
        local button = createButton(farmType .. "Button", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, (i-1)*35), autofarmTab)
        button.Text = "Autofarm " .. farmType
        button.MouseButton1Click:Connect(function()
            if autofarmFunctions[farmType] then
                autofarmFunctions[farmType]()
            else
                print("Autofarm function for " .. farmType .. " not found.")
            end
        end)
    end

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
        autoQuestButton = autoQuestButton,
        godModeButton = godModeButton,
        redeemCodesButton = redeemCodesButton,
        closeButton = closeButton,
        minimizeButton = minimizeButton,
        mainTabButton = mainTabButton,
        farmingTabButton = farmingTabButton,
        miscTabButton = miscTabButton,
        autofarmTabButton = autofarmTabButton,
        mainTab = mainTab,
        farmingTab = farmingTab,
        miscTab = miscTab,
        autofarmTab = autofarmTab,
        footer = footer
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
    if isAutoHitting then
        local field = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if field then
            -- Plant sprinkler
            local args = {
                [1] = {
                    ["Name"] = "Sprinkler Builder"
                }
            }
            game:GetService("ReplicatedStorage").Events.PlayerActivesCommand:FireServer(unpack(args))
            
            -- Start collecting pollen
            while isAutoHitting do
                local args = {
                    [1] = field.Position
                }
                game:GetService("ReplicatedStorage").Events.PlayerActivesCommand:FireServer(unpack(args))
                wait(0.1)
            end
        end
    end
end

local function toggleAutoQuest(button)
    isAutoQuesting = not isAutoQuesting
    button.Text = isAutoQuesting and "Auto Quest: ON" or "Auto Quest: OFF"
end

local function toggleGodMode(button)
    local godMode = not button.Text:find("ON")
    button.Text = godMode and "God Mode: ON" or "God Mode: OFF"
    if godMode then
        local function onCharacterAdded(char)
            wait(0.5)
            char.Humanoid.MaxHealth = math.huge
            char.Humanoid.Health = math.huge
        end
        player.CharacterAdded:Connect(onCharacterAdded)
        if player.Character then
            onCharacterAdded(player.Character)
        end
    else
        player.CharacterAdded:Connect(function() end)
        if player.Character then
            player.Character.Humanoid.MaxHealth = 100
            player.Character.Humanoid.Health = 100
        end
    end
end

local function redeemCodes()
    local codes = {"Millie", "Teespring", "500mil", "Marshmallow", "Banned", "Codes", "Cog", "Connoisseur", "Crawlers", "Nectar", "Planter", "Roof", "Wax", "Bopmaster", "Buzz", "Clubbean", "Cubly", "Discord100k", "Jumpstart", "Marshmallow", "Millie", "Nectar", "Roof", "Teespring", "Wink", "38217"}
    for _, code in ipairs(codes) do
        ReplicatedStorage.Events.PromoCodeEvent:FireServer(code)
        wait(1)
    end
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
    local esp = Instance.new("BillboardGui")
    esp.Name = player.Name .. "_ESP"
    esp.AlwaysOnTop = true
    esp.Size = UDim2.new(4, 0, 5.5, 0)
    esp.StudsOffset = Vector3.new(0, 3, 0)
    esp.Parent = player.Character.Head

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.new(1, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.Parent = esp

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.25, 0)
    nameLabel.Position = UDim2.new(0, 0, -0.25, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextScaled = true
    nameLabel.Parent = esp

    local healthBar = Instance.new("Frame")
    healthBar.Size = UDim2.new(0.8, 0, 0.1, 0)
    healthBar.Position = UDim2.new(0.1, 0, 1, 0)
    healthBar.BackgroundColor3 = Color3.new(1, 0, 0)
    healthBar.Parent = esp

    local healthFill = Instance.new("Frame")
    healthFill.Size = UDim2.new(1, 0, 1, 0)
    healthFill.BackgroundColor3 = Color3.new(0, 1, 0)
    healthFill.Parent = healthBar

    player.Character.Humanoid.HealthChanged:Connect(function(health)
        healthFill.Size = UDim2.new(health / player.Character.Humanoid.MaxHealth, 0, 1, 0)
    end)
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

-- Auto Quest Function
local function autoQuest()
    local quests = workspace.Quests:GetChildren()
    for _, quest in ipairs(quests) do
        if quest:IsA("Model") and quest:FindFirstChild("QuestPart") then
            local questPart = quest.QuestPart
            local questInfo = questPart:FindFirstChild("QuestInfo")
            if questInfo and questInfo:IsA("StringValue") then
                local questText = questInfo.Value
                local fieldName = questText:match("gather %d+ pollen from (.+)")
                if fieldName then
                    local field = workspace.FlowerZones:FindFirstChild(fieldName)
                    if field then
                        player.Character.HumanoidRootPart.CFrame = field.CFrame + Vector3.new(0, 5, 0)
                        wait(1)
                        -- Simulate gathering pollen
                        local args = {
                            [1] = field.Position
                        }
                        game:GetService("ReplicatedStorage").Events.PlayerActivesCommand:FireServer(unpack(args))
                        wait(5)  -- Wait for 5 seconds before moving to the next quest
                    end
                end
            end
        end
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

    guiElements.autoQuestButton.MouseButton1Click:Connect(function()
        toggleAutoQuest(guiElements.autoQuestButton)
    end)

    guiElements.godModeButton.MouseButton1Click:Connect(function()
        toggleGodMode(guiElements.godModeButton)
    end)

    guiElements.redeemCodesButton.MouseButton1Click:Connect(redeemCodes)

    guiElements.closeButton.MouseButton1Click:Connect(closeGUI)

    guiElements.minimizeButton.MouseButton1Click:Connect(minimizeGUI)

    guiElements.mainTabButton.MouseButton1Click:Connect(function()
        guiElements.mainTab.Visible = true
        guiElements.farmingTab.Visible = false
        guiElements.miscTab.Visible = false
        guiElements.autofarmTab.Visible = false
    end)

    guiElements.farmingTabButton.MouseButton1Click:Connect(function()
        guiElements.mainTab.Visible = false
        guiElements.farmingTab.Visible = true
        guiElements.miscTab.Visible = false
        guiElements.autofarmTab.Visible = false
    end)

    guiElements.miscTabButton.MouseButton1Click:Connect(function()
        guiElements.mainTab.Visible = false
        guiElements.farmingTab.Visible = false
        guiElements.miscTab.Visible = true
        guiElements.autofarmTab.Visible = false
    end)

    guiElements.autofarmTabButton.MouseButton1Click:Connect(function()
        guiElements.mainTab.Visible = false
        guiElements.farmingTab.Visible = false
        guiElements.miscTab.Visible = false
        guiElements.autofarmTab.Visible = true
    end)

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

        if isAutoQuesting then
            autoQuest()
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

    -- Increase bee damage
    local beeModule = require(game:GetService("ReplicatedStorage").BeeTypes)
    for _, beeData in pairs(beeModule) do
        if beeData.Attack then
            beeData.Attack *= 20
        end
    end

    -- Remove tool cooldown
    local playerScripts = player:WaitForChild("PlayerScripts")
    local toolHandler = playerScripts:WaitForChild("ToolHandler")
    local cooldownScript = toolHandler:FindFirstChild("Cooldown")
    if cooldownScript then
        cooldownScript:Destroy()
    end
end

-- Run the script
init()
