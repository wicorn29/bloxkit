--BloxKit by Wicorn29 (https://github.com/wicorn29/bloxkit)



loadstring(game:HttpGet('https://raw.githubusercontent.com/wicorn29/bloxkit/refs/heads/main/scripts/antikick.lua'))()
-- BloxKit's Built-in anti kick script. (Better to be safe than sorry.)






--!strict
local CoreGui           = game:GetService("CoreGui")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name               = "ExQuitHotbarGui"
screenGui.ResetOnSpawn       = false
screenGui.IgnoreGuiInset     = true
screenGui.DisplayOrder       = 999999
screenGui.ZIndexBehavior     = Enum.ZIndexBehavior.Global
screenGui.Parent             = CoreGui

-- Main Window
local mainFrame = Instance.new("Frame")
mainFrame.Name         = "MainFrame"
mainFrame.Size         = UDim2.new(0, 400, 0, 380)
mainFrame.Position     = UDim2.new(0.5, -200, 0.5, -190)
mainFrame.AnchorPoint  = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel   = 0
mainFrame.ZIndex            = 10
mainFrame.Parent            = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Header
local header = Instance.new("Frame")
header.Size             = UDim2.new(1, 0, 0, 40)
header.Position         = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
header.BorderSizePixel  = 0
header.ZIndex           = 11
header.Parent           = mainFrame

Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local titleLabel = Instance.new("TextLabel")
titleLabel.Text             = "BloxKit by Wicorn29"
titleLabel.Size             = UDim2.new(1, -40, 1, 0)
titleLabel.Position         = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3       = Color3.fromRGB(255, 255, 255)
titleLabel.TextXAlignment   = Enum.TextXAlignment.Left
titleLabel.Font             = Enum.Font.GothamBold
titleLabel.TextSize         = 18
titleLabel.ZIndex           = 12
titleLabel.Parent           = header

local closeButton = Instance.new("TextButton")
closeButton.Text             = "x"
closeButton.Size             = UDim2.new(0, 30, 1, 0)
closeButton.Position         = UDim2.new(1, -35, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeButton.TextColor3       = Color3.fromRGB(255, 255, 255)
closeButton.Font             = Enum.Font.GothamBold
closeButton.TextSize         = 18
closeButton.ZIndex           = 12
closeButton.Parent           = header

Instance.new("UICorner", closeButton).CornerRadius = UDim.new(1, 0)

-- Search Box
local searchBox = Instance.new("TextBox")
searchBox.PlaceholderText    = "Search..."
searchBox.Text               = ""
searchBox.Size               = UDim2.new(1, -20, 0, 30)
searchBox.Position           = UDim2.new(0, 10, 0, 50)
searchBox.BackgroundColor3   = Color3.fromRGB(50, 50, 50)
searchBox.TextColor3         = Color3.fromRGB(255, 255, 255)
searchBox.ClearTextOnFocus   = false
searchBox.Font               = Enum.Font.Gotham
searchBox.TextSize           = 14
searchBox.ZIndex             = 11
searchBox.TextXAlignment     = Enum.TextXAlignment.Left
searchBox.Parent             = mainFrame

Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 6)

-- List Container
local listFrame = Instance.new("Frame")
listFrame.Position       = UDim2.new(0.5, -200, 0.5, -90)
listFrame.Size           = UDim2.new(1, 0, 1, -90)
listFrame.BackgroundTransparency = 1
listFrame.ZIndex         = 10
listFrame.Parent         = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding    = UDim.new(0, 6)
layout.SortOrder  = Enum.SortOrder.LayoutOrder
layout.Parent     = listFrame

-- Your script list
local scriptList = {
    {
        Name = "Inf Yield",
        Description = "The one and only",
        Content = [[
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()

        ]]
    },
    {
        Name = "TPUA",
        Description = "Turn people into black holes",
        Content = [[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Bac0nHck/Scripts/main/BringFlingPlayers"))("More Scripts: t.me/arceusxscripts")
        ]]
    },
    {
        Name = "Hello World",
        Description = "Prints hello in log (used in debugging of bloxkit)",
        Content = [[
            print("Hello!")
        ]]
    }
}

-- Render Buttons
local buttons = {}
local function renderScripts(filterText: string?)
    for _, btn in pairs(buttons) do btn:Destroy() end
    table.clear(buttons)

    for _, entry in ipairs(scriptList) do
        local nameLower = entry.Name:lower()
        local descLower = entry.Description:lower()
        if not filterText
           or nameLower:find(filterText:lower())
           or descLower:find(filterText:lower()) then

            local btn = Instance.new("TextButton")
            btn.Size             = UDim2.new(1, -20, 0, 40)
            btn.Position         = UDim2.new(0, 10, 0, 0)
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            btn.TextColor3       = Color3.new(1, 1, 1)
            btn.Font             = Enum.Font.Gotham
            btn.TextSize         = 14
            btn.TextWrapped      = true
            btn.Text             = entry.Name .. " – " .. entry.Description
            btn.ZIndex           = 11
            btn.Parent           = listFrame

            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

            btn.MouseButton1Click:Connect(function()
                pcall(function() loadstring(entry.Content)() end)
            end)

            table.insert(buttons, btn)
        end
    end
end

renderScripts()
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    renderScripts(searchBox.Text)
end)

