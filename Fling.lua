-- 🎮 JIMHUB | Troll Fling Script
if _G.JimHubFling then return end
_G.JimHubFling = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Character, Root, Humanoid

local Settings = {
    TargetPlayer = nil,
    Power = 800,
    AutoMode = false,
    Active = false
}

local function UpdateChar()
    Character = Player.Character
    if Character then
        Root = Character:FindFirstChild("HumanoidRootPart")
        Humanoid = Character:FindFirstChild("Humanoid")
    end
end
UpdateChar()
Player.CharacterAdded:Connect(UpdateChar)

local function FlingTarget(TargetChar)
    if not Root or not TargetChar then return end
    local TargetRoot = TargetChar:FindFirstChild("HumanoidRootPart")
    if not TargetRoot then return end
    
    local BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    BodyVelocity.Velocity = (TargetRoot.Position - Root.Position).Unit * Settings.Power + Vector3.new(0, Settings.Power * 0.6, 0)
    BodyVelocity.Parent = TargetRoot
    
    task.delay(0.3, function()
        if BodyVelocity then BodyVelocity:Destroy() end
    end)
end

-- Fling saat klik pemain
Mouse.Button1Down:Connect(function()
    if not Settings.Active or not Mouse.Target then return end
    local TargetPlayer = Players:GetPlayerFromCharacter(Mouse.Target.Parent)
    if TargetPlayer and TargetPlayer ~= Player then
        FlingTarget(TargetPlayer.Character)
    end
end)

-- Auto Fling semua pemain
task.spawn(function()
    while task.wait(0.5) and _G.JimHubFling do
        if Settings.Active and Settings.AutoMode then
            for _,v in pairs(Players:GetPlayers()) do
                if v ~= Player and v.Character then
                    FlingTarget(v.Character)
                end
            end
        end
    end
end)

-- ==== UI JIMHUB ====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JimHubFling"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 320)
MainFrame.Position = UDim2.new(0.02, 0, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(70, 70, 70)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Title.Text = "🎮 JIMHUB — TROLL FLING"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

local function Button(Name, Pos, Callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 40)
    Btn.Position = UDim2.new(0.05, 0, 0, Pos)
    Btn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    Btn.Text = Name
    Btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.Parent = MainFrame
    Btn.MouseButton1Click:Connect(Callback)
    return Btn
end

local b1 = Button("🔘 Fling: OFF", 60, function()
    Settings.Active = not Settings.Active
    b1.Text = Settings.Active and "🟢 Fling: ON (Klik Pemain)" or "🔘 Fling: OFF"
end)

local b2 = Button("🔘 Auto Fling: OFF", 110, function()
    Settings.AutoMode = not Settings.AutoMode
    b2.Text = Settings.AutoMode and "🟢 Auto Fling: ON" or "🔘 Auto Fling: OFF"
end)

local Info1 = Instance.new("TextLabel")
Info1.Size = UDim2.new(0.9, 0, 0, 25)
Info1.Position = UDim2.new(0.05, 0, 0, 170)
Info1.BackgroundTransparency = 1
Info1.Text = "Klik pemain untuk melemparnya!"
Info1.TextColor3 = Color3.fromRGB(80, 80, 80)
Info1.Font = Enum.Font.Gotham
Info1.TextSize = 11
Info1.Parent = MainFrame

local Info2 = Instance.new("TextLabel")
Info2.Size = UDim2.new(0.9, 0, 0, 25)
Info2.Position = UDim2.new(0.05, 0, 0, 200)
Info2.BackgroundTransparency = 1
Info2.Text = "Power: 800 | Bisa diubah di kode"
Info2.TextColor3 = Color3.fromRGB(80, 80, 80)
Info2.Font = Enum.Font.Gotham
Info2.TextSize = 11
Info2.Parent = MainFrame

local b3 = Button("❌ Tutup", 240, function()
    _G.JimHubFling = false
    ScreenGui:Destroy()
end)
