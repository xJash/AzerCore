-- Sunrise_AttunementDB.lua

local AIO = AIO or require("AIO")

local KEYS = {
    currency = {
        guid        = 0,
        currentEXP  = 1,
        maxEXP      = 2,
        attuned     = 3,
        itemID      = 4
    },
}

local AttunementDB = AIO.AddHandlers("Sunrise", {})

-- Function to fetch progress from the SQL database based on ItemID
function AttunementDB.GetItemProgress(itemID)
    print("GetItemProgress called")
    local query = WorldDBQuery("SELECT currentEXP FROM acore_world.attunements WHERE ItemID = " .. itemID)
    
    if query and query:GetRowCount() > 0 then
        query:FirstRow()
        local currentEXP = query:GetUInt32(KEYS.currency.currentEXP)
        return currentEXP
    else
        return nil
    end
end

-- Function to fetch all progress data from the SQL database based on GUID
function AttunementDB.GetProgressByGUID(playerGUID)
    print("GetProgressByGUID called")
    local query = WorldDBQuery("SELECT currentEXP, maxEXP, attuned, ItemID FROM acore_world.attunements WHERE guid = " .. playerGUID)
    
    if query and query:GetRowCount() > 0 then
        query:FirstRow()
        local currentEXP = query:GetUInt32(KEYS.currency.currentEXP)
        local maxEXP = query:GetUInt32(KEYS.currency.maxEXP)
        local attuned = query:GetUInt32(KEYS.currency.attuned)
        local itemID = query:GetUInt32(KEYS.currency.itemID)
        
        return currentEXP, maxEXP, attuned, itemID
    else
        return nil
    end
end

return AttunementDB
