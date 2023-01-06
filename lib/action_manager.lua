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

local file_manager = require('lib/file_manager')
local ui = require('lib/ui')
local spell_list = require('priv_res/spells')
local horizon_spell_list = require('priv_res/horizon_spells')
local ws_list = require('priv_res/weapon_skills')
local ability_list = require('priv_res/job_abilities')
local job_list = require('priv_res/jobs')
local job_root = {}
local action_manager = {}
local mainjob_actions = {}
local subjob_actions = {}
local general_actions = {}
local stance_actions = {}
local job_ability_actions = {}
local weaponskill_actions = {}
local current_stance = nil
local learned_spells_name = {}
local learned_ws_id = {}
local learned_abilities_id = {}
not_learned_spells = {}
not_learned_spells_row_slot = {}
tier_list = {}

buff_table = {
    [211] = 'Light Arts',
    [212] = 'Dark Arts',
	-- Avatars
	[1001] = 'Carbuncle',
	[1002] = 'Ifrit',
	[1003] = 'Shiva',
	[1004] = 'Leviathan',
	[1005] = 'Ramuh',
	[1006] = 'Fenrir',
	[1007] = 'Diabolos',
	[1008] = 'Alexander',
	[1009] = 'Cait Sith',
	[1010] = 'Garuda',
	[1011] = 'Odin',
	[1012] = 'Titan',
	[1013] = 'Atomos',
    
}


weaponskill_actions.xivhotbar_keybinds_job = {}
subjob_actions.xivhotbar_keybinds_job = {}

action_manager.theme_options = {}
action_manager.hotbar = {}
action_manager.hotbar_settings = {}
action_manager.hotbar_settings.max = 1
action_manager.hotbar_settings.active_hotbar = 1
action_manager.hotbar_settings.active_environment = 'battle'

_job_fileG = {}
_job_fileG.xivhotbar_keybinds_job = {}
_general_fileG = {}
_general_fileG.xivhotbar_keybinds_general = {}

weaponskill_types = {
	[1] = "Hand-to-hand",
	[2] = "Dagger", 
	[3] = "Sword",
	[4] = "Great Sword",
	[5] = "Axe",
	[6] = "Great Axe",
	[7] = "Scythe",
	[8] = "Polearm",
	[9] = "Katana",
	[10] = "Great Katana",
	[11] = "Club",
	[12] = "Staff",
	[25] = "Bow",
	[26] = "Marksmanship",
}


local function create_table(_new_table, _table_key)
    setmetatable(_new_table, {
    __index = function(g, k)
        local t = rawget(rawget(g, table_key), k)
        if not t then
            t = {}
            rawset(rawget(g, table_key), k, t)
        end
        return t
    end,
    __newindex = function(g, k, v)
        local t = rawget(rawget(g, table_key), k)
        if t and type(v) == 'table' then
            for k, v in pairs(v) do
                t[k] = v
            end
        end
    end
	})
end

local keybinds_job_table = {
    __index = function(g, k)
        local t = rawget(rawget(g, 'xivhotbar_keybinds_job'), k)
        if not t then
            t = {}
            rawset(rawget(g, 'xivhotbar_keybinds_job'), k, t)
        end
        return t
    end,
    __newindex = function(g, k, v)
        local t = rawget(rawget(g, 'xivhotbar_keybinds_job'), k)
        if t and type(v) == 'table' then
            for k, v in pairs(v) do
                t[k] = v
            end
        end
    end
}

local general_keybinds_table = {
    __index = function(g, k)
        local t = rawget(rawget(g, 'xivhotbar_keybinds_general'), k)
        if not t then
            t = {}
            rawset(rawget(g, 'xivhotbar_keybinds_general'), k, t)
        end
        return t
    end,
    __newindex = function(g, k, v)
        local t = rawget(rawget(g, 'xivhotbar_keybinds_general'), k)
        if t and type(v) == 'table' then
            for k, v in pairs(v) do
                t[k] = v
            end
        end
    end
}

-- Initialize keybinds tables
setmetatable(_job_fileG, keybinds_job_table)
setmetatable(_general_fileG, general_keybinds_table)
local CUSTOM_TYPE = 'ct'

local function init_action_table(actions_table)
    actions_table.environment = {}
    actions_table.hotbar = {}
    actions_table.slot = {}
    actions_table.type = {}
    actions_table.action = {}
    actions_table.target = {}
    actions_table.alias = {}
	actions_table.icon = {}
  
end

function action_manager:init_action_tables()
    init_action_table(mainjob_actions)
    init_action_table(subjob_actions)
    init_action_table(weaponskill_actions)
    init_action_table(general_actions)
    init_action_table(stance_actions)
end

-- build action
function action_manager:build(type, action, target, alias, icon)
    local new_action = {}

    new_action.type   = type
    new_action.action = action
    new_action.target = target

    if alias == nil then alias = ' ' end
    new_action.alias = alias

    if icon == '' then icon = nil end
    if icon ~= nil then
        new_action.icon = icon
        
    end

    return new_action

end

-- add given action to a hotbar
local function add_action(am, action, environment, hotbar, slot)
    status = true
    if environment == 'b' then environment = 'battle' elseif environment == 'f' then environment = 'field' end
    --if slot == 10 then slot = 0 end

    if am.hotbar[environment] == nil then
        windower.console.write('XIVHOTBAR: invalid hotbar (environment)')
        status = false
    end

    if (tonumber(hotbar) > am.hotbar_rows) then 
        status = false
    elseif am.hotbar[environment]['hotbar_' .. hotbar] == nil then
        windower.console.write('XIVHOTBAR: invalid hotbar (hotbar number)')
        status = false
    end
    if status == true then
        if am.hotbar[environment]['hotbar_' .. hotbar]['slot_' .. slot] == nil then
            am.hotbar[environment]['hotbar_' .. hotbar]['slot_' .. slot] = {} 
            status = false
        end

        am.hotbar[environment]['hotbar_' .. hotbar]['slot_' .. slot] = action
    end
end




local function fill_table(file_table, file_key, actions_table)
	-- Slot_key is 'battle 1 2' in a job/general file.
    -- file_table is each slot that contains a list of string. Example (First Key): file_table = {'battle 1 1', 'ma', 'Cure', 'stpc', 'Cure'}
    -- file_key is the number for that slot. Example (First Key): 1
	local slot_key = T(file_table[1]:split(' ')) -- Splits 'battle 1 1' into a list {'battle','1','1'}

	actions_table.environment[file_key] = slot_key[1] --environment is either battle or field
	actions_table.hotbar[file_key]      = slot_key[2] --hotbar number
	actions_table.slot[file_key]        = slot_key[3] --slot number in above hotbar
	actions_table.type[file_key]        = file_table[2] -- type of attack: ma, ws, input, macro etc.
	actions_table.action[file_key]      = file_table[3] -- name of action: dia, slow, provoke, etc. 
	actions_table.target[file_key]      = file_table[4] -- target: t, st, stnpc, etc    
    actions_table.alias[file_key]       = file_table[5] -- display name for each slot/skill
	if (file_table[6] ~= nil) then -- if last slot of file_table is not empty/blank then...
        actions_table.icon[file_key]    = file_table[6] -- name of icon image in images/icons/custom folder
	end

end

function action_manager:update_stance(buff_id)  
	current_stance = buff_id
end

-- create a default hotbar
local function create_default_hotbar()
    windower.console.write('XIVHotbar: no hotbar found. Creating a default hotbar.')
    --add default actions to the new hotbar
    action_manager:add_action(action_manager:build_custom('attack on', 'Attack', 'attack'), 'field', 1, 1)
    action_manager:add_action(action_manager:build_custom('check', 'Check', 'check'), 'field', 1, 2)
    action_manager:add_action(action_manager:build_custom('returntrust all', 'No Trusts', 'return-trust'), 'field', 1, 9)
    action_manager:add_action(action_manager:build_custom('heal', 'Heal', 'heal'), 'field', 1, 0)
    action_manager:add_action(action_manager:build_custom('check', 'Check', 'check'), 'battle', 1, 9)
    action_manager:add_action(action_manager:build_custom('attack off', 'Disengage', 'disengage'), 'battle', 1, 0)
