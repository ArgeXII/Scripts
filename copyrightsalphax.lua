-- Function to make a GUI element draggable
local function makeDraggable(guiElement)
    local dragging
    local dragInput
    local dragStart
    local startPos

    -- Function to handle when the mouse button is pressed over the GUI
    local function onDragStart(input)
        dragStart = input.Position
        startPos = guiElement.Position

        -- Connect mouse moved event
        dragging = true
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end

    -- Function to handle when the mouse is moved
    local function onDragMove(input)
        if dragging then
            dragInput = input
            local delta = input.Position - dragStart
            guiElement.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end

    -- Connect mouse events
    guiElement.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            onDragStart(input)
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            onDragMove(input)
        end
    end)
end

-- Make the window draggable
makeDraggable(Window)
