-- DB update 2021_01_22_00 -> 2021_01_23_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_22_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_22_00 2021_01_23_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1609539037767254100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609539037767254100');

DELETE FROM `spell_script_names` WHERE `spell_id` = 35201 AND `ScriptName`='spell_gen_paralytic_poison';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(35201, 'spell_gen_paralytic_poison');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