-- Branding Text
local brandingText = Instance.new("TextLabel")
brandingText.Text = "BloxKit by Wicorn29"
brandingText.Size = UDim2.new(1, -40, 0, 30)
brandingText.Position = UDim2.new(0, 10, 1, -40)
brandingText.BackgroundTransparency = 1
brandingText.TextColor3 = Color3.fromRGB(255, 255, 255)
brandingText.TextXAlignment = Enum.TextXAlignment.Center
brandingText.Font = Enum.Font.Gotham
brandingText.TextSize = 14
brandingText.ZIndex = 12
brandingText.Parent = mainFrame

-- Close: fade out everything but MainFrame
closeButton.MouseButton1Click:Connect(function()
    -- collect all UI objects except for the mainFrame
    local toFade = {}
    for _, obj in ipairs(mainFrame:GetDescendants()) do
        if obj:IsA("GuiObject") and obj ~= mainFrame then
            table.insert(toFade, obj)
        end
    end

    -- tween all transparency props to 1 for each UI element
    for _, obj in ipairs(toFade) do
        local props = {}
        -- Background
        if obj.BackgroundTransparency ~= nil then
            props.BackgroundTransparency = 1
        end
        -- Text
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            props.TextTransparency = 1
        end
        -- Images (if any)
        if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
            props.ImageTransparency = 1
        end

        if next(props) then
            TweenService:Create(obj, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
        end
    end

    -- Wait 0.1 seconds, then quickly fade MainFrame to white
    task.wait(0.1)
    
    -- Add "Enjoy your game :)" text
    local finalText = Instance.new("TextLabel")
    finalText.Text = "Enjoy your game :)"
    finalText.Size = UDim2.new(1, -40, 0, 40)
    finalText.Position = UDim2.new(0, 20, 0.5, -20)
    finalText.BackgroundTransparency = 1
    finalText.TextColor3 = Color3.fromRGB(0, 0, 0)
    finalText.Font = Enum.Font.GothamBold
    finalText.TextSize = 24
    finalText.TextTransparency = 1
    finalText.ZIndex = 12
    finalText.Parent = mainFrame

    -- Fade main frame to white and text fades in
    TweenService:Create(mainFrame, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
    
    TweenService:Create(finalText, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()

    -- Wait 3 seconds, then fade MainFrame back to transparency
    task.wait(3)
    
    -- Fade MainFrame to transparent over 2 seconds
    TweenService:Create(mainFrame, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()

    -- Wait for fade to complete, then close
    task.wait(2)
    screenGui:Destroy()
end)

-- Draggable
local dragging, dragStart, startPos = false, nil, nil
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
