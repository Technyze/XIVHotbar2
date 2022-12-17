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


--[[ 

    Theme

    Description: Copies content from settings.xml,
    these settings decide how the UI will draw its 
    elements.
--]]

local theme = {}

theme.apply = function(settings)

    local options = {}

    -- General
    local sg = settings.General
    options.enable_weapon_switching = sg.EnableWeaponSwitching
    options.hide_hotbar_numbers     = sg.HideHotbarNumbers
    options.hide_env                = sg.HideEnvironment
    options.hide_inventory_count    = sg.HideInventoryCount
    options.playing_on_horizon      = sg.PlayingHorizonXI


    -- Hotbar
    local sh = settings.Hotbar
    options.show_description        = sh.ShowActionDescription
    options.hide_empty_slots        = sh.HideEmptySlots
    options.hide_action_names       = sh.HideActionName
    options.hide_action_cost        = sh.HideActionCost
    options.hide_recast_text        = sh.HideRecastText
	  options.slot_icon_scale         = sh.SlotIconScale
	  options.offsets = {
		['1'] = {Vertical = sh.Offsets.First.Vertical, OffsetX = sh.Offsets.First.OffsetX,  OffsetY = sh.Offsets.First.OffsetY},
		['2'] = {Vertical = sh.Offsets.Second.Vertical, OffsetX = sh.Offsets.Second.OffsetX, OffsetY = sh.Offsets.Second.OffsetY},
		['3'] = {Vertical = sh.Offsets.Third.Vertical, OffsetX = sh.Offsets.Third.OffsetX,  OffsetY = sh.Offsets.Third.OffsetY},
		['4'] = {Vertical = sh.Offsets.Fourth.Vertical, OffsetX = sh.Offsets.Fourth.OffsetX, OffsetY = sh.Offsets.Fourth.OffsetY},
		['5'] = {Vertical = sh.Offsets.Fifth.Vertical, OffsetX = sh.Offsets.Fifth.OffsetX,  OffsetY = sh.Offsets.Fifth.OffsetY},
		['6'] = {Vertical = sh.Offsets.Sixth.Vertical, OffsetX = sh.Offsets.Sixth.OffsetX,  OffsetY = sh.Offsets.Sixth.OffsetY}
	}
    -- [Hotbar - Theme]
    options.slot_theme              = sh.Theme.Slot
    options.frame_theme             = sh.Theme.Frame
    -- [Hotbar - Style]
    options.hotbar_number           = sh.Style.HotbarCount
    options.rows                    = sh.Style.HotbarCount
    options.columns                 = sh.Style.HotbarLength
    options.slot_opacity            = sh.Style.SlotAlpha
    options.slot_spacing            = sh.Style.SlotSpacing
    options.hotbar_spacing          = sh.Style.HotbarSpacing
    options.offset_x                = sh.Style.OffsetX
    options.offset_y                = sh.Style.OffsetY
    options.slot_icon_scale         = sh.Style.SlotIconScale
    -- [Hotbar - Misc]
    options.feedback_max_opacity    = sh.Misc.Feedback.Opacity
    options.feedback_speed          = sh.Misc.Feedback.Speed
    options.disabled_slot_opacity   = sh.Misc.Disabled.Opacity
 
    -- Texts
    local st = settings.Texts

    -- [Texts - Action Names] --
    options.font_names                     = st.ActionName.Font
    options.font_size_names                = st.ActionName.Size
    options.font_alpha_names               = st.ActionName.Color.Alpha
    options.font_color_red_names           = st.ActionName.Color.Red
    options.font_color_green_names         = st.ActionName.Color.Green
    options.font_color_blue_names          = st.ActionName.Color.Blue
    options.font_stroke_width_names        = st.ActionName.Stroke.Width
    options.font_stroke_alpha_names        = st.ActionName.Stroke.Alpha
    options.font_stroke_color_red_names    = st.ActionName.Stroke.Red
    options.font_stroke_color_green_names  = st.ActionName.Stroke.Green
    options.font_stroke_color_blue_names   = st.ActionName.Stroke.Blue
    options.font_offset_x_names            = st.ActionName.Pos.OffsetX
    options.font_offset_y_names            = st.ActionName.Pos.OffsetY
    options.font_bg_enable_names           = st.ActionName.Background.Enable
    options.font_bg_opacity_names          = st.ActionName.Background.Opacity


    -- [Texts - Keys] --
    options.font_keys                    = st.Keys.Font
    options.font_size_keys               = st.Keys.Size
    options.font_alpha_keys              = st.Keys.Color.Alpha
    options.font_color_red_keys          = st.Keys.Color.Red
    options.font_color_green_keys        = st.Keys.Color.Green
    options.font_color_blue_keys         = st.Keys.Color.Blue
    options.font_stroke_width_keys       = st.Keys.Stroke.Width
    options.font_stroke_alpha_keys       = st.Keys.Stroke.Alpha
    options.font_stroke_color_red_keys   = st.Keys.Stroke.Red
    options.font_stroke_color_green_keys = st.Keys.Stroke.Green
    options.font_stroke_color_blue_keys  = st.Keys.Stroke.Blue
    options.text_offset_x_keys           = st.Keys.Pos.OffsetX
    options.text_offset_y_keys           = st.Keys.Pos.OffsetY

    -- [Texts - Costs] --
    options.font_costs                    = st.Costs.Font
    options.font_size_costs               = st.Costs.Size
    options.font_alpha_costs              = st.Costs.Color.Alpha
    options.font_color_red_costs          = st.Costs.Color.Red
    options.font_color_green_costs        = st.Costs.Color.Green
    options.font_color_blue_costs         = st.Costs.Color.Blue
    options.font_stroke_width_costs       = st.Costs.Stroke.Width
    options.font_stroke_alpha_costs       = st.Costs.Stroke.Alpha
    options.font_stroke_color_red_costs   = st.Costs.Stroke.Red
    options.font_stroke_color_green_costs = st.Costs.Stroke.Green
    options.font_stroke_color_blue_costs  = st.Costs.Stroke.Blue
    options.text_offset_x_costs           = st.Costs.Pos.OffsetX
    options.text_offset_y_costs           = st.Costs.Pos.OffsetY
    
    -- [Texts - Recast] --
    options.font_recasts                     = st.Recasts.Font
    options.font_size_recasts                = st.Recasts.Size
    options.font_alpha_recasts               = st.Recasts.Color.Alpha
    options.font_color_red_recasts           = st.Recasts.Color.Red
    options.font_color_green_recasts         = st.Recasts.Color.Green
    options.font_color_blue_recasts          = st.Recasts.Color.Blue
    options.font_stroke_width_recasts        = st.Recasts.Stroke.Width
    options.font_stroke_alpha_recasts        = st.Recasts.Stroke.Alpha
    options.font_stroke_color_red_recasts    = st.Recasts.Stroke.Red
    options.font_stroke_color_green_recasts  = st.Recasts.Stroke.Green
    options.font_stroke_color_blue_recasts   = st.Recasts.Stroke.Blue
    options.text_offset_x_recasts            = st.Recasts.Pos.OffsetX
    options.text_offset_y_recasts            = st.Recasts.Pos.OffsetY
    

    -- [Texts - Hotbar Numbers] --
    options.font_hotbar_nums                     = st.HotbarNumbers.Font
    options.font_size_hotbar_nums                = st.HotbarNumbers.Size
    options.font_italics_hotbar_nums             = st.HotbarNumbers.Italics
    options.font_alpha_hotbar_nums               = st.HotbarNumbers.Color.Alpha
    options.font_color_red_hotbar_nums           = st.HotbarNumbers.Color.Red
    options.font_color_green_hotbar_nums         = st.HotbarNumbers.Color.Green
    options.font_color_blue_hotbar_nums          = st.HotbarNumbers.Color.Blue
    options.font_stroke_width_hotbar_nums        = st.HotbarNumbers.Stroke.Width
    options.font_stroke_alpha_hotbar_nums        = st.HotbarNumbers.Stroke.Alpha
    options.font_stroke_color_red_hotbar_nums    = st.HotbarNumbers.Stroke.Red
    options.font_stroke_color_green_hotbar_nums  = st.HotbarNumbers.Stroke.Green
    options.font_stroke_color_blue_hotbar_nums   = st.HotbarNumbers.Stroke.Blue
    options.text_offset_x_hotbar_nums            = st.HotbarNumbers.Pos.OffsetX
    options.text_offset_y_hotbar_nums            = st.HotbarNumbers.Pos.OffsetY
    options.text_vert_offset_x_hotbar_nums       = st.HotbarNumbers.Pos.VertOffsetX
    options.text_vert_offset_y_hotbar_nums       = st.HotbarNumbers.Pos.VertOffsetY

    -- [Texts - Environment] --
    options.font_battle_text_env                = st.Environment.BattleText
    options.font_field_text_env                 = st.Environment.FieldText
    options.hook_onto_bar                       = st.Environment.Pos.HookOntoBar
    options.font_pos_x_env                      = st.Environment.Pos.PosX
    options.font_pos_y_env                      = st.Environment.Pos.PosY
    options.font_offset_x_env                   = st.Environment.Pos.OffsetX
    options.font_offset_y_env                   = st.Environment.Pos.OffsetY
    options.font_hook_offset_x_env              = st.Environment.Pos.HookOffsetX
    options.font_hook_offset_y_env              = st.Environment.Pos.HookOffsetY
    options.font_italics_env                    = st.Environment.Italics
    options.font_env                            = st.Environment.Font
    options.font_size_env                       = st.Environment.Size
    options.font_alpha_env                      = st.Environment.Color.Alpha
    options.font_color_red_env                  = st.Environment.Color.Red
    options.font_color_green_env                = st.Environment.Color.Green
    options.font_color_blue_env                 = st.Environment.Color.Blue
    options.font_stroke_width_env               = st.Environment.Stroke.Width
    options.font_stroke_alpha_env               = st.Environment.Stroke.Alpha
    options.font_stroke_color_red_env           = st.Environment.Stroke.Red
    options.font_stroke_color_green_env         = st.Environment.Stroke.Green
    options.font_stroke_color_blue_env          = st.Environment.Stroke.Blue
  

    -- [Texts - Inventory] --
    options.unlock_pos_inv                      = st.Inventory.Pos.Unlock
    options.font_pos_x_inv                      = st.Inventory.Pos.PosX
    options.font_pos_y_inv                      = st.Inventory.Pos.PosY
    options.text_offset_x_inv                   = st.Inventory.Pos.OffsetX
    options.text_offset_y_inv                   = st.Inventory.Pos.OffsetY
    options.font_italics_inv                    = st.Inventory.Italics
    options.font_inv                            = st.Inventory.Font
    options.font_size_inv                       = st.Inventory.Size
    options.font_alpha_inv                      = st.Inventory.Color.Alpha
    options.font_color_red_inv                  = st.Inventory.Color.Red
    options.font_color_green_inv                = st.Inventory.Color.Green
    options.font_color_blue_inv                 = st.Inventory.Color.Blue
    options.font_stroke_width_inv               = st.Inventory.Stroke.Width
    options.font_stroke_alpha_inv               = st.Inventory.Stroke.Alpha
    options.font_stroke_color_red_inv           = st.Inventory.Stroke.Red
    options.font_stroke_color_green_inv         = st.Inventory.Stroke.Green
    options.font_stroke_color_blue_inv          = st.Inventory.Stroke.Blue
    options.font_bg_enable_inv                  = st.Inventory.Background.Enable
    options.font_bg_opacity_inv                 = st.Inventory.Background.Opacity


    -- [Texts - ActionDescription] --
    options.font_italics_descr                    = st.ActionDescription.Italics
    options.font_descr                            = st.ActionDescription.Font
    options.font_size_descr                       = st.ActionDescription.Size
    options.font_alpha_descr                      = st.ActionDescription.Color.Alpha
    options.font_color_red_descr                  = st.ActionDescription.Color.Red
    options.font_color_green_descr                = st.ActionDescription.Color.Green
    options.font_color_blue_descr                 = st.ActionDescription.Color.Blue
    options.font_stroke_width_descr               = st.ActionDescription.Stroke.Width
    options.font_stroke_alpha_descr               = st.ActionDescription.Stroke.Alpha
    options.font_stroke_color_red_descr           = st.ActionDescription.Stroke.Red
    options.font_stroke_color_green_descr         = st.ActionDescription.Stroke.Green
    options.font_stroke_color_blue_descr          = st.ActionDescription.Stroke.Blue
    options.font_bg_enable_descr                  = st.ActionDescription.Background.Enable
    options.font_bg_opacity_descr                 = st.ActionDescription.Background.Opacity
 
    -- Images
    local so = settings.Overlays
    options.disable_scroll                        = so.DisableScroll


    -- Controls
    local sco = settings.Controls
    options.controls_battle_mode = sco.ToggleBattleMode



    -- Development
    local sd = settings.Dev
    options.dev_mode                = sd.DevMode

    return options
end

return theme
