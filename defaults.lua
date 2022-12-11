--[[
        Copyright © 2020, SirEdeonX, Akirane, Technyze
        All rights reserved.

        Redistribution and use in source and binary forms, with or without
        modification, are permitted provided that the following conditions are met:

            * Redistributions of source code must retain the above copyright
              notice, this list of conditions and the following disclaimer.
            * Redistributions in binary form must reproduce the above copyright
              notice, this list of conditions and the following disclaimer in the
              documentation and/or other materials provided with the distribution.
            * Neither the name of xivhotbar nor the
              names of its contributors may be used to endorse or promote products
              derived from this software without specific prior written permission.

        THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
        ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
        WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
        DISCLAIMED. IN NO EVENT SHALL SirEdeonX OR Akirane BE LIABLE FOR ANY
        DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
        (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
        LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
        ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
        (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
        SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

local defaults = {}


defaults.General = {}
defaults.General.HideEnvironment = false 
defaults.General.HideInventoryCount = false
defaults.General.EnableWeaponSwitching = false
defaults.General.HideHotbarNumbers = false


defaults.Hotbar = {}
defaults.Hotbar.ShowActionDescription = true
defaults.Hotbar.HideEmptySlots = true
defaults.Hotbar.HideActionName = false
defaults.Hotbar.HideActionCost = true





defaults.Hotbar.Offsets = {}
defaults.Hotbar.Offsets.First  = { Vertical = false, OffsetX = 675, OffsetY = 1010 }
defaults.Hotbar.Offsets.Second = { Vertical = false, OffsetX = 675, OffsetY = 956 }
defaults.Hotbar.Offsets.Third  = { Vertical = false, OffsetX = 675, OffsetY = 902 }
defaults.Hotbar.Offsets.Fourth = { Vertical = false, OffsetX = 675, OffsetY = 848 }
defaults.Hotbar.Offsets.Fifth  = { Vertical = true, OffsetX = 1380, OffsetY = 740 }
defaults.Hotbar.Offsets.Sixth  = { Vertical = true, OffsetX = 1490, OffsetY = 740 }

defaults.Hotbar.Theme = {}
defaults.Hotbar.Theme.Slot = 'ffxiv'
defaults.Hotbar.Theme.Frame = 'ffxiv'

defaults.Hotbar.Style = {}
defaults.Hotbar.Style.HotbarCount = 6
defaults.Hotbar.Style.HotbarLength = 12
defaults.Hotbar.Style.SlotIconScale = 1
defaults.Hotbar.Style.SlotAlpha = 100
defaults.Hotbar.Style.SlotSpacing = 14
defaults.Hotbar.Style.HotbarSpacing = 56
defaults.Hotbar.Style.OffsetX = 0
defaults.Hotbar.Style.OffsetY = 0

defaults.Hotbar.Misc = {}
defaults.Hotbar.Misc.Feedback = {}
defaults.Hotbar.Misc.Feedback.Opacity = 150
defaults.Hotbar.Misc.Feedback.Speed = 30
defaults.Hotbar.Misc.Disabled = {}
defaults.Hotbar.Misc.Disabled.Opacity = 50

-- Texts [Base]
defaults.Texts = {}

-- Action Name
defaults.Texts.ActionName = {}
defaults.Texts.ActionName.Font = 'Calibri'
defaults.Texts.ActionName.Size = 10
defaults.Texts.ActionName.Pos = {}
defaults.Texts.ActionName.Pos.OffsetX = -1
defaults.Texts.ActionName.Pos.OffsetY = 37
defaults.Texts.ActionName.Color = {}
defaults.Texts.ActionName.Color.Alpha = 255
defaults.Texts.ActionName.Color.Red = 255
defaults.Texts.ActionName.Color.Green = 255
defaults.Texts.ActionName.Color.Blue = 255
defaults.Texts.ActionName.Stroke = {}
defaults.Texts.ActionName.Stroke.Width = 2
defaults.Texts.ActionName.Stroke.Alpha = 200
defaults.Texts.ActionName.Stroke.Red = 20
defaults.Texts.ActionName.Stroke.Green = 20
defaults.Texts.ActionName.Stroke.Blue = 20
defaults.Texts.ActionName.Background = {}
defaults.Texts.ActionName.Background.Enable = false
defaults.Texts.ActionName.Background.Opacity = 100

-- Keys
defaults.Texts.Keys = {}
defaults.Texts.Keys.Font = 'Calibri'
defaults.Texts.Keys.Size = 9
defaults.Texts.Keys.Pos = {}
defaults.Texts.Keys.Pos.OffsetX = -1
defaults.Texts.Keys.Pos.OffsetY = -4
defaults.Texts.Keys.Color = {}
defaults.Texts.Keys.Color.Alpha = 255
defaults.Texts.Keys.Color.Red = 255
defaults.Texts.Keys.Color.Green = 255
defaults.Texts.Keys.Color.Blue = 255
defaults.Texts.Keys.Stroke = {}
defaults.Texts.Keys.Stroke.Width = 2
defaults.Texts.Keys.Stroke.Alpha = 200
defaults.Texts.Keys.Stroke.Red = 20
defaults.Texts.Keys.Stroke.Green = 20
defaults.Texts.Keys.Stroke.Blue = 20

-- Costs
defaults.Texts.Costs = {}
defaults.Texts.Costs.Font = 'Calibri'
defaults.Texts.Costs.Size = 10
defaults.Texts.Costs.Pos = {}
defaults.Texts.Costs.Pos.OffsetX = 1
defaults.Texts.Costs.Pos.OffsetY = 24
defaults.Texts.Costs.Color = {}
defaults.Texts.Costs.Color.Alpha = 255
defaults.Texts.Costs.Color.Red = 0
defaults.Texts.Costs.Color.Green = 240
defaults.Texts.Costs.Color.Blue = 120
defaults.Texts.Costs.Stroke = {}
defaults.Texts.Costs.Stroke.Width = 2
defaults.Texts.Costs.Stroke.Alpha = 200
defaults.Texts.Costs.Stroke.Red = 20
defaults.Texts.Costs.Stroke.Green = 20
defaults.Texts.Costs.Stroke.Blue = 20

-- Recasts
defaults.Texts.Recasts = {}
defaults.Texts.Recasts.Font = 'Calibri'
defaults.Texts.Recasts.Size = 9
defaults.Texts.Recasts.Pos = {}
defaults.Texts.Recasts.Pos.OffsetX = -1
defaults.Texts.Recasts.Pos.OffsetY = -4
defaults.Texts.Recasts.Color = {}
defaults.Texts.Recasts.Color.Alpha = 255
defaults.Texts.Recasts.Color.Red = 100
defaults.Texts.Recasts.Color.Green = 200
defaults.Texts.Recasts.Color.Blue = 255
defaults.Texts.Recasts.Stroke = {}
defaults.Texts.Recasts.Stroke.Width = 2
defaults.Texts.Recasts.Stroke.Alpha = 200
defaults.Texts.Recasts.Stroke.Red = 20
defaults.Texts.Recasts.Stroke.Green = 20
defaults.Texts.Recasts.Stroke.Blue = 20


-- Hotbar Numbers
defaults.Texts.HotbarNumbers = {}
defaults.Texts.HotbarNumbers.Font = 'Calibri'
defaults.Texts.HotbarNumbers.Size = 13
defaults.Texts.HotbarNumbers.Italics = true
defaults.Texts.HotbarNumbers.Pos = {}
defaults.Texts.HotbarNumbers.Pos.OffsetX = -20
defaults.Texts.HotbarNumbers.Pos.OffsetY = 9
defaults.Texts.HotbarNumbers.Pos.VertOffsetX = 42
defaults.Texts.HotbarNumbers.Pos.VertOffsetY = -30
defaults.Texts.HotbarNumbers.Color = {}
defaults.Texts.HotbarNumbers.Color.Alpha = 255
defaults.Texts.HotbarNumbers.Color.Red = 200
defaults.Texts.HotbarNumbers.Color.Green = 200
defaults.Texts.HotbarNumbers.Color.Blue = 200
defaults.Texts.HotbarNumbers.Stroke = {}
defaults.Texts.HotbarNumbers.Stroke.Width = 2
defaults.Texts.HotbarNumbers.Stroke.Alpha = 200
defaults.Texts.HotbarNumbers.Stroke.Red = 20
defaults.Texts.HotbarNumbers.Stroke.Green = 20
defaults.Texts.HotbarNumbers.Stroke.Blue = 20

-- Environment Numbers
defaults.Texts.Environment = {}
defaults.Texts.Environment.BattleText = 'Main'
defaults.Texts.Environment.FieldText = 'General'
defaults.Texts.Environment.Pos = {}
defaults.Texts.Environment.Pos.HookOntoBar = 1
defaults.Texts.Environment.Pos.PosX = 0
defaults.Texts.Environment.Pos.PosY = 0
defaults.Texts.Environment.Pos.OffsetX = 0
defaults.Texts.Environment.Pos.OffsetY = 17
defaults.Texts.Environment.Pos.HookOffsetX = -8
defaults.Texts.Environment.Pos.HookOffsetY = 0
defaults.Texts.Environment.Italics = true
defaults.Texts.Environment.Font = 'Calibri'
defaults.Texts.Environment.Size = 12
defaults.Texts.Environment.Color = {}
defaults.Texts.Environment.Color.Alpha = 255
defaults.Texts.Environment.Color.Red = 255
defaults.Texts.Environment.Color.Green = 255
defaults.Texts.Environment.Color.Blue = 255
defaults.Texts.Environment.Stroke = {}
defaults.Texts.Environment.Stroke.Width = 2
defaults.Texts.Environment.Stroke.Alpha = 200
defaults.Texts.Environment.Stroke.Red = 20
defaults.Texts.Environment.Stroke.Green = 20
defaults.Texts.Environment.Stroke.Blue = 20


-- Inventory
defaults.Texts.Inventory = {}
defaults.Texts.Inventory.Pos = {}
defaults.Texts.Inventory.Pos.Unlock = false
defaults.Texts.Inventory.Pos.PosX = 1135
defaults.Texts.Inventory.Pos.PosY = 820
defaults.Texts.Inventory.Pos.OffsetX = -8
defaults.Texts.Inventory.Pos.OffsetY = 36
defaults.Texts.Inventory.Italics = true
defaults.Texts.Inventory.Font = 'Calibri'
defaults.Texts.Inventory.Size = 11
defaults.Texts.Inventory.Color = {}
defaults.Texts.Inventory.Color.Alpha = 255
defaults.Texts.Inventory.Color.Red = 255
defaults.Texts.Inventory.Color.Green = 255
defaults.Texts.Inventory.Color.Blue = 255
defaults.Texts.Inventory.Stroke = {}
defaults.Texts.Inventory.Stroke.Width = 2
defaults.Texts.Inventory.Stroke.Alpha = 200
defaults.Texts.Inventory.Stroke.Red = 20
defaults.Texts.Inventory.Stroke.Green = 20
defaults.Texts.Inventory.Stroke.Blue = 20
defaults.Texts.Inventory.Background = {}
defaults.Texts.Inventory.Background.Enable = false
defaults.Texts.Inventory.Background.Opacity = 100

-- Action Description
defaults.Texts.ActionDescription = {}
defaults.Texts.ActionDescription.Italics = true
defaults.Texts.ActionDescription.Font = 'Times New Roman'
defaults.Texts.ActionDescription.Size = 9
defaults.Texts.ActionDescription.Color = {}
defaults.Texts.ActionDescription.Color.Alpha = 255
defaults.Texts.ActionDescription.Color.Red = 255
defaults.Texts.ActionDescription.Color.Green = 255
defaults.Texts.ActionDescription.Color.Blue = 255
defaults.Texts.ActionDescription.Stroke = {}
defaults.Texts.ActionDescription.Stroke.Width = 3
defaults.Texts.ActionDescription.Stroke.Alpha = 200
defaults.Texts.ActionDescription.Stroke.Red = 20
defaults.Texts.ActionDescription.Stroke.Green = 20
defaults.Texts.ActionDescription.Stroke.Blue = 20
defaults.Texts.ActionDescription.Background = {}
defaults.Texts.ActionDescription.Background.Enable = true
defaults.Texts.ActionDescription.Background.Opacity = 180

-- Overlays [Base]
defaults.Overlays = {}
defaults.Overlays.DisableScroll = false

defaults.Controls = {}
defaults.Controls.ToggleBattleMode = 43

defaults.Dev = {}
defaults.Dev.DevMode = false

return defaults
