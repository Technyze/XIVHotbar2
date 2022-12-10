--[[    BSD License Disclaimer
        Copyright © 2020, SirEdeonX, Akirane, Technyze
        All rights reserved.

        Redistribution and use in source and binary forms, with or without
        modification, are permitted provided that the following conditions are met:

            * Redistributions of source code must retain the above copyright
              notice, this list of conditions and the following disclaimer.
            * Redistributions in binary form must reproduce the above copyright
              notice, this list of conditions and the following disclaimer in the
              documentation and/or other materials provided with the distribution.
            * Neither the name of ui.xivhotbar/xivhotbar2 nor the
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
-- Big thanks to:
-- - Akaden & Rubenator: For the inspiration to the moving icons/hotbars part
-- - Maverickdfz:        Inspiration to the mouse actions
--]]

_addon.name = 'XIVHotbar2'
_addon.author = 'Edeon, Akirane','Technyze'
_addon.version = '0.1'
_addon.language = 'english'
_addon.commands = {'xivhotbar', 'htb', 'execute','xivhotbar2'}

----------------------------------------
-- End of user defined macro placeholder
----------------------------------------

-- Libs --
config = require('config')
file = require('files')
texts = require('texts')
images = require('images')
tables = require('tables')
packets = require('packets')
resources = require('resources')
require('luau')

-- User settings --
local defaults = require('defaults')
local settings = config.load(defaults)
config.save(settings)
first_0x050 = false

-- Load theme options according to settings --
local theme = require('theme')
local theme_options = theme.apply(settings)


-- Addon Dependencies --
local keyboard = require('lib/keyboard_mapper')
local box = require('lib/move_box')
local player = require('lib/player')
local ui = require('lib/ui')
local xiv
local current_zone = 0
local state = {
	ready = false,
	demo = false,
	inventory_ready = false,
	inventory_loading = false
}

-------
-- Main
-------
nil_equip_bool = false

-- initialize addon --
function initialize()

    keyboard:parse_keybinds()
	
    ui:setup(theme_options)
	
	box:init(theme_options)
    windower_player = windower.ffxi.get_player()
	local server = resources.servers[windower.ffxi.get_info().server] 
		and resources.servers[windower.ffxi.get_info().server].en 
		or "PrivateServer_"..tostring(windower.ffxi.get_info().server)
	local inventory = windower.ffxi.get_items()
	local equipment = inventory['equipment']
	if theme_options.enable_weapon_switching == true then
		inv_index = windower.ffxi.get_items().equipment.main
		skill_type = resources.items[windower.ffxi.get_items(0, inv_index).id].skill 
		if windower.ffxi.get_player().main_job == 'RNG' then
			inv_index = windower.ffxi.get_items().equipment.range
			print(windower.ffxi.get_items().equipment.range)
			if windower.ffxi.get_items().equipment.range == 0 then
				inv_index = windower.ffxi.get_items().equipment.main
			end
			skill_type = resources.items[windower.ffxi.get_items(0, inv_index).id].skill
		end
		player:update_weapon_type(skill_type)
	end
	current_mp = windower_player.vitals.mp
	current_tp = windower_player.vitals.tp
	
	ui:update_mp(current_mp)
	ui:update_tp(current_tp)
    player:initialize(windower_player, server, theme_options)
    player:load_hotbar()
    keyboard:bind_keys(theme_options.rows, theme_options.columns)
    ui:load_player_hotbar(player:get_hotbar_info())
    ui.hotbar.ready = true
    ui.hotbar.initialized = true
	state.ready = true
	
end



-- trigger hotbar action --
function trigger_action(slot)
    player:execute_action(slot)
    ui:trigger_feedback(player:get_active_hotbar(), slot)
end


-- toggle between field and battle hotbars --
function toggle_environment()
    player:toggle_environment()

    ui:load_player_hotbar(player:get_hotbar_info())
end