end

local function parse_general_binds(hotbar)
	for key, val in pairs(hotbar['Root']) do
        if action_req_check(hotbar['Root'][key]) == true then
		    fill_table(hotbar['Root'][key], key, general_actions)
        end
	end
end

function action_req_check(action_array)
    local slot_key = T(action_array[1]:split(' '))
    row = tonumber(slot_key[2])
    col = tonumber(slot_key[3])
    
   
    -- print("-----------------------")
    -- for k,v in pairs(tier_list) do
    --     print(v)
    -- end
    -- print("-----------------------")
   
    
    if action_array[2] == 'ma' then
        -- Note: create function validate_ma to do the below code in a more organized manner
        if check_spell_level(action_array[3]) == true then
            if check_if_spell_learned(action_array[3]) == true then 
                 -- LEARNED AND PREVIOUS IS SAME SLOT --
                if previous_slot == action_array[1] then --If previous action was on same slot and character meets level requirement but not learned requirement
                    if previous_learned == true then
                        table.insert(tier_list,action_array[3])
                        previous_learned = true
                        tier_list_complete = true
                        for k,v in pairs(tier_list) do
                            if v == false then
                               tier_list_complete = false
                            end
                        end
                        if tier_list_complete == true then 
                            
                            not_learned_spells_row_slot[action_array[3]] = false
                        end
                        previous_level_req_met = true
                        return false -- If previous spell meets requirements then return false and dont parse this spell
                    elseif previous_learned ~= true then
                        for k,v in pairs(tier_list) do
                            if v ~= false then
                                
                                if previous_level_req_met == true then
                                    not_learned_spells_row_slot[action_array[3]] = action_array[1]
                                end
                                previous_slot = action_array[1]
                                previous_learned = true
                                previous_level_req_met = true
                                return false 
                            end
                        end
                        table.insert(tier_list,action_array[3])
                    
                        if previous_level_req_met == true then 
                            not_learned_spells_row_slot[action_array[3]] = action_array[1]
                        end
                        previous_slot = action_array[1]
                        previous_learned = true
                        previous_level_req_met = true
                        return true 
                    end
                -- LEARNED AND PREVIOUS IS NOT SAME SLOT --
                elseif previous_slot ~= action_array[1] then -- Head of the list, could just be a list of 1.
                    tier_list = {} -- Empty this list and start new list with action name on next line.
                    table.insert(tier_list,action_array[3])
                    
                    not_learned_spells_row_slot[action_array[3]] = false
                    previous_slot = action_array[1]
                    previous_learned = true
                    previous_level_req_met = true
                    return true
                end    
            elseif check_if_spell_learned(action_array[3]) ~= true then
                -- NOT LEARNED AND PREVIOUS NOT SAME SLOT --
                if previous_slot ~= action_array[1] then --If action doesn't share a hotbar slot
                    tier_list = {}
                    table.insert(tier_list,false)
                  
                    not_learned_spells_row_slot[action_array[3]] = action_array[1]
                    for key,val in pairs(spells) do
                        if action_array[3] == spells[key]['en'] then
                            table.insert(not_learned_spells,action_array[3]) 
                            previous_slot = action_array[1]
                            previous_learned = false
                            previous_level_req_met = true
                            return true -- Character is correct level for spell but hasn't learned it.
                        end
                    end
                -- NOT LEARNED AND PREVIOUS IS SAME SLOT --
                elseif previous_slot == action_array[1] then
                    table.insert(tier_list,false)
                    for k,v in pairs(tier_list) do
                        if v ~= false then
                           
                            not_learned_spells_row_slot[action_array[3]] = action_array[1]
                            
                            break
                        end
                    end
                    previous_slot = action_array[1]
                    previous_learned = false
                    previous_level_req_met = true
                    return false -- Character is correct level for spell but hasn't learned it.
                end
            end
        elseif check_spell_level(action_array[3]) ~= true then
            if previous_slot ~= action_array[1] then
                tier_list = {}
                table.insert(tier_list,false)
                previous_slot = action_array[1]
                previous_learned = false
                previous_level_req_met = false
            elseif previous_slot == action_array[1] then
                table.insert(tier_list,false)
                previous_slot = action_array[1]
                previous_learned = false
                previous_level_req_met = false
            end
        end
    elseif action_array[2] == 'ja' then
        if check_if_ability_learned(action_array[3]) == true then
            return true
        end
        return false
    elseif action_array[2] == 'ws' then
        if check_if_ws_learned(action_array[3]) == true then
            return true
        end
        return false
    elseif action_array[2] == 'ct' or action_array[2] == 'pet' then
        return true 
    elseif action_array[2] == 'input' then
        return true
    elseif action_array[2] == 'macro' then
        return true
    else
        return false
    end

