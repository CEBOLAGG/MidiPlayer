local UserInputService = game:GetService("UserInputService")

local function FastDraggable(gui, handle, resizeHandle)
    handle = handle or gui

    local dragging
    local dragInput
    local dragStart
    local startPos

    local resizing
    local resizeStart
    local startSize

    local function updateDrag(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    local function updateResize(input)
        local delta = input.Position - resizeStart
        local newWidth = math.max(100, startSize.X.Offset + delta.X)
        local newHeight = math.max(100, startSize.Y.Offset + delta.Y)
        gui.Size = UDim2.new(
            startSize.X.Scale, newWidth,
            startSize.Y.Scale, newHeight
        )
    end

    -- Dragging functionality
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDrag(input)
        end
    end)

    -- Resizing functionality
    if resizeHandle then
        resizeHandle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = true
                resizeStart = input.Position
                startSize = gui.Size

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        resizing = false
                    end
                end)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
                updateResize(input)
            end
        end)
    end

    -- Toggle visibility
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.RightAlt then
            if gui.Visible then
                gui.Visible = false
            else
                gui.Visible = true
            end
        end
    end)
end

return FastDraggable
