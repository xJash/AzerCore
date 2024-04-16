-- DB update 2021_09_19_03 -> 2021_09_19_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_19_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_19_03 2021_09_19_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631616272860535120'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631616272860535120');

UPDATE `creature` SET `movementtype`= 1, `wander_distance` = 5 WHERE `GUID` IN (56058, 56059, 56086, 56127, 56160, 56162, 56125, 56123, 56166, 56150) AND `id` IN (15654, 15656, 15658);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_19_04' WHERE sql_rev = '1631616272860535120';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