end
function check_spell_level(spell_name_en)
    for key,val in pairs(spells) do
        if spells[key]['en'] == spell_name_en then
            if spells[key]['levels'][windower.ffxi.get_player().main_job_id] == nil then  -- Check to see if current main job even has a level associated with spell
                if windower.ffxi.get_player().sub_job_level == nil or spells[key]['levels'][windower.ffxi.get_player().sub_job_id] == nil then -- Otherwise check to see if current sub job even has a level associated with spell
                    return false
                elseif windower.ffxi.get_player().sub_job_level < spells[key]['levels'][windower.ffxi.get_player().sub_job_id] then -- Check to see if sub job level is lower than spell level
                    return false
                else
                    return true
                end
            elseif windower.ffxi.get_player().main_job_level < spells[key]['levels'][windower.ffxi.get_player().main_job_id] then -- Check to see if main job level is lower than spell level
                return false
            else
                return true
            end
        end
    end
end

function check_if_spell_learned(spell_name_en)
    for k,v in pairs(learned_spells_name) do
        if v == spell_name_en then
            --These are spells that player meets level and learned requirement
            return true
        end
    end

    return false
end


function check_if_ability_learned(ability_name_en)
   
    for key,val in pairs(ability_list) do
        if ability_list[key]['en'] == ability_name_en then
            for k,v in pairs(learned_abilities_id) do                
                if v == ability_list[key]['id'] then
                    return true
                end
            end
            return false
        end
    end
end

function check_if_ws_learned(ws_name_en)
   
    for key,val in pairs(ws_list) do
        if ws_list[key]['en'] == ws_name_en then
            for k,v in pairs(learned_ws_id) do
                if v == ws_list[key]['id'] then
                    return true
                end
            end
            return false
        end
    end
end

