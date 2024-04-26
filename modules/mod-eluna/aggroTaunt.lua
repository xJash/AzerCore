local TAUNT_RANGE = 50 -- range for taunting

local function TauntNearbyMobs(event,player,command)
	print("taunt event found")
	player:SendBroadcastMessage("Taunting nearby mobs...")
	
	local creatures = player:GetCreaturesInRange(TAUNT_RANGE)
	for _, creature in ipairs(creatures) do
		if creature:CanAggro(player) then
			creature:AttackStart(player)
		end
	end
	
	return false
end

RegisterPlayerEvent(23, TauntNearbyMobs)