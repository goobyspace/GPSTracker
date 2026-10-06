local function UpdateEntryLocation(entry)
    if not entry.resultID then
        return;
    end;

    local leaderInfo = C_LFGList.GetSearchResultLeaderInfo(entry.resultID);
    local areaName = leaderInfo and leaderInfo.areaName;

    -- make sure we dont recreate it twice
    if not entry.GPSTrackerLocation then
        local location = entry:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall");
        location:SetJustifyH("RIGHT");
        location:SetWordWrap(false);
        location:SetHeight(13);
        entry.GPSTrackerLocation = location;
    end;

    local location = entry.GPSTrackerLocation;

    if not areaName or (not issecretvalue(areaName) and areaName == "") then
        location:Hide();
        return;
    end;

    location:ClearAllPoints();
    location:SetPoint("TOPRIGHT", entry, "TOPRIGHT", -12, -10);
    location:SetWidth(math.max(0, entry:GetWidth() - 12));
    location:SetText(areaName);
    location:Show();
end;

local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", function(self, _, loadedAddon)
    if loadedAddon == "Blizzard_GroupFinder_VanillaStyle" then
        if not LFGBrowseSearchEntry_Update then
            return false;
        end;

        hooksecurefunc("LFGBrowseSearchEntry_Update", UpdateEntryLocation);
    end;
end);