local function parse_binds(theme_options, player, hotbar)
    
    learned_abilities_id = {}
    learned_spells_name = {}
    learned_ws_id = {}
    missing_actions = {}

    -- Create Learned Spells List
    if theme_options.playing_on_horizon == true then
        spells = horizon_spell_list
        for key,val in pairs(horizon_spell_list) do
            if windower.ffxi.get_spells()[spells[key]['id']] == true then 
                table.insert(learned_spells_name,spells[key]['en']) 
            end
        end
    elseif theme_options.playing_on_horizon == false then
        spells = spell_list
        for key,val in pairs(spell_list) do
            if windower.ffxi.get_spells()[spells[key]['id']] == true then 
                table.insert(learned_spells_name,spells[key]['en']) 
            end
        end
    end
    
    -- Create Learned Abilities List
    abilities = ability_list
    for key,val in pairs(windower.ffxi.get_abilities().job_abilities) do
        for k,v in pairs(abilities) do
            if val == k then
                table.insert(learned_abilities_id,abilities[k]['id'])  
            end
        end
    end

    -- Create Learned Weaponskills List
    weaponskills = ws_list
    for key,val in pairs(windower.ffxi.get_abilities().weapon_skills) do
        for k,v in pairs(weaponskills) do
            if val == k then
                table.insert(learned_ws_id,weaponskills[k]['id'])  
            end
        end
    end
    
    -- MAIN JOB -- FILL TABLE
	for key, val in pairs(hotbar['Base']) do -- Goes through each slot in the 'Base' job. Key is number sequenced. Values is list of strings.
        if action_req_check(hotbar['Base'][key]) == true then
            fill_table(hotbar['Base'][key], key, mainjob_actions) -- hotbar['Base'][key] is each line in the BASE section of the JOB.lua file  
        end
    end

    -- SUB JOB -- FILL TABLE
	if (hotbar[player.sub_job] ~= nil) then
		for key, val in pairs(hotbar[player.sub_job]) do
            if action_req_check(hotbar[player.sub_job][key]) == true then 
			    fill_table(hotbar[player.sub_job][key], key, subjob_actions)
            end
		end
	else
		for key, val in pairs(subjob_actions.environment) do
			self:remove_action()
		end
		subjob_actions = {}
	end

    -- STANCE -- FILL TABLE
    if (hotbar[buff_table[current_stance]] ~= nil) then
        local stance_table = hotbar[buff_table[current_stance]]
        for key, val in pairs(stance_table) do
            if action_req_check(stance_table[key]) == true then 
                fill_table(stance_table[key], key, stance_actions)
            end
        end
    end

    -- WEAPON SWITCHING -- FILL TABLE
	if (theme_options.enable_weapon_switching == true) then
		if (weaponskill_types[player.current_weapon] ~= nil) then
			if (hotbar[weaponskill_types[player.current_weapon]] ~= nil) then
				for key, val in pairs(hotbar[weaponskill_types[player.current_weapon]]) do 
                    if action_req_check(hotbar[weaponskill_types[player.current_weapon]][key]) == true then
					    fill_table(hotbar[weaponskill_types[player.current_weapon]][key], key, weaponskill_actions)
                    end
				end
			end
		end
	end
end

function action_manager:initialize(theme_options)
	self.theme_options       = theme_options
    self.hotbar_settings.max = theme_options.hotbar_number
    self.hotbar_rows         = theme_options.rows
end

function action_manager:reset_hotbar()
    self.hotbar = {
        ['battle'] = {},
        ['field'] = {}
    }

    for h=1,self.hotbar_settings.max,1 do
        
        self.hotbar.field['hotbar_' .. h] = {}
        self.hotbar.battle['hotbar_' .. h] = {}
    end

    self.hotbar_settings.active_hotbar = 1
end
-- build a custom action
function action_manager:build_custom(action, alias, icon)
    return self:build(CUSTOM_TYPE, action, nil, alias, icon)
end