-- set battle environment --
function set_battle_environment(in_battle)
    player:set_battle_environment(in_battle)
    ui:load_player_hotbar(player:get_hotbar_info())
end


-- reload hotbar --
function reload_hotbar()
	
	coroutine.sleep(1)
	
	if resources.jobs[windower.ffxi.get_player().sub_job_id] == nil then -- If character has no subjob
		ui:update_mp(windower.ffxi.get_player().vitals.mp)
		ui:update_tp(windower.ffxi.get_player().vitals.tp)
		player:update_job(resources.jobs[windower.ffxi.get_player().main_job_id].ens, 'NON')
		player:update_level(windower.ffxi.get_player().main_job_level,0)
	else
		ui:update_mp(windower.ffxi.get_player().vitals.mp)
		ui:update_tp(windower.ffxi.get_player().vitals.tp)
		player:update_job(resources.jobs[windower.ffxi.get_player().main_job_id].ens, resources.jobs[windower.ffxi.get_player().sub_job_id].ens)
		player:update_level(windower.ffxi.get_player().main_job_level,windower.ffxi.get_player().sub_job_level)
	end
	player:load_hotbar()
   	ui:load_player_hotbar(player:get_hotbar_info())
	
end


-- change active hotbar --
function change_active_hotbar(new_hotbar)
    player:change_active_hotbar(new_hotbar)
end

--------------------
-- Addon Commands -- --
--------------------

-- command to set an action in a hotbar --
function set_action_command(args)
    player:insert_action(args)
    reload_hotbar()
end

function flush_old_keybinds()
    for i=1,ui.hotbar.rows,1 do
        for j=1,ui.hotbar.columns,1 do
            windower.send_command('htb delete f '..i..' '..j)
        end
    end
    for i=1,ui.hotbar.rows,1 do
        for j=1,ui.hotbar.columns,1 do
            windower.send_command('htb delete battle '..i..' '..j)
        end
    end
end


-----------------
-- Bind Events --
-----------------

-- ON LOGOUT --
windower.register_event('logout', function()
	coroutine.sleep(3)
	if windower.ffxi.get_player() == nil then
		windower.send_command('lua reload xivhotbar2')
		ui:hide()
		keyboard:unbind_keys(theme_options.rows, theme_options.columns)		
    end
end)


local function save_hotbar(hotbar, index)
	if index <= theme_options.rows then
		local x, y = box:get_pos(index)
		hotbar.OffsetX = x
		hotbar.OffsetY = y
	end
end


local function print_help()
	log("Commands:")
	log("move: Enables moving the hotbars by dragging them, also writes the changes to settings.xml if used again.")
	log("reload: Reloads the hotbar, if you have made changes to the hotbar-file, this is faster for loading.")
	log("Dependencies:")
	log("shortcuts: Used for weapon skills.")
end




