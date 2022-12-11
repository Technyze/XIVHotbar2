
-- Load and initialize the include file.
 xivhotbar_keybinds_job['Base'] = {
     
  -- Hotbar #1
  
	{'battle 1 5', 'macro','input /equip ammo "Crossbow Bolt";input /ra <t>','','Bolt','ra'},
  {'battle 1 6', 'macro','input /equip ammo "Acid Bolt";input /ra <t>','','Acid','ra'},
   
	
    
  -- Hotbar #2 
  {'battle 2 3', 'ja', 'Provoke', 't', 'Provoke'},
  {'battle 2 4', 'ja', 'Provoke', 'stnpc', 'Voke ST'},
	
  -- Hotbar #3
  
  {'battle 3 1', 'ja', 'Berserk', 'me', 'Berserk'},
  {'battle 3 2', 'ja', 'Warcry', 'me', 'Warcry'},
  {'battle 3 3', 'ja', 'Aggressor', 'me', 'Aggress'},
	{'battle 3 12', 'ja', 'Mighty Strikes', 'me', 'MightyStrk','cog'},
  

  -- Hotbar #4
  {'battle 4 1', 'ja', 'Defender', 'me', 'Defender'},
	
	
     
}


xivhotbar_keybinds_job['NIN'] = {
  -- Hotbar #2 
  {'battle 2 1', 'ma', 'Utsusemi: Ichi', 'me', 'Ichi'},
  {'battle 2 2', 'ma', 'Utsusemi: Ni', 'me', 'Ni'},
  
}
xivhotbar_keybinds_job['RNG'] = {
  
  {'battle 2 1', 'ja', 'Sharpshot', 'me', 'Sharpshot'},
}
xivhotbar_keybinds_job['MNK'] = {
  
  {'battle 2 1', 'ja', 'Boost', 'me', 'Boost'},
}
xivhotbar_keybinds_job['Great Axe'] = {
  {'battle 1 1', 'ws', 'Shield Break', 't', 'Shield', 'ws'},
  {'battle 1 2', 'ws', 'Sturmwind', 't', 'Sturm', 'ws'},
}
xivhotbar_keybinds_job['Axe'] = {
  
}
xivhotbar_keybinds_job['Sword'] = {
 
  {'battle 1 1', 'ws', 'Savage Blade', 't', 'Savage', 'ws'},
  {'battle 1 2', 'ws', 'Fast Blade', 't', 'Fast', 'ws'},
  {'battle 1 3', 'ws', 'Spirits Within', 't', 'Spirits', 'ws'},
  {'battle 1 4', 'ws', 'Circle Blade', 't', 'Circle', 'wsaoe'},

}


return xivhotbar_keybinds_job
