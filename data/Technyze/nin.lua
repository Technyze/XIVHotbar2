
-- Load and initialize the include file.
 xivhotbar_keybinds_job['Base'] = {
     
  -- Hotbar #1
    
	  {'battle 1 4', 'input', '/ra <t>', '', 'RA', 'ffxiv/nin/fuma_shuriken'},
   
	
    
  -- Hotbar #2 
    {'battle 2 1', 'ma', 'Utsusemi: Ni', 'me', 'Ni','ffxiv/nin/ninjutsu'},
    {'battle 2 2', 'ma', 'Utsusemi: Ichi', 'me', 'Ichi','ffxiv/nin/ninjutsu'},
	
  -- Hotbar #3
	
  
  -- Hotbar #4
	
     
}

xivhotbar_keybinds_job['WAR'] = {

	-- Hotbar #2 
	  {'battle 2 3', 'ja', 'Provoke', 't', 'Provoke'},
    {'battle 2 4', 'ja', 'Provoke', 'stnpc', 'Voke ST'},
	  {'battle 2 5', 'ja', 'Berserk', 'me', 'Berserk'},
    {'battle 2 6', 'ja', 'Defender', 'me', 'Defender'},
    {'battle 2 7', 'ja', 'Warcry', 'me', 'Warcry'},
}

xivhotbar_keybinds_job['Katana'] = {

	-- Battle
	{'battle 1 1', 'ws', 'Blade: Rin', 't', 'Rin'},
	{'battle 1 2', 'ws', 'Blade: Retsu', 't', 'Retsu'},
	
}
xivhotbar_keybinds_job['Sword'] = {

	-- Battle
	{'battle 1 1', 'ws', 'Fast Blade', 't', 'Fast Blade'},
	{'battle 1 2', 'ws', 'Burning Blade', 't', 'Burning Blade'},
	{'battle 1 3', 'ws', 'Flat Blade', 't', 'Flat Blade'},
	
	
}



return xivhotbar_keybinds_job