-- ON COMMAND --
windower.register_event('addon command', function(command, ...)
    command = command and command:lower() or 'help'
    local args = {...}

    if command == 'reload' then
		if ui.theme.dev_mode then log('Reloading Hotbar.') end
        reload_hotbar()
	elseif command == 'release' then --Custom change to release pet 
		windower.chat.input('/pet release <me>') -- Need to us ct 
		
	elseif command == 'set' then
        set_action_command(args)
	elseif command == 'help' then
		print_help()
    elseif command == 'mount' then
        local player_mount = windower.ffxi.get_player()
        for k=1,32 do 
            if player_mount.buffs[k] == 252 then
                windower.chat.input('/dismount')
                return
            end
        end
        if args[1] == nil then 
            windower.chat.input('/mount crab <me>')
        else
            windower.chat.input('/mount '..args[1]..' <me>')
        end
	elseif command == 'summon' then
		local avatar_id = player:determine_summoner_id(args[1])
		if (avatar_id == 0) then
			print("Error, couldn't find avatar '"..args[1].."'... Unable to load actions for it.")	
		end
        windower.chat.input('/ma '..args[1]..' <me>')
    elseif command == 'execute' then
        change_active_hotbar(tonumber(args[1]))
        if tonumber(args[2]) <= theme_options.columns then 
			trigger_action(tonumber(args[2]))
        end
    elseif command == 'reload' then
		print("Reload 2") 
        flush_old_keybinds()
        bind_keys()
        player:load_hotbar()
	elseif command == 'add' then
		player:insert_action(args)
	elseif command == 'move' then
		state.demo = not state.demo
		if state.demo then
			log("Layout mode enabled!") 
			log("Click, then drag an action onto another slot to change its location.")
			log("Click between the rows, then drag to move the hotbars.")
			log("To save the changes, type '//htb move' then hit enter.")
            print('XIVHOTBAR2: Layout mode enabled')
			box:enable()
		else
			save_hotbar(settings.Hotbar.Offsets.First, 1)
			save_hotbar(settings.Hotbar.Offsets.Second, 2)
			save_hotbar(settings.Hotbar.Offsets.Third, 3)
			save_hotbar(settings.Hotbar.Offsets.Fourth, 4)
			save_hotbar(settings.Hotbar.Offsets.Fifth, 5)
			save_hotbar(settings.Hotbar.Offsets.Sixth, 6)

			config.save(settings)
            print('XIVHOTBAR2: Layout mode disabled, writing new positions to settings.xml.')
			box:disable()
		end
    end
end)


-- ON KEY --
windower.register_event('keyboard', function(dik, flags, blocked)
    if ui.hotbar.ready == false or windower.ffxi.get_info().chat_open then
        return
    end

    if ui.hotbar.hide_hotbars then
        return
    end

    if dik == theme_options.controls_battle_mode and flags == true then
        toggle_environment()
    end
end)


local current_hotbar = -1
local current_action = -1



local function mouse_hotbars(type, x, y, delta, blocked)

	return_value = false

	if not ui.hotbar.hide_hotbars then
		if type == 1 then -- Mouse left click
			local hotbar, action = ui:hovered(x, y)
			if(action ~= nil) then
				current_hotbar = hotbar
				current_action = action
				return_value = true
			else
				return_value = false
			end
		elseif type == 2 then -- Mouse left release
			if(current_action ~= -1) then
				local hotbar, action = ui:hovered(x, y)
				if(action ~= nil) then
					if (action == 100) then
						toggle_environment()
					elseif(hotbar == current_hotbar and action == current_action) then
						player:change_active_hotbar(hotbar)
						trigger_action(action)
					end
				end
				current_hotbar = -1
				current_action = -1
				return_value = true
			else
				return_value = false
			end
		elseif type == 0 then -- Mouse move
			local hotbar, action = ui:hovered(x, y)
			if(action ~= nil and hotbar ~= nil) then
				ui:light_up_action(x, y, hotbar, action, player:get_hotbar_info())
				return_value = true
			else
				ui:hide_hover()
				return_value = false
			end
		end
	end

	return return_value
end

-- Mouse Events
windower.register_event('mouse', function(type, x, y, delta, blocked)

	return_value = nil
	if state.ready == true and blocked == false then
		if state.demo == true then
			return_value = box:move_hotbars(type, x, y, delta, blocked)
		else
			return_value = mouse_hotbars(type, x, y, delta, blocked)
		end
	end

    return return_value
end)


-- ON PRERENDER --
windower.register_event('prerender',function()
    if ui.hotbar.ready == false then
        return
    end

    if ui.feedback.is_active then
        ui:show_feedback()
    end

    if ui.is_setup and ui.hotbar.hide_hotbars == false then
		moved_row_info = box:get_move_box_info()
		if (moved_row_info.swapped_slots.active == true) then
			player:swap_actions(moved_row_info.swapped_slots)
			ui:swap_icons(moved_row_info.swapped_slots)
			moved_row_info.swapped_slots.active = false
            ui:load_player_hotbar(player:get_hotbar_info())
		elseif (moved_row_info.row_active == true) then
			ui:move_icons(moved_row_info, ui.theme)
		elseif (moved_row_info.removed_slot.active == true) then
			player:remove_action(moved_row_info.removed_slot)
			moved_row_info.removed_slot.active = false
            ui:load_player_hotbar(player:get_hotbar_info())
		end
        ui:check_recasts(player:get_hotbar_info())
		ui:check_hover()
    end
end)


