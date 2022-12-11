
-- Load and initialize the include file.
 xivhotbar_keybinds_job['Base'] = {
     
  -- Hotbar #1
  {'battle 1 1', 'ma', 'Cure', 'stpc', 'Cure1'},
  {'battle 1 2', 'ma', 'Cure II', 'stpc', 'Cure2'},
  {'battle 1 3', 'ma', 'Cure III', 'stpc', 'Cure3'},
  {'battle 1 4', 'ma', 'Cure IV', 'stpc', 'Cure4'},
  {'battle 1 5', 'ma', 'Flash', 'stnpc', 'Flash'},
  


  
 
	{'battle 1 12', 'input', '//exec pld/cookierest.txt', '', 'Cookie','item'},
    
  -- Hotbar #2 
	
	
  -- Hotbar #3
  {'battle 3 1', 'ja', 'Shield Bash', 't', 'Sh. Bash'},
  {'battle 3 2', 'ja', 'Cover', 'stpc', 'Cover'},

  {'battle 3 12', 'ja', 'Invincible', 'me', 'Invincible','2hr'},

  -- Hotbar #4
	{'battle 4 1', 'ja', 'Sentinel', 'me', 'Sentinel'},
  {'battle 4 2', 'ja', 'Rampart', 'me', 'Rampart'},
  {'battle 4 3', 'ma', 'Reprisal', 'me', 'Reprisal'},
  {'battle 4 5', 'ja', 'Holy Circle', 'me', 'HolyCirc'},

  {'battle 4 10', 'ma', 'Raise', 'stpc', 'Raise'},
  --------------------------------------------------------------------------------------
  {'battle 4 11', 'ma', 'Protect IV', 'stpc', 'Protect4'},
  {'battle 4 11', 'ma', 'Protect III', 'stpc', 'Protect3'},
  {'battle 4 11', 'ma', 'Protect II', 'stpc', 'Protect2'},
  {'battle 4 11', 'ma', 'Protect', 'stpc', 'Protect'},
  --------------------------------------------------------------------------------------
  {'battle 4 12', 'ma', 'Shell III', 'stpc', 'Shell3'},
  {'battle 4 12', 'ma', 'Shell II', 'stpc', 'Shell2'},
  {'battle 4 12', 'ma', 'Shell', 'stpc', 'Shell'},

  -- Hotbar #5
  {'battle 5 1', 'input', '/ra <t>', '', 'RA','ffxiv/brd/repelling_shot'},
  {'battle 5 2', 'ma', 'Banish', 't', 'Banish'},
  {'battle 5 3', 'ma', 'Banish II', 't', 'Banish2'},
  {'battle 5 4', 'ma', 'Holy', 't', 'Holy'},
  -- Hotbar #6
     
     
}


xivhotbar_keybinds_job['NIN'] = {
  -- Hotbar #2 
  {'battle 2 2', 'ma', 'Utsusemi: Ichi', 'me', 'Ichi'},
  {'battle 2 1', 'ma', 'Utsusemi: Ni', 'me', 'Ni'},
  
}

xivhotbar_keybinds_job['WAR'] = {
  -- Hotbar #2 
  {'battle 2 1', 'ja', 'Berserk', 'me', 'Berserk'},
  {'battle 2 2', 'ja', 'Warcry', 'me', 'Warcry'},
  {'battle 2 3', 'ja', 'Provoke', 't', 'Provoke'},
  {'battle 2 4', 'ja', 'Provoke', 'stnpc', 'Voke ST'},
  {'battle 2 5', 'ja', 'Defender', 'me', 'Defender'},
  
}

xivhotbar_keybinds_job['THF'] = {

  -- Hotbar #2 (ALT 1-0)
    {'battle 2 1', 'ja', 'Sneak Attack', 'me', 'Sneak'},
    {'battle 2 2', 'ja', 'Trick Attack', 'me', 'Trick'},
    {'battle 2 3', 'ja', 'Steal', 't', 'Steal'},
    {'battle 2 4', 'ws', 'Cyclone', 't', 'cyc', 'wsaoe'},
    {'battle 2 5', 'ja', 'Flee', 'me', 'Flee'}, 

}


xivhotbar_keybinds_job['WHM'] = {
 
  -- Hotbar #2 (ALT 1-0)
  {'battle 2 1', 'ma', 'Poisona', 'stpc', 'Poisona'},
  {'battle 2 2', 'ma', 'Paralyna', 'stpc', 'Paralyna'},
  {'battle 2 3', 'ma', 'Blindna', 'stpc', 'Blindna'},
  {'battle 2 4', 'ma', 'Silena', 'stpc', 'Silena'},
  {'battle 2 5', 'ma', 'Cursna', 'stpc', 'Cursna'},
  {'battle 2 6', 'ma', 'Viruna', 'stpc', 'Viruna'},
  {'battle 2 7', 'ma', 'Erase', 'stpc', 'Erase'},
  {'battle 2 8', 'ja', 'Divine Seal', 'me', 'Div.Seal'},
  {'battle 2 9', 'ma', 'Curaga II', 'stpc', 'Curaga2'},
  {'battle 2 10', 'ma', 'Reraise', 'me', 'Reraise'},
  {'battle 2 11', 'ma', 'Protectra II', 'stpc', 'Protectra2'},
  {'battle 2 12', 'ma', 'Shellra II', 'stpc', 'Shellra2'},
 
 
}
xivhotbar_keybinds_job['Sword'] = {
  -- Hotbar #1 
  {'battle 1 6', 'ws', 'Savage Blade', 't', 'Savage'},
  {'battle 1 7', 'ws', 'Vorpal Blade', 't', 'Vorpal'},
  {'battle 1 8', 'ws', 'Spirits Within', 't', 'Spirits'}, 
  {'battle 1 9', 'ws', 'Circle Blade', 't', 'Circle',}, 
  
}

xivhotbar_keybinds_job['Great Sword'] = {
  -- Hotbar #1 
  {'battle 1 6', 'ws', 'Hard Slash', 't', 'Hard'},
  {'battle 1 7', 'ws', 'Power Slash', 't', 'Power'},
  {'battle 1 8', 'ws', 'Sickle Moon', 't', 'Sickle'}, 
  {'battle 1 9', 'ws', 'Shockwave', 't', 'Shock'}, 
  
}


return xivhotbar_keybinds_job
