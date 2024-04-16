-- SPAWN THE INSTANCE RESET NPC (beware, it deletes existing entries) IN GM ISLAND

-- SET @INSTANCE_RESET_NPC := 999991;

-- DELETE FROM `creature` WHERE `id` = @1v1_NPC_ENTRY;
-- INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
-- (3130775,   @INSTANCE_RESET_NPC, 1,  0,  0,  1,  1,  0,  0,  16226.2,    16257,  13.2022,    1.65007,    300,    0,  0,  5074,   0,  0,  0,  0,  0,  '', 0);

