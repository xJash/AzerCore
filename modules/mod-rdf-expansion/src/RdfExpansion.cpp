#include "ScriptMgr.h"
#include "Config.h"

// Add player scripts
class RdfExpansion : public PlayerScript
{
public:
    RdfExpansion() : PlayerScript("RdfExpansion") { }

    void OnQueueRandomDungeon(Player* /* player */, uint32& rDungeonId) override
    {
        // Values from LFGDungeons.dbc
        constexpr const uint32 RDF_CLASSIC = 258;
        constexpr const uint32 RDF_THE_BURNING_CRUSADE = 259;
        constexpr const uint32 RDF_THE_BURNING_CRUSADE_HEROIC = 260;
        constexpr const uint32 RDF_WRATH_OF_THE_LICH_KING = 261;
        constexpr const uint32 RDF_WRATH_OF_THE_LICH_KING_HEROIC = 262;

        // Set the dungeon ID based on the player's selection
        // Here, we're allowing dungeons from all expansions to be queued simultaneously
        switch (rDungeonId)
        {
        case RDF_CLASSIC:
        case RDF_THE_BURNING_CRUSADE:
        case RDF_THE_BURNING_CRUSADE_HEROIC:
        case RDF_WRATH_OF_THE_LICH_KING:
        case RDF_WRATH_OF_THE_LICH_KING_HEROIC:
            // Keep the dungeon ID as is
            break;
        default:
            // Default to Classic if dungeon ID is invalid
            rDungeonId = RDF_CLASSIC;
            break;
        }
    }
};

// Add all scripts in one
void AddRdfExpansionScripts()
{
    new RdfExpansion();
}