function action_manager:swap_actions(player, swap_table)
	local s_row  = swap_table.source.row
	local s_slot = swap_table.source.slot
	local d_row  = swap_table.dest.row
	local d_slot = swap_table.dest.slot

    if self.hotbar_settings.active_environment == 'battle' then

		if (self.hotbar['battle']['hotbar_' .. s_row]['slot_' .. s_slot] ~= nil) then
			if(self.hotbar['battle']['hotbar_' .. d_row]['slot_' .. d_slot] == nil) then
				self.hotbar['battle']['hotbar_' .. d_row]['slot_' .. d_slot] = table.copy(self.hotbar['battle']['hotbar_' .. s_row]['slot_' .. s_slot] , true)
				self.hotbar['battle']['hotbar_' .. s_row]['slot_' .. s_slot] = nil

				-- Write the changes after swapping the actions
				local dest_action = self.hotbar['battle']['hotbar_' .. d_row]['slot_' .. d_slot] 
				file_manager:write_changes(dest_action, d_row, d_slot, s_row, s_slot, 'b')
			else
				temp_slot = table.copy(self.hotbar['battle']['hotbar_' .. s_row]['slot_' .. s_slot], true)
				self.hotbar['battle']['hotbar_' .. s_row]['slot_' .. s_slot] = table.copy(self.hotbar['battle']['hotbar_' .. d_row]['slot_' .. d_slot], true)
				self.hotbar['battle']['hotbar_' .. d_row]['slot_' .. d_slot] = temp_slot

				-- Write the changes after swapping the actions
				local dest_action = self.hotbar['battle']['hotbar_' .. d_row]['slot_' .. d_slot] 
				local source_action = self.hotbar['battle']['hotbar_' .. s_row]['slot_' .. s_slot] 
				file_manager:write_changes(source_action, s_row, s_slot, d_row, d_slot, 'b')
				file_manager:write_changes(dest_action, d_row, d_slot, s_row, s_slot, 'b')
			end
		else
			print("XIVHOTBAR2: Cannot swap icons if the dragged icon is empty!")
		end
    else -- field

		if (self.hotbar['field']['hotbar_' .. s_row]['slot_' .. s_slot] ~= nil) then
			if(self.hotbar['field']['hotbar_' .. d_row]['slot_' .. d_slot] == nil) then
				self.hotbar['field']['hotbar_' .. d_row]['slot_' .. d_slot] = table.copy(self.hotbar['field']['hotbar_' .. s_row]['slot_' .. s_slot] , true)
				self.hotbar['field']['hotbar_' .. s_row]['slot_' .. s_slot] = nil

				-- Write the changes after swapping the actions
				local dest_action = self.hotbar['field']['hotbar_' .. d_row]['slot_' .. d_slot] 
				file_manager:write_changes(dest_action, d_row, d_slot, s_row, s_slot, 'f')
			else
				temp_slot = table.copy(self.hotbar['field']['hotbar_' .. s_row]['slot_' .. s_slot], true)
				self.hotbar['field']['hotbar_' .. s_row]['slot_' .. s_slot] = table.copy(self.hotbar['field']['hotbar_' .. d_row]['slot_' .. d_slot], true)
				self.hotbar['field']['hotbar_' .. d_row]['slot_' .. d_slot] = temp_slot

				-- Write the changes after swapping the actions
				local dest_action = self.hotbar['field']['hotbar_' .. d_row]['slot_' .. d_slot] 
				local source_action = self.hotbar['field']['hotbar_' .. s_row]['slot_' .. s_slot] 
				file_manager:write_changes(source_action, s_row, s_slot, d_row, d_slot, 'f')
				file_manager:write_changes(dest_action, d_row, d_slot, s_row, s_slot, 'f')
			end
		else
			print("XIVHOTBAR: Cannot swap icons if the dragged icon is empty!")
		end
    end
end

function action_manager:remove_action(player, remove_table)

	local row = remove_table.source.row
	local slot = remove_table.source.slot

    if self.hotbar_settings.active_environment == 'battle' then
		if (self.hotbar['battle']['hotbar_' .. row]['slot_' .. slot] ~= nil) then
			file_manager:write_remove(self.hotbar['battle']['hotbar_' .. row]['slot_' .. slot], row, slot, 'b')
			self.hotbar['battle']['hotbar_' .. row]['slot_' .. slot] = nil
		end
	else
		if (self.hotbar['battle']['hotbar_' .. row]['slot_' .. slot] ~= nil) then
			file_manager:write_remove(self.hotbar['field']['hotbar_' .. row]['slot_' .. slot], row, slot, 'f')
			self.hotbar['field']['hotbar_' .. row]['slot_' .. slot] = nil
		end
	end
end

