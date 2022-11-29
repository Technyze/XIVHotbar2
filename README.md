## Introduction

This is a modified version of xivhotbar made by SirEdeonX and Akirane. I fell in love with this addon but there were various little bugs I wanted to fix and several features I wanted to add. One thing led to another and I ended up fixing and adding a lot. My initial intenton was to fix and add a few things for personal use, but now that I have added so much I want to make it public and see if anyone else likes what I have done. 

Additionally, I also wanted to have this public so that it could get it approved for a private server [HorizonXI.com](https://horizonxi.com/) . Go Check it out! 

I pretty much exclusively play 75 cap era private servers, and thus many design decisions have this in mind. To this point I have only tested this addon on private servers so there may be issues if this is used on retail. However, most of the private servers I have played on use the retail client.  

## Why XIVhotbar-plus? 

While a large portion of this addon is the original code by Edeon and Akirane. I have made some major features 
(see below) that have no enable/disable toggle and are forced. Therefore, previous xivhotbar users might find that this
addon is not for them.

## Getting Started

Most of the initial setup and installation for this addon remains the same. Please refer to [Akirane's XIVHotbar Documentation](https://github.com/Akirane/XIVHotbar)


## UI Changes 

The UI and setting up the UI remains basically unchanged and should work as before. Except:

- Added a toggle to remove/hide the numbers next to each hotbar. (Adjustable in settings.xml by HideHotbarNumbers)
- Added a toggle to remove/hide environment(page) numbers. (Adjustable in settings.xml by HideEnvironmentNumbers)
- Added the ability to customize(Size,Position,Offset,Opacity) the environment numbers If environment numbers are not hidden. (Adjustable in settings.xml in the Environment section). If CustomSettings is false in the environment section then environment numbers will attach themself to the specified hotbar based on the HookOntoBar variable in the environment section.
- Added the ability to customize (Size,Opacity,Position) of inventory count if HideInventoryCount is set to false. (Adjustable in settings.xml in the Inventory section)
- Added the ability to individually adjust the font size of the MP Cost Text (CostSize), Hotkeys text (KeysSize), Recast timer (Recast Size). (Adjustable in settings.xml in the Texts Section)
- Shifted the name of spells to be below each hotbar slot instead of on the bottom of each slot. I found this looked better and easier to read. 


## Level sync and level cap feature

This is one of the main features I wanted to add. Often on era private servers you are level syncing in parties or in level capped zones. It can be a bit annoying to constantly remember what spells and abilities you have available to you under capped level conditions. Thus, when being level sync'd or being in a level capped zone, any skill, ability, or weaponskill that is no longer available to you will be removed from the hotbar until the sync conditions are removed. 


Level 75 RDM zoning into Promyvion-Holla (This also works with level sync in parties)

![Level Capped Zone](/images/readme/LevelCappedZone.gif)

Please note that Dia II (31) changes to Dia (1). This is explained below in the "Tiered Spells Sharing Hotbar Slot" section.

## Unlearned Spells:

Previously spells setup on the hotbar in a JOB.lua file that were not yet learned ingame would still show up on the hotbar an appear lite up and useable. Now in this scenario the spell will appear dimmed until they are learned. Upon learning a spell the spell will immediately appear useable. 

Using a scroll of Cure III. 

![Learning Spell](/images/readme/LearningSpell.gif)


## Tiered Spells Sharing Hotbar Slot:

Another feature I wanted to add was having one hotbar slot hold multiple spells which would display depending on level. For example, Dia is a commonly used spell, but once Dia II is acquired it is not used quite as often. Thus, when setup properly in the JOB.lua file Dia II will take priority over the slot Dia was originally once you reach the appropriate level for Dia II and Dia II is learned. This works seamlessly with the level sync feature above as well.

In order to set this up simply add both spells to the JOB.lua file with the same slot specified {battle 4 11} in Descending order as seen below.
 
![Tiered Spells](/images/readme/tieredspells.png)

In the case that a player is high enough level to use a higher tier spell, but has not learned that spell yet the lower tier spell will still appear on a hotbar with an asterisk appended to the spell title. This asterisk indicates that a spell/ability setup on this slot has not been learned yet. This asterisk will also appear if a lower tier spell is also not learnerd yet. For example the player has learned Dia II but has not learned Dia yet. The slot title/name will appear as "Dia II*" indicting there is a spell to learn in this slot. 



## Summoner:

I ran into several issues with the Summoner hotbar that was added to this Hotbar such as the summons spells getting out of sync and other various things.

Now, a summon's abilities will only show up on the hotbar when the summon is succesfully summoned. Additionally, the abilities will remove themself from the hotbar when the pet is released, dies or insufficient mp. Also, pet commands release, attack etc do not appear on hotbar unless a summon is present.

![Summoning](/images/readme/summoning.gif)

All Blood Pact: Ward abilities share a cooldown and All Blood Pact: Rage abilities share a cooldown.

## Weaponswitching and Weaponskills:

The weaponswitching feature mostly worked but did run into some issues. It mostly works now with the added benefit of weaponskills not showing up on hotbar if they have not been learned yet. Occassionally weapons and hotbar weaponskils will get out of sync. Easy fix for this is to unequip the weapon and reequip it.

## Macros/Scripts inside JOB.lua:

## Easy Workarounds with Glitches:

If you run into any glitches with the hotbar. First troubleshooting step is to reload the hotbar (/htb reload). After that reload the adddon (//lua reload xivhotbar-plus).

If you run into issues with weaponswitching: Unequip weapon and reequip it. 

Otherwise please report the bug with as much details as possible so I can try to replicate it!


## Bug Fixes

- Settings the input type field in the JOB.lua to 'ws' now works properly. I had alot of issues with this working previously.
- XIVhotbar now properly unloads and reloads when relogging or switching characters. Instead of loading a second hotbar ontop of itself


								--- ADDED FEATURES --- 
-- When Logging out to switch characters xivhotbar automatically reloads so that two sets of hots bars don't
-- Changed hover icon to the ffxiv/theme icon
-- Added opaqness to spells/abilities that cant be used, like how weaponskills are.
-- Added opaqness to spells that arent learned yet
-- Fixed spells not dimming when insufficient mp
-- Added back slot MP cost is is disabled by default
-- Custom Inventory Posisition and Size
-- Hide Hotbar Numbers
-- Hide Environment Numbers and also Customize location/size
-- When using weaponswitching, weaponskills that have not been learned yet will not show up on hotbar.
-- Changed the default icon that shows up when using the macro keyword.
-- Added a devmode to settings.xml which prints varios log messages to chat when hotbar reloads

								--- TO BE DONE --- 




		

								--- KNOWN ISSUES ---

-- When logging in the game thinks you are equiping a new weapon because it loads your gear. Functionally this shouldn't affect anything though.
-- If playing RNG or COR XIVHOTBAR is set to priortize weapon changes to the range slot over main slot.
-- Weaponswitching skills show up after a delay when logging in.