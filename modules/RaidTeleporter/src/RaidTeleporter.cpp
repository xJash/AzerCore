#include "RaidTeleporter.h"
#include "iostream"

enum RaidID {
	MOLTEN_CORE = 409,
	BLACKWING_LAIR = 469,
	ONYXIAS_LAIR,
	ZULGURUB = 309,
	RUINS_OF_AHNQIRAJ = 509,
	TEMPLE_OF_AHNQIRAJ = 531,
	NAXXRAMAS_VANILLA,
	KARAZHAN = 532,
	GRUULS_LAIR = 565,
	MAGTHERIDONS_LAIR = 544,
    SERPENTSHRINE_CAVERN = 548,
	THE_EYE = 550,
    BLACK_TEMPLE = 564,
	HYJAL,
	ZULAMAN = 568,
	SUNWELL_PLATEAU
};

enum TeleMode{
    PROGESSION = 0,
    SPEED = 1,
    TARGET =2
};

#define DONE 3


bool RaidTeleporterScript::OnGossipHello(Player* player, GameObject* go) {
	ZonePrep(go); // prepares the object by working out which zone it is in
	uint32 gosMenuId = go->GetGOInfo()->GetGossipMenuId();
    if(sConfigMgr->GetOption<bool>("RaidTeleporter.Enable",false)){
	    if (InstanceScript* instance = go->GetInstanceScript()) {
            uint8 mode = sConfigMgr->GetOption<uint8>("RaidTeleporter.Mode",false);
            if (teleLocations.size() < 1){ // final safety catch
                return true;
            }
            AddGossipItemFor(player, gosMenuId, 0, 0 , 0,sConfigMgr->GetOption<uint32>("RaidTeleporter.Cost",false)); // always provide a teleport to the entrance
            std::string cost = CopperToString(sConfigMgr->GetOption<uint32>("RaidTeleporter.Cost",false));
            player->SendSystemMessage(cost); // sends cost into chat
            int skipper = 0; // total amount of values skipped
            int timeSinceLastlegal = 0; // shift since last legal shift
            bool targetskip = false; // to level speed farm know what is skipped
            switch(mode){
                // iterator is equal to offset + 1 to stop a potential underflow error
                // the value you saved to the gossip option is always iterator - offset +1
                // the +1 is to offset the first teleport option always being the entrance and handles seperatetly
                // skipper is used to handle neccesary skip when there's non boss information listed in bosses 
                // by subtracting it from the sent value this maintains the sync
                // potentially negates the need for offset
                case PROGESSION:{
                    for (int i = 0; i < teleLocations.size() + ToSkip.size(); i++) { // offset is needed as some boss lists don't start at 0
                        if(ToSkip.size() > 0 && i == 0){ //Handles the instances that start at 1 instead of 0
                            if(ToSkip[0] == 0){
                                i++;
                                skipper++;
                            }
                        }
                        if(CheckForSkip(i)){//adds one to skipper 
                            skipper++;
                        }
			            else if (instance->GetBossState(i) == DONE) {
				            AddGossipItemFor(player, gosMenuId, i + 1 - skipper, i + 1 - skipper , 0,sConfigMgr->GetOption<uint32>("RaidTeleporter.Cost",false)); // sends the index to select
			            }
		            }
                    break;
                }
                case SPEED:{
                    AddGossipItemFor(player, gosMenuId,1, 1, 0,sConfigMgr->GetOption<uint32>("RaidTeleporter.Cost",false)); // creates the first entry then correctly works
                    for (int i = 0; i < teleLocations.size() + ToSkip.size()+1+skipper; i++) { // offset is needed as some boss lists don't start at 
                        if(ToSkip.size() > 0 && i == 0){ //Handles the instances that start at 1 instead of 0
                            if(ToSkip[0] == 0){
                                i++;
                                skipper++;
                           }
                        }
                        if(CheckForSkip(i)){//adds one to skipper 
                            skipper++;
                            timeSinceLastlegal++;
                            targetskip = true;
                        }
			            else if (instance->GetBossState(i-1-timeSinceLastlegal) == DONE && targetskip) { // checks if the previous boss is dead
				            AddGossipItemFor(player, gosMenuId, i + 1 - skipper, i + 1 - skipper, 0,sConfigMgr->GetOption<uint32>("RaidTeleporter.Cost",false)); // sends the index to select
                            targetskip = false;
                            timeSinceLastlegal = 0;
			            }
                        else if (instance->GetBossState(i-1-timeSinceLastlegal) == DONE && !targetskip) { // checks if the previous boss is dead
				            AddGossipItemFor(player, gosMenuId, i + 1 - skipper, i + 1 - skipper, 0,sConfigMgr->GetOption<uint32>("RaidTeleporter.Cost",false)); // sends the index to select
			            }
                    }
                    break;
                }
                case TARGET:{
                    for (int i = 0; i < teleLocations.size() + ToSkip.size(); i++) { // offset is needed as some boss lists don't start at 0
                        if(CheckForSkip(i)){//adds one to skipper 
                            skipper++;
                        }
                        else{
				            AddGossipItemFor(player, gosMenuId, i + 1 - skipper, i + 1 - skipper , 0,sConfigMgr->GetOption<uint32>("RaidTeleporter.Cost",false)); // sends the index to select
                        }
		            }
                    break;
                }
            }

		    
	    }
    }
	SendGossipMenuFor(player, player->GetGossipTextId(go), go->GetGUID());
	return true;
}

bool RaidTeleporterScript::OnGossipSelect(Player* player, GameObject* go, uint32 sender, uint32 action) // sender provides the index of the bosss
{
    ClearGossipMenuFor(player);
    CloseGossipMenuFor(player);
    if(player->IsInCombat()){
        player->SendSystemMessage("No Teleporting in combat!");
        return true; // stops it working if player is in combat
    }
    uint32 cost = sConfigMgr->GetOption<uint32>("RaidTeleporter.Cost",false);
    if(cost > player->GetMoney()) return true; // checks if player has enough money in theory this check is redundant
    else {
        player->TeleportTo(teleLocations[sender].map,teleLocations[sender].x,teleLocations[sender].y,teleLocations[sender].z,teleLocations[sender].o);
        player->SetMoney(player->GetMoney() - cost); // takes the fee as the gossip item will only take what is in the databse despite claims otherwise
        return true;
    }
    
}



void RaidTeleporterScript::ZonePrep(GameObject* go) {

	uint32 raid = go->GetMapId();
	switch (raid) {
    case MOLTEN_CORE:{
        teleLocations = RaidTeleLocations::MC;
        break;
    }
    case BLACKWING_LAIR:{
        teleLocations = RaidTeleLocations::BWL;
        break;
    }
    case ZULGURUB:{
        teleLocations = RaidTeleLocations::ZG;
        break;
    }
    case RUINS_OF_AHNQIRAJ:{
        teleLocations = RaidTeleLocations::AQ20;
        break;
    }
    case TEMPLE_OF_AHNQIRAJ:{
        teleLocations = RaidTeleLocations::AQ40;
        ToSkip = {0};
        break;
    }
    case KARAZHAN:{
        teleLocations = RaidTeleLocations::Kara;
        ToSkip = {3};
        break;
    }
    case GRUULS_LAIR:{
        teleLocations = RaidTeleLocations::Gruul;
        break;
    }
    case MAGTHERIDONS_LAIR:{
        teleLocations = RaidTeleLocations::Mag_Lair;
        break;
    }
    case SERPENTSHRINE_CAVERN:{
        teleLocations = RaidTeleLocations::SSC;
        ToSkip = {5};
        break;
    }
    case THE_EYE:{
        teleLocations = RaidTeleLocations::The_Eye;
        break;
    }
    case BLACK_TEMPLE:{
        teleLocations = RaidTeleLocations::BT;
        ToSkip = {8};
        break;
    }
    case ZULAMAN:{
        teleLocations = RaidTeleLocations::ZA;
        break;
    }
    }
};
bool RaidTeleporterScript::CheckForSkip(int toCheck){
    for(int i = 0; i < ToSkip.size(); i++){
        if(toCheck == ToSkip[i]){
            return true;
        }
    }
    return false;
}

std::string RaidTeleporterScript::CopperToString(int copper){
    if(copper == 0){
        return "Teleports are free";
    }
    int gold = copper / 10000; // gets gold amount
    int silver = copper / 100; // gets silve amount
    silver  %= 100; // eliminates gold
    copper %= 100; // eliminates silver and gold
    std::string nicelyFormated = "Teleports Cost ";
    if(gold != 0){
        nicelyFormated += std::to_string(gold);
        nicelyFormated += " gold ";
    }
    if(silver != 0){
        nicelyFormated += std::to_string(silver);
        nicelyFormated += " silver ";
    }
    if(copper != 0){
        nicelyFormated += std::to_string(copper);
        nicelyFormated += " copper";
    }
    return nicelyFormated;
}

void AddRaidTeleporterScripts(){
    new RaidTeleporterScript();
}