-- ON MP CHANGE --
windower.register_event('mp change', function(new, old)
	ui:update_mp(new)
end)


-- OM TP CHANGE --
windower.register_event('tp change', function(new, old)
	ui:update_tp(new)
end)


-- ON STATUS CHANGE --
windower.register_event('status change', function(new_status_id)
    -- hide/show bar in cutscenes --
    if ui.hotbar.hide_hotbars == false and new_status_id == 4 then
        ui.hotbar.hide_hotbars = true
        ui:hide()
    elseif ui.hotbar.hide_hotbars and new_status_id ~= 4 then
        ui.hotbar.hide_hotbars = false
        ui:show(player:get_hotbar_info())
    end
end)


-- ON LOGIN/LOAD --
windower.register_event('load', function()
	
    if windower.ffxi.get_player() ~= nil then
		defaults = require('defaults')
		settings = config.load(defaults)
		config.save(settings)
		-- Load theme options according to settings --
		theme = require('theme')
		theme_options = theme.apply(settings)
		local settings = config.load(defaults)
		config.save(settings)
        player.id = windower.ffxi.get_player().id
        initialize()
		coroutine.sleep(2)
	
			
	end
end)

windower.register_event('login', function()
    if windower.ffxi.get_player() ~= nil then
		windower.send_command('lua load xivhotbar2')
		defaults = require('defaults')
		settings = config.load(defaults)
		config.save(settings)
		-- Load theme options according to settings --
		theme = require('theme')
		theme_options = theme.apply(settings)
		local settings = config.load(defaults)
		config.save(settings)
        player.id = windower.ffxi.get_player().id
		
        initialize()


		--Coroutine to setup weaponswitching skills after packet 0x050 is received.
		ui.hotbar.hide_hotbars = true
		ui:hide()
		coroutine.sleep(6)
		inv_index = windower.ffxi.get_items().equipment.main
		if windower.ffxi.get_player().main_job == 'RNG' then
			inv_index = windower.ffxi.get_items().equipment.range
			if windower.ffxi.get_items().equipment.range == 0 then
				inv_index = windower.ffxi.get_items().equipment.main
			end
		end
		get_weapon_type(0,inv_index)
		reload_hotbar()
		ui.hotbar.hide_hotbars = false
	
		
			
	end
end)




windower.register_event('action', function(act)
	if state.ready == true then
		if (act.param == 211 or act.param == 212) then 
			if (act.actor_id == player.id and act.category == 0x06) then
				player:load_job_ability_actions(act.param)
				ui:load_player_hotbar(player:get_hotbar_info())
			end
		end
	end
end)





-- Reloads hotbar when zoning
windower.register_event('incoming chunk', function(id,data,modified)
	if id == 0x00A then
        zoning = true
	elseif id == 0x00B then
		ui.hotbar.hide_hotbars = true
		ui:hide()
	elseif zoning and id == 0x0AA then --0x0CA might also work here. 
		zoning = false
		if ui.theme.dev_mode then log("Zoning. Reloading Hotbar.") end
		ui.hotbar.hide_hotbars = false
		ui:show(player:get_hotbar_info())
		reload_hotbar()
	end
	
end)



