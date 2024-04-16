-- DB update 2023_12_24_00 -> 2023_12_24_01
-- update various midsummer NPC spawns with sniffed values
DELETE FROM `creature` WHERE (`id1` IN (16817, 16818, 25697, 25710, 25754)) AND (`guid` IN (202768, 202862, 94855, 94856, 94857, 202750, 94858, 94859, 94860, 94861, 202734, 245704, 202735, 202736, 202737));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
-- 16817 'Festival Loremaster'
(202768, 16817, 530, 1, 1, 0, -3787.9111328125, -11506.0986328125, -134.600814819335937, 5.969026088714599609, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(202862, 16817, 0, 1, 1, 0, -8832.986328125, 862.3447265625, 98.96456146240234375, 0.296705961227416992, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(94855, 16817, 1, 1, 1, 0, 8697.384765625, 936.7188720703125, 14.6749267578125, 1.797689080238342285, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(94856, 16817, 530, 1, 1, 0, -1751.86669921875, 5333.408203125, -12.3448038101196289, 2.30383467674255371, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(94857, 16817, 0, 1, 1, 0, -4702.794921875, -1218.0499267578125, 501.74273681640625, 1.93731546401977539, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
-- 16818 'Festival Talespinner'
(202750, 16818, 530, 1, 1, 0, 9807, -7246.8203125, 26.21605491638183593, 5.672319889068603515, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(94858, 16818, 1, 1, 1, 0, -1042.9757080078125, 291.024322509765625, 135.6658477783203125, 2.338741064071655273, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(94859, 16818, 530, 1, 1, 0, -1752.97216796875, 5323.267578125, -12.3448047637939453, 4.136430263519287109, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(94860, 16818, 0, 1, 1, 0, 1824.94580078125, 224.4239349365234375, 60.3980560302734375, 1.850049018859863281, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(94861, 16818, 1, 1, 1, 0, 1918.1146240234375, -4336.3505859375, 21.28496551513671875, 0.139626339077949523, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
-- 25697 'Luma Skymother'
(202734, 25697, 547, 3, 1, 0, -92.4571914672851562, -110.664161682128906, -2.86675882339477539, 2.408554315567016601, 7200, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
-- 25710 'Numa Cloudsister'
(245704, 25710, 547, 3, 1, 0, 131.4105682373046875, -120.632652282714843, -1.50722658634185791, 4.206243515014648437, 7200, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
-- 25754 'Earthen Ring Flamecaller'
(202735, 25754, 547, 3, 1, 0, -110.19451904296875, -116.621482849121093, -3.25569367408752441, 0.104719758033752441, 7200, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(202736, 25754, 547, 3, 1, 0, -112.209869384765625, -120.209037780761718, -2.65799570083618164, 5.183627605438232421, 7200, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(202737, 25754, 547, 3, 1, 0, -93.1847915649414062, -115.92059326171875, -2.69253182411193847, 3.804817676544189453, 7200, 0, 0, 0, 0, 0, "", 50172, 1, NULL);

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` IN (16817, 16818, 25697, 25710, 25754)));
INSERT INTO `game_event_creature` (SELECT 1, `guid` FROM `creature` WHERE `id1` IN (16817, 16818, 25697, 25710, 25754));