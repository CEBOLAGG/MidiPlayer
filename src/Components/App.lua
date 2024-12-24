-- App
-- 0866
-- December 24, 2024



local App = {}

local CoreGui = game:GetService("CoreGui")

local midiPlayer = script:FindFirstAncestor("MidiPlayer")

local FastDraggable = require(midiPlayer.FastDraggable)
local Controller = require(midiPlayer.Components.Controller)
local Sidebar = require(midiPlayer.Components.Sidebar)
local Preview = require(midiPlayer.Components.Preview)

local gui = midiPlayer.Assets.ScreenGui


function App:GetGUI()
    return gui
end


function App:Init()

    FastDraggable(gui.Frame, gui.Frame.Handle, gui.Frame.ResizeHandle)
    gui.Parent = CoreGui

    Controller:Init(gui.Frame)
    Sidebar:Init(gui.Frame)
    Preview:Init(gui.Frame)

end


return App
