-- 🎮 JIMHUB | Steal An Egg Script
if _G.JimHub then return end
_G.JimHub = true

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local Character,Root,Humanoid

local function UpdateChar()
    Character = Player.Character
    if Character then
        Root = Character:FindFirstChild("HumanoidRootPart")
        Humanoid = Character:FindFirstChild("Humanoid")
    end
end
UpdateChar()
Player.CharacterAdded:Connect(UpdateChar)

local Settings = {AutoSteal=false,ESP=false,Speed=16}

task.spawn(function()
    while task.wait(0.3) and _G.JimHub do
        if Settings.AutoSteal and Root then
            for _,v in pairs(workspace:GetChildren()) do
                if v:IsA("BasePart") and (string.find(string.lower(v.Name),"egg") or string.find(string.lower(v.Name),"telur")) then
                    Root.CFrame = CFrame.new(v.Position+Vector3.new(0,3,0))
                    task.wait(0.15)
                end
            end
        end
    end
end)

local function AddESP(part)
    if part:FindFirstChild("ESP_JimHub") then return end
    local esp = Instance.new("BillboardGui")
    esp.Name = "ESP_JimHub"
    esp.AlwaysOnTop = true
    esp.Size = UDim2.new(0,60,0,30)
    esp.Parent = part
    local txt = Instance.new("TextLabel")
    txt.BackgroundTransparency = 1
    txt.Text = "🥚 TELUR"
    txt.TextColor3 = Color3.fromRGB(255,215,0)
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 14
    txt.Size = UDim2.new(1,0,1,0)
    txt.Parent = esp
end

task.spawn(function()
    while task.wait(1) and _G.JimHub do
        if Settings.ESP then
            for _,v in pairs(workspace:GetChildren()) do
                if v:IsA("BasePart") and (string.find(string.lower(v.Name),"egg") or string.find(string.lower(v.Name),"telur")) then
                    AddESP(v)
                end
            end
        end
    end
end)

UIS.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.LeftShift and Humanoid then
        Humanoid.WalkSpeed = 50
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.LeftShift and Humanoid then
        Humanoid.WalkSpeed = 16
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JimHub"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0,260,0,340)
MainFrame.Position = UDim2.new(0.02,0,0.5,-170)
MainFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(80,80,80)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundColor3 = Color3.fromRGB(60,60,60)
Title.Text = "🎮 JIMHUB"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

local function Button(nama,pos,fungsi)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9,0,0,35)
    btn.Position = UDim2.new(0.05,0,0,pos)
    btn.BackgroundColor3 = Color3.fromRGB(230,230,230)
    btn.Text = nama
    btn.TextColor3 = Color3.fromRGB(0,0,0)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.Parent = MainFrame
    btn.MouseButton1Click:Connect(fungsi)
    return btn
end

local b1 = Button("🔘 Auto Steal: OFF",50,function()
    Settings.AutoSteal = not Settings.AutoSteal
    b1.Text = Settings.AutoSteal and "🟢 Auto Steal: ON" or "🔘 Auto Steal: OFF"
end)

local b2 = Button("🔘 ESP Telur: OFF",95,function()
    Settings.ESP = not Settings.ESP
    b2.Text = Settings.ESP and "🟢 ESP Telur: ON" or "🔘 ESP Telur: OFF"
end)

local b3 = Button("⚡ Speed Boost",140,function()
    if Humanoid then
        Humanoid.WalkSpeed = 50
        task.wait(3)
        Humanoid.WalkSpeed = 16
    end
end)

local b4 = Button("📍 Teleport Telur",185,function()
    if Root then
        for _,v in pairs(workspace:GetChildren()) do
            if v:IsA("BasePart") and (string.find(string.lower(v.Name),"egg") or string.find(string.lower(v.Name),"telur")) then
                Root.CFrame = CFrame.new(v.Position+Vector3.new(0,3,0))
                break
            end
        end
    end
end)

local b5 = Button("❌ Close",230,function()
    _G.JimHub = false
    ScreenGui:Destroy()
end)

local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(0.9,0,0,25)
Info.Position = UDim2.new(0.05,0,0,280)
Info.BackgroundTransparency = 1
Info.Text = "⚠️ JimHub — Gunakan Risiko Sendiri"
Info.TextColor3 = Color3.fromRGB(150,150,150)
Info.Font = Enum.Font.Gotham
Info.TextSize = 11
Info.Parent = MainFrame