windower.register_event('incoming chunk', function(id, original, modified, injected, blocked)
	if id == 0x050 then --Equip/Unequip
		local packet = packets.parse('incoming', original)
		local inv_index = packet['Inventory Index']
		local slot = packet['Equipment Slot']
		local inv_bag = packet['Inventory Bag']
		if windower.ffxi.get_player().main_job == 'RNG' then
			on_rng = true
		else
			on_rng = false
		end
		if slot == 0 or (slot == 2 and on_rng) then
			if inv_index ~= 0 and not zoning then
				if windower.ffxi.get_player().main_job == 'RNG' then
					inv_index = windower.ffxi.get_items().equipment.range
					if windower.ffxi.get_items().equipment.range == 0 then
						inv_index = windower.ffxi.get_items().equipment.main
					end
				end
				get_weapon_type(inv_bag,inv_index)
				first_0x050 = false
				return
			elseif inv_index == 0 and not zoning then
				if first_0x050 == true then
					if windower.ffxi.get_player().main_job == 'RNG' then
						inv_index = windower.ffxi.get_items().equipment.range
						if windower.ffxi.get_items().equipment.range == 0 then
							inv_index = windower.ffxi.get_items().equipment.main
						end
					end
					get_weapon_type(inv_bag,inv_index)
					first_0x050 = false
					return
				elseif first_0x050 == false then
					first_0x050 = true
					return
				end
			end
		end
	end

end)

function get_weapon_type(bag,index)
	new_skill_type = resources.items[windower.ffxi.get_items(bag, index).id].skill 
	if theme_options.enable_weapon_switching == true then
		if new_skill_type ~= nil then 
			player:update_weapon_type(new_skill_type)
			if ui.theme.dev_mode then log("Weapon Changed. Reloading Hotbar.") end
			
			reload_hotbar()
		elseif new_skill_type == nil then 
			player:update_weapon_type(new_skill_type)
			if ui.theme.dev_mode then log("Weapon Unequiped. Reloading Hotbar.") end
			reload_hotbar()
		end
	end
	old_skill_type = new_skill_type
	
end



windower.register_event('add item', 'remove item', function(id, bag, index, count)
	if state.ready == true then
		ui:update_inventory_count()
	end
end)




-- Updates on job change (moogle) and waits for abilities to be updated.
windower.register_event('incoming chunk', function(id,original,modified,injected,blocked)
	if state.ready == true then
		if id == 0x0AC and changing_job == true then
			changing_job = false
			if old_main ~= new_main or old_sub ~= new_sub then
				player:update_job(resources.jobs[new_main].ens, resources.jobs[new_sub].ens)
				if ui.theme.dev_mode then log("Changing Job (Moogle)") end
				reload_hotbar()
			end
		
		elseif id == 0x01B then 
			old_main = windower.ffxi.get_player().main_job_id
			old_sub = windower.ffxi.get_player().sub_job_id
			local packet = packets.parse('incoming', original)
			new_main = packet['Main Job']
			new_sub = packet['Sub Job']
			
			changing_job = true
		end
	end
end)



-- Reloads hotbar if new weaponskill is learned. 
windower.register_event('action message', function(actor_id, target_id, actor_index, target_index, message_id)

	if message_id == 45 then
		if actor_id == windower.ffxi.get_player().id then
			if ui.theme.dev_mode then log("Learned Weaponskill. Reloading Hotbar.") end
			reload_hotbar()
		end
	end
	
end)

-- Reloads hotbar if new spell is learned. 
windower.register_event('action message', function(actor_id, target_id, actor_index, target_index, message_id)

	if message_id == 23 then
		if actor_id == windower.ffxi.get_player().id then	
			if ui.theme.dev_mode then log("Learned Spell. Reloading Hotbar.") end
			reload_hotbar()
		end
	end
	
end)


-- Reloads hotbar when gaining or losing specified buffs
windower.register_event('gain buff', function(id)
	if id == 143 or id == 269 then -- Level Cap / Level Sync, Status Effect
		if ui.theme.dev_mode then log("Level Capped/Sync'd. Reloading Hotbar.") end
		reload_hotbar()
	elseif id == 55 then -- Astral Flow - Status Effect
		reload_hotbar()
	end
end)

