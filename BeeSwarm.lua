local script = [[
local speedValue = 16

local gui = Instance.new("ScreenGui")
gui.Name = "SpeedGUI"
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "SpeedFrame"
frame.Size = UDim2.new(0, 200, 0, 100)
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

local function updateSpeedLabel()
    speedLabel.Text = "Speed: " .. speedValue
end

local function adjustSpeed(delta)
    speedValue = math.max(1, speedValue + delta)
    updateSpeedLabel()
end

decreaseButton.MouseButton1Click:Connect(function() adjustSpeed(-1) end)
increaseButton.MouseButton1Click:Connect(function() adjustSpeed(1) end)

spawn(function()
    while true do
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = speedValue
        end
        wait(0.1)
    end
end)

game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

local config = {
    FFlagDebugDisableOTAMaterialTexture = "true",
    FFlagMSRefactor5 = "false",
    FStringPartTexturePackTablePre2022 = '{"foil":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[255,255,255,255]},"brick":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[204,201,200,232]},"cobblestone":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[212,200,187,250]},"concrete":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[208,208,208,255]},"diamondplate":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[170,170,170,255]},"fabric":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[105,104,102,244]},"glass":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[254,254,254,7]},"granite":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[113,113,113,255]},"grass":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[165,165,159,255]},"ice":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[255,255,255,255]},"marble":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[199,199,199,255]},"metal":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[199,199,199,255]},"pebble":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[208,208,208,255]},"corrodedmetal":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[159,119,95,200]},"sand":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[220,220,220,255]},"slate":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[193,193,193,255]},"wood":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[227,227,227,255]},"woodplanks":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[212,209,203,255]},"asphalt":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[123,123,123,234]},"basalt":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[154,154,153,238]},"crackedlava":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[74,78,80,156]},"glacier":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[226,229,229,243]},"ground":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[114,114,112,240]},"leafygrass":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[121,117,113,234]},"limestone":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[235,234,230,250]},"mud":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[130,130,130,252]},"pavement":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[142,142,144,236]},"rock":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[154,154,154,248]},"salt":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[220,220,221,255]},"sandstone":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[174,171,169,246]},"snow":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[218,218,218,255]}}',
    FStringPartTexturePackTable2022 = '{"foil":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[255,255,255,255]},"brick":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[204,201,200,232]},"cobblestone":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[212,200,187,250]},"concrete":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[208,208,208,255]},"diamondplate":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[170,170,170,255]},"fabric":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[105,104,102,244]},"glass":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[254,254,254,7]},"granite":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[113,113,113,255]},"grass":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[165,165,159,255]},"ice":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[255,255,255,255]},"marble":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[199,199,199,255]},"metal":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[199,199,199,255]},"pebble":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[208,208,208,255]},"corrodedmetal":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[159,119,95,200]},"sand":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[220,220,220,255]},"slate":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[193,193,193,255]},"wood":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[227,227,227,255]},"woodplanks":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[212,209,203,255]},"asphalt":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[123,123,123,234]},"basalt":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[154,154,153,238]},"crackedlava":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[74,78,80,156]},"glacier":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[226,229,229,243]},"ground":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[114,114,112,240]},"leafygrass":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[121,117,113,234]},"limestone":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[235,234,230,250]},"mud":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[130,130,130,252]},"pavement":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[142,142,144,236]},"rock":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[154,154,154,248]},"salt":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[220,220,221,255]},"sandstone":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[174,171,169,246]},"snow":{"ids":["rbxassetid://0","rbxassetid://0"],"color":[218,218,218,255]}}'
}

for key, value in pairs(config) do
    if type(value) == "string" then
        game:GetService("RunService"):SetFastFlag(key, value)
    end
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/Historia00012/HISTORIAHUB/main/BSS%20FREE"))()
]]

loadstring(script)()
