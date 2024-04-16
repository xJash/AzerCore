# RaidTeleporter
## Description
This module provides a script class which can be used to create instance wide teleports with minimal effort.
It works by teleporting a player to coordinates that can be obtained by a gm account using .gps.
It doesn't require any SQL queries as it is a script but i have provided SQL queries to create some teleporters.
Please check the provided ranges do not overlap anything in your current database.
I have also produced a small C++ program that can be used to generate the queries that are used by the teleporters.
I've currently provided teleports up to ZA in tbc.

[SQL builder](https://github.com/StealthyApe/Raid-Teleporter-SQL-Builder/tree/main "Github page")

## How to use ingame
If you've used the default SQL queries or the ones created by the other program you'll have a teleporter at the entrance of the raids and one at every boss.
The teleports available will depend on the mode selected in config. 

#### Progression mode will provide a teleport to anyboss that the group has killed.
#### Speed farm mode will provide a teleport to the next boss in sequence, for those that hate clearing trash.
#### Target farm mode provides a teleport to every boss in the instance, handy if you only need to farm one boss.


Requirements

AzerothCore v4.0.0+
Installation
1) Simply `git clone https://github.com/StealthyApe/RaidTeleporter.git` the module under the `modules` directory of your AzerothCore source or copy paste it manually.
2) Import the SQL manually to the right Database (auth, world or characters)
3) Re-run cmake and launch a clean build of AzerothCore.
Edit the module's configuration (optional)
If you need to change the module configuration, go to your server configuration directory (where your worldserver or worldserver.exe is), copy RaidTeleporter.conf.dist to RaidTeleporter.conf and edit that new file.

Credits
Covertmonkey: Find me in my [discord](https://discord.gg/zHTqRY4EAQ "Covertmonkey's Modules") 

AzerothCore: repository - website - discord chat community
