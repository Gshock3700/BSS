-- Load the original script
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Historia00012/HISTORIAHUB/main/BSS%20FREE"))()
end)

-- Variables
local speedValue = 16 -- Default speed value
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "SpeedFrame"
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Parent = gui

local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(0, 180, 0, 30)
speedLabel.Position = UDim2.new(0, 10, 0, 10)
speedLabel.BackgroundColor3 = Color3.new(0, 0, 0)
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.TextSize = 18
speedLabel.Text = "Speed: " .. speedValue
speedLabel.Parent = frame

local decreaseButton = Instance.new("TextButton")
decreaseButton.Name = "DecreaseButton"
decreaseButton.Size = UDim2.new(0, 50, 0, 30)
decreaseButton.Position = UDim2.new(0, 10, 0, 50)
decreaseButton.BackgroundColor3 = Color3.new(0, 1, 0)
decreaseButton.TextColor3 = Color3.new(1, 1, 1)
decreaseButton.TextSize = 14
decreaseButton.Text = "-"
decreaseButton.Parent = frame

local increaseButton = Instance.new("TextButton")
increaseButton.Name = "IncreaseButton"
increaseButton.Size = UDim2.new(0, 50, 0, 30)
increaseButton.Position = UDim2.new(0, 140, 0, 50)
increaseButton.BackgroundColor3 = Color3.new(0, 1, 0)
increaseButton.TextColor3 = Color3.new(1, 1, 1)
increaseButton.TextSize = 14
increaseButton.Text = "+"
increaseButton.Parent = frame

local textureRemoverButton = Instance.new("TextButton")
textureRemoverButton.Name = "TextureRemoverButton"
textureRemoverButton.Size = UDim2.new(0, 180, 0, 30)
textureRemoverButton.Position = UDim2.new(0, 10, 0, 90)
textureRemoverButton.BackgroundColor3 = Color3.new(0, 1, 0)
textureRemoverButton.TextColor3 = Color3.new(1, 1, 1)
textureRemoverButton.TextSize = 14
textureRemoverButton.Text = "Remove Textures"
textureRemoverButton.Parent = frame

-- Functions
local function updateSpeedLabel()
    speedLabel.Text = "Speed: " .. speedValue
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

-- Event connections
decreaseButton.MouseButton1Click:Connect(decreaseSpeed)
increaseButton.MouseButton1Click:Connect(increaseSpeed)
textureRemoverButton.MouseButton1Click:Connect(removeTextures)

-- Lag reducer and FPS increaser
settings().Rendering.QualityLevel = 1
settings().Physics.PhysicsEnvironmentalThrottle = 1
settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
game:GetService("Lighting").GlobalShadows = false
game:GetService("Lighting").FogEnd = 9e9

-- Main loop
task.spawn(function()
    while true do
        if humanoid then
            humanoid.WalkSpeed = speedValue
        end
        task.wait(0.1)
    end
end)

-- Anti-AFK
local virtualUser = game:GetService("VirtualUser")
player.Idled:Connect(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
end)