function action_manager:insert_action(player_subjob, args)
    if not args[6] then
        print('XIVHOTBAR2: Invalid arguments: set <mode> <hotbar> <slot> <action_type> <action> <target (optional)> <alias (optional)> <icon (optional)>')
        return
    end
    local prio = args[1]:lower()
    local row = tonumber(args[2]) or 0
    local slot = tonumber(args[3]) or 0
    local action_type = args[4]:lower()
    local action = args[5]
    local target = args[6] or nil
    local alias = args[7] or nil
    local icon = args[8] or nil
    if target ~= nil then target = target:lower() end
	local environment_to_send = function()
		if self.hotbar_settings.active_environment == 'field' then return 'f' else return 'b' end
	end

    local new_action = action_manager:build(action_type, action, target, alias, icon)
   
	file_manager:insert_action(new_action, prio, player_subjob, environment_to_send(), row, slot)
end

function action_manager:update_file_path(player_name, player_job)
	file_manager:update_file_path(player_name, player_job)
end

function action_manager:add_actions(action_table)

    
    for key in pairs(action_table.environment) do 
       
        add_action(self,
			action_manager:build(
				action_table.type[key], 
				action_table.action[key], 
				action_table.target[key], 
				action_table.alias[key],
				action_table.icon[key] 
			),
            action_table.environment[key],
            action_table.hotbar[key],
            action_table.slot[key]
        )
    end
end

function action_manager:toggle_environment()
    if self.hotbar_settings.active_environment == 'battle' then
        self.hotbar_settings.active_environment = 'field'
    else
        self.hotbar_settings.active_environment = 'battle'
    end
end

function action_manager:get_action(slot)
    return self.hotbar[self.hotbar_settings.active_environment]['hotbar_' .. self.hotbar_settings.active_hotbar]['slot_' .. slot]
end

-- change active hotbar
function action_manager:change_active_hotbar(new_hotbar)
    self.hotbar_settings.active_hotbar = new_hotbar

    if self.hotbar_settings.active_hotbar > self.hotbar_settings.max then
        self.hotbar_settings.active_hotbar = 1
    end
end

function action_manager:load(player)
    
	action_manager:init_action_tables() -- Create/Initialize MainJob, SubJob, Stance, Weaponskill, Stance Tables
    
    local basepath = windower.addon_path .. 'data/'..player.name..'/'
    local job_file = loadfile(basepath .. player.main_job .. '.lua')
    local general_file = loadfile(basepath .. 'General.lua')
    if job_file == nil then 
        print(string.format("XIVHOTBAR2: Couldn't find the job file %s.lua!", player.main_job))
    else
   
    setfenv(job_file, _job_fileG) --Set a function's (JOB.lua) enviroment(global) into a table(_job_fileG)
    
    local job_root = job_file() -- Runs the player.main_job.lua file. Saves its return value in root. Return value is table: Keys are ['JOB'], Value is another table 
                   
    if not job_root then -- if root is nil (JOB.lua has no table), then reinitialize below variables and RETURN
        _job_fileG.xivhotbar_keybinds_job = {}
        _job_fileG._binds = {}
        return
    end
    _job_fileG.xivhotbar_keybinds_job = {}
    _job_fileG.xivhotbar_keybinds_job[job_root] = _job_fileG.xivhotbar_keybinds_job[job_root] or 'Root' 
    

    parse_binds(self.theme_options, player, job_root)

    --ADD Actions for all stances
    action_manager:add_actions(mainjob_actions)
    if (subjob_actions.environment ~= nil) then
        action_manager:add_actions(subjob_actions)
    end
    if (stance_actions.environment ~= nil) then
        action_manager:add_actions(stance_actions)
    end
    action_manager:add_actions(weaponskill_actions)
    end

    if general_file == nil then 
        print("Error, couldn't find file 'General.lua'")
    else
        setfenv(general_file, _general_fileG)
        local general_root = general_file()
        if not general_root then
            _general_fileG.xivhotbar_keybinds_general = {}
            _general_fileG.binds = {}
            return
        end
        _general_fileG.xivhotbar_keybinds_general = {}
        _general_fileG.xivhotbar_keybinds_general[general_root] = _general_fileG.xivhotbar_keybinds_general[general_root] or 'Root'
        parse_general_binds(general_root)

		action_manager:add_actions(general_actions)
    end
end

return action_manager
