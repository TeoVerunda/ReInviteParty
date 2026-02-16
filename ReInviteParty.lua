-- Addon name for namespacing
local addonName = "ReinviteParty"

-- Table to store raid member names
local storedMembers = {}

-- Variables for invite tracking
local inviteIndex = 1
local doInvite = false
local waitTimer = 0
local lastMemberCount = 0

-- Function to send the next invite
local function SendNextInvite()
    local numMembers = table.getn(storedMembers)
    
    -- Check if all invites are done
    if inviteIndex > numMembers then
        doInvite = false
        print("ReInvite process complete. All " .. numMembers .. " members invited.")
        storedMembers = {}
        lastMemberCount = 0
        return
    end
    
    local name = storedMembers[inviteIndex]
    if name then
        InviteByName(name)
        print("(" .. inviteIndex .. "/" .. numMembers .. ") Invited: " .. name)
    end
    
    inviteIndex = inviteIndex + 1
    waitTimer = GetTime() + 5.0
end

-- Function to execute the reinvite process
local function ExecuteReinvite()
    -- Check if player is raid leader BEFORE kicking
    if not IsRaidLeader() then
        print("You are not the raid leader.")
        return
    end
    
    print("Starting ReInvite process...")
    
    -- Store current raid members (exclude self)
    storedMembers = {}
    local playerName = UnitName("player")
    local numRaid = GetNumRaidMembers()
    
    for i = 1, numRaid do
        local name = UnitName("raid" .. i)
        if name and name ~= playerName then
            table.insert(storedMembers, name)
            print("  Stored: " .. name)
        end
    end
    
    print("Total stored: " .. table.getn(storedMembers) .. " raid members.")
    print("Kicking members...")
    
    -- Kick all stored members
    for i = 1, table.getn(storedMembers) do
        local name = storedMembers[i]
        if name then
            UninviteByName(name)
            print("  Kicking: " .. name)
        end
    end
    
    -- Set up invite tracking
    inviteIndex = 1
    doInvite = true
    lastMemberCount = 0
    waitTimer = GetTime() + 2.5  -- Wait 2.5 seconds before first invite
end

-- Create single persistent frame for all updates
local mainFrame = CreateFrame("Frame")
mainFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")

mainFrame:SetScript("OnEvent", function(self, event, ...)
    if doInvite and event == "PARTY_MEMBERS_CHANGED" then
        -- Party member joined or left - track the change
        local currentCount = GetNumPartyMembers()
        if currentCount > lastMemberCount then
            lastMemberCount = currentCount
            print("Member joined. Next invite in 5 seconds...")
        end
    end
end)

mainFrame:SetScript("OnUpdate", function(self, elapsed)
    if doInvite then
        if GetTime() > waitTimer then
            SendNextInvite()
        end
    end
end)

-- Slash command handler
SLASH_REINVITEPARTY1 = "/reinviteparty"
SLASH_REINVITEPARTY2 = "/reinvite"
SLASH_REINVITEPARTY3 = "/reinv"
SlashCmdList["REINVITEPARTY"] = function(msg)
    ExecuteReinvite()
end

-- Print confirmation on load
print("ReInvite addon loaded. Use /reinviteparty, /reinvite, or /reinv command.")
