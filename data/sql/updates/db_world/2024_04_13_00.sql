-- DB update 2024_04_07_00 -> 2024_04_13_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |256 WHERE `entry` = 17818;