windower.register_event('lose buff', function(id)
	if id == 269 then -- Level Cap / Level Sync - Status Effect
		log("Leve Sync'd Removed. Reloading Hotbar.")
		reload_hotbar()
	elseif id == 55 then -- Astral Flow - Status Effect
		reload_hotbar()
	end
end)


-- This event updates hotbar when you level up or delevel
windower.register_event('incoming chunk', function(id,original,modified,injected,blocked)
	
	if id == 0x02D then -- Kill Message
        mob_killed = true	
		old_level = windower.ffxi.get_player().main_job_level
	elseif mob_killed and id == 0x061 then -- Mob Killed and Char Stats Message
		
		local packet = packets.parse('incoming', original)
		--print("Packet: ", packet)
		new_level = packet['Main Job Level']
		
		S{'ws'}:contains('ws')
		if new_level ~= old_level then 
			if ui.theme.dev_mode then log("Leveled up! Reloading Hotbar.") end
			reload_hotbar()
		end
		
		mob_killed = false
    end
	
end)






----------------------------- PET EVENT STUFF ----------------------------------------------------

function reload_stance_hotbar()
	player:update_job(resources.jobs[windower.ffxi.get_player().main_job_id].ens, resources.jobs[windower.ffxi.get_player().sub_job_id].ens)
	player:update_level(windower.ffxi.get_player().main_job_level,windower.ffxi.get_player().sub_job_level)
	player:load_hotbar()
   	ui:load_player_hotbar(player:get_hotbar_info())
end

--This event is reloading hotbar if a pet dies or released
windower.register_event('incoming chunk', function(id,original,modified,injected,blocked)
	if state.ready == true then
		local packet = packets.parse('incoming', original)
		if id == 0x068 and pet_dead_update == true then -- Pet Status Packet Update
			if packet['Owner ID'] == player.id then -- If player.id and pet owner ID are the same
				if packet['Pet Index'] == 0 then -- If there is no pet. Meaning it died or was released.
					if ui.theme.dev_mode then log("Pet Died or was Released. Reloading Hotbar.") end
					pet_dead_update = false
				    reload_hotbar()
				end
			end
		elseif id == 0x068 then
			pet_dead_update = true
		end
	end	
end)

local function successful_summon(summon_name)
	coroutine.sleep(.1)
	local avatar_id = player:determine_summoner_id(summon_name) -- Gets the specifics summons id from the buff_table in action_manager
	player:load_job_ability_actions(avatar_id)
	ui:load_player_hotbar(player:get_hotbar_info())
end

--This event is confirming that pet summons cast are not cancel/interupted and pet was succesfully summoned before updating the hotbar with specific pet abilities
windower.register_event('incoming chunk', function(id,original,modified,injected,blocked)
	if state.ready == true then
		local packet = packets.parse('incoming', original)
		if id == 0x068 and no_pet == true then -- If the second pet update packet comes in
			if packet['Owner ID'] == windower.ffxi.get_player().id then -- If player.id and pet owner ID are the same
				if packet['Pet Index'] ~= 0 then -- If the pet has an index of non zero then pet summoned succesfully
					if ui.theme.dev_mode then log("Pet Summoned. Reloading Hotbar.") end
					successful_summon(packet['Pet Name']) 
				end
			end
			first_pet_update = false
			no_pet = false
			return
		elseif packet['Pet Index'] == 0 then
			no_pet = true
		end
	end	
end)



--- Reloads hotbar when using GM command. ** For development only ** 
windower.register_event('incoming chunk', function(id,original,modified,injected,blocked)
	if ui.theme.dev_mode then
		if id == 0x0AC and gm_command == true then
			if ui.theme.dev_mode then log("GM Command. Reloading Hotbar.", count) end
			gm_command = false
			reload_hotbar()
		end
	end
end)
windower.register_event('incoming text', function(text)
	if ui.theme.dev_mode then
		if string.find(text, "!changejob") or string.find(text, "!changesjob") then
			gm_command = true
		end
	end
end)
