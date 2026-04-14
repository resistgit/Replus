# Replus

A few Quality of Life for Classic WoW.

## Install

Download from CurseForge: https://www.curseforge.com/wow/addons/replus

### Manual install

- Download from https://github.com/resistgit/Replus/archive/refs/heads/master.zip
- Unzip and place at `AddOns` folder
- Remove the `-master` suffix

## Features

- Announce on important skills miss
- Announce on interrupt
- Auto track minerals/herbs for vanilla
- Blue Shamans for vanilla
- Chat's short channel names, able to copy URLs
- Mana/Energy tick for default UI
- Target health for default UI
- Melee check, out of range and/or not attacking
- Smart macros for Food, Drink and Healthstone, to use the best available
- Status bar with FPS, latency, durability, current speed, and XP/h

### Equipment Manager helper

There are a few commands to help using the native [Equipment Manager](https://warcraft.wiki.gg/wiki/Equipment_Manager):

- `/showsets` - Show all sets
    - aliases: `/getsets`, `/allsets`
- `/delset name` - Delete a set
- `/saveset name` - Save current gear as a set
- `/saveslots name slots` - Save passed slots (separated by comma) as a set
- `/saveweapons name` - Save current weapons as a set
    - aliases: `/savew`, `/savewp`, `/saveweapon`
    - syntax sugar for `/saveslots name 16,17`
- `/equipset name` - Equip a set (native command)

## License

[MIT](https://github.com/resistgit/Replus/blob/master/LICENSE)

Copyright (c) 2025-present, Resist
