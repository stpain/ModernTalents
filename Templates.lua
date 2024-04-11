

local name, addon = ...;


ModernTalentsCircleButtonMixin = {}
function ModernTalentsCircleButtonMixin:SetSizeRatio(size)
    self:SetSize(size, size)
    self.icon:SetSize(size, size)
    self.mask:SetSize(size*0.9, size*0.9)
    self.border:SetSize(size*1.8, size*1.8)
end












ModernTalentsSpecPanelMixin = {}
function ModernTalentsSpecPanelMixin:SetSpec(info)

    --DevTools_Dump(info)

    self.activate:SetText(CHALLENGE_MODE_START_CHALLENGE)
    --self.activate:SetText(TALENTS)
    self.activate:SetScript("OnClick", function()
        addon.CallbackRegistry:TriggerEvent(addon.Callbacks.Specialization_OnSelected, info)
    end)


    self.name:SetText(info.name)
    self.thumbnail:SetTexCoord(info.thumbnailAtlas[1], info.thumbnailAtlas[2], info.thumbnailAtlas[3], info.thumbnailAtlas[4])

    self.description:SetText(info.description)

    self.majorBonus.icon:SetTexture(select(3, GetSpellInfo(info.majorBonuses[1])))
    self.majorBonus:SetSizeRatio(60)
    self.majorBonus:SetScript("OnEnter", function()
        GameTooltip:SetOwner(self.majorBonus, "ANCHOR_RIGHT")
        GameTooltip:SetSpellByID(info.majorBonuses[1])
    end)

    self.minorBonusesParent.icons = {}

    if info.minorBonuses then
        for k, spellID in ipairs(info.minorBonuses) do
            if not self.minorBonusesParent.icons[k] then
                self.minorBonusesParent.icons[k] = CreateFrame("Frame", nil, self.minorBonusesParent, "ModernTalentsCircleButtonTemplate")
                self.minorBonusesParent.icons[k]:SetSizeRatio(30)

                if k == 1 then
                    self.minorBonusesParent.icons[k]:SetPoint("LEFT", 0, 0)
                else
                    self.minorBonusesParent.icons[k]:SetPoint("LEFT", self.minorBonusesParent.icons[k-1], "RIGHT", 10, 0)
                end
            end

            self.minorBonusesParent.icons[k].icon:SetTexture(select(3, GetSpellInfo(spellID)))
            self.minorBonusesParent.icons[k]:SetScript("OnEnter", function()
                GameTooltip:SetOwner(self.minorBonusesParent.icons[k], "ANCHOR_RIGHT")
                GameTooltip:SetSpellByID(spellID)
            end)
        end
    end

    self.minorBonusesParent:SetWidth((#info.minorBonuses * 30) + ((#info.minorBonuses - 1) * 10))

    -- local majorBonus = Spell:CreateFromSpellID(info.majorBonuses[1])
    -- if not majorBonus:IsSpellEmpty() then
    --     majorBonus:ContinueOnSpellLoad(function()
            
    --     end)
    -- end
end

local rolesAtlasMap = {
    HEALER = "UI-LFG-RoleIcon-Healer-Micro",
    TANK = "UI-LFG-RoleIcon-Tank-Micro",
    DAMAGER = "UI-LFG-RoleIcon-DPS-Micro",
}
function ModernTalentsSpecPanelMixin:SetRole(role1, role2)

    local s = "";
    if role1 then
        s = string.format("%s %s", CreateAtlasMarkup(rolesAtlasMap[role1], 20, 20), _G[role1])
    end
    if role2 then
        s = string.format("%s    %s %s", s, CreateAtlasMarkup(rolesAtlasMap[role2], 20, 20), _G[role2])
    end

    self.role:SetText(s)

end

function ModernTalentsSpecPanelMixin:ShowDivider()
    self.divider:Show()
end

function ModernTalentsSpecPanelMixin:EnableActivateButton(enable)
    if enable then
        self.activate:Enable()
    else
        self.activate:Disable()
    end
end

function ModernTalentsSpecPanelMixin:SetSelected(selected)
    if selected then
        for k, v in ipairs(self.selectedBackgrounds) do
            v:Show()
        end
        self.thumbnailBorder:SetTexCoord(0.1943359375, 0.3515625, 0.83837890625, 0.93701171875)
    else
        for k, v in ipairs(self.selectedBackgrounds) do
            v:Hide()
        end
        self.thumbnailBorder:SetTexCoord(0.00048828125, 0.15771484375, 0.83837890625, 0.93701171875)
    end
end













ModernTalentsTalentIconMixin = {}

function ModernTalentsTalentIconMixin:OnLoad()
    self:SetScript("OnLeave", function()
        GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
    end)

    self.pointsBackground:SetTexture(136960)
    self.pointsLabel:SetText(1)

    addon.CallbackRegistry:RegisterCallback(addon.Callbacks.Talent_OnPreviewPointsChanged, self.Talent_OnPreviewPointsChanged, self)
    addon.CallbackRegistry:RegisterCallback(addon.Callbacks.Talent_OnTalentRecordTalentAdded, self.Talent_OnTalentRecordTalentAdded, self)
    addon.CallbackRegistry:RegisterCallback(addon.Callbacks.Talent_OnTalentRecording, self.Talent_OnTalentRecording, self)
end

function ModernTalentsTalentIconMixin:Talent_OnTalentRecording(recording)
    self.isRecordingActive = recording

    if self.isRecordingActive then
        self.icon:SetDesaturation(0)
    else
        self.icon:SetDesaturation(1)
    end
end

function ModernTalentsTalentIconMixin:SetDataBinding(binding)

    --this func is only called once and is used to set some frame attribute and scripts
    if binding.rowId then
        self.rowId = binding.rowId
    end
    if binding.colId then
        self.colId = binding.colId
    end

end

function ModernTalentsTalentIconMixin:UpdateLayout()
    local x, y = self:GetSize()
    self.pointsBackground:SetSize(x*0.3, x*0.3)
    self.pointsLabel:SetSize(x*0.3, x*0.3)
end

function ModernTalentsTalentIconMixin:ResetDataBinding()
    
end

--this will be used to display other class trees
function ModernTalentsTalentIconMixin:SetBaseTalent(talent)
    local name, _, icon = GetSpellInfo(talent.talentSpellIDs[1])
    self.icon:SetTexture(icon)
    self.icon:SetDesaturation(1)
    self.icon:Show()
    self.pointsBackground:Hide()
    self.pointsLabel:Hide()
    self.border:Show()

    self.talentData = talent;

    self.previewRank = 0;
    self.rank = 0;
    self.maxRank = #talent;

    self:SetScript("OnEnter", function()
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetSpellByID(talent.talentSpellIDs[1])
        --GameTooltip:SetTalent(talent.tabIndex, talent.talentIndex)
    end)
end


--this is the main call to set the players tree talents
function ModernTalentsTalentIconMixin:SetTalentIndex(talent)
    self.tabIndex, self.talentIndex = talent.tabIndex, talent.talentIndex

    local name, icon, row, col, rank, maxRank, isExceptional, available = GetTalentInfo(self.tabIndex, self.talentIndex)
    self.isPassive = IsPassiveSpell(talent.talentSpellIDs[1])

    if not self.isPassive then
        self.mask:Hide()
    else
        self.mask:Show()
    end

    self.rank = rank;
    self.previewRank = rank;
    self.maxRank = maxRank;

    self.icon:SetTexture(icon)
    self.icon:SetDesaturation(1)
    self.icon:Show()
    self.pointsBackground:Show()
    self.pointsLabel:Show()
    self.pointsLabel:SetText(rank)
    self.border:Show()

    self:SetScript("OnEnter", function()
        if self.talentIndex then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            --print(name, self.talentIndex)
            self.UpdateTooltip()
        end
    end)
    self.UpdateTooltip = function()
        local activeTalentGroup = GetActiveTalentGroup(false, false)
        GameTooltip:SetTalent(self.tabIndex, self.talentIndex, false, false, activeTalentGroup, true)
    end
    self:SetScript("OnMouseDown", function(_, button)

        local activeTalentGroup = GetActiveTalentGroup(false, false)

        addon.CallbackRegistry:TriggerEvent(addon.Callbacks.Talent_OnMouseDown, name, talent)

        --if not self.isRecordingActive then

            if ( button == "LeftButton" ) then
                if ( GetCVarBool("previewTalentsOption") ) then
                    AddPreviewTalentPoints(self.tabIndex, self.talentIndex, 1, false, activeTalentGroup);
                else
                    --LearnTalent(info.tabIndex, info.talentIndex, false, false);
                end
            elseif ( button == "RightButton" ) then
                if ( GetCVarBool("previewTalentsOption") ) then
                    AddPreviewTalentPoints(self.tabIndex, self.talentIndex, -1, false, activeTalentGroup);
                end
            end

        --end
    end)
    self:Update()
end

function ModernTalentsTalentIconMixin:Talent_OnPreviewPointsChanged(talentIndex, tabID, delta)

    -- if self.tabIndex and self.talentIndex then
    --     local name, iconTexture, row, col, rank, maxRank, isExceptional, available, unKnown, isActive, y, talentID = GetTalentInfo(self.tabIndex, self.talentIndex)
    --     local activeTalentGroup = GetActiveTalentGroup(false, false)
    --     local tier, column, isLearnable = GetTalentPrereqs(self.tabIndex, self.talentIndex, false, false, activeTalentGroup)

    --     if name == "Ancestral Awakening" then
    --         --print(name, iconTexture, row, col, rank, maxRank, isExceptional, available, unKnown, isActive, y, talentID, tier, column, isLearnable)
    --     end
    -- end
    
    if (self.talentIndex == talentIndex) and (self.tabIndex == tabID) then
        self.previewRank = self.previewRank + delta;

        self.pointsLabel:SetText(self.previewRank)

        self.flash:Play()

        if self.previewRank == 0 then
            --self.border:SetAtlas("orderhalltalents-spellborder")
            self:SetBorder("gray")
            self.icon:SetDesaturation(1)
        elseif self.previewRank == self.maxRank then
            --self.border:SetAtlas("orderhalltalents-spellborder-yellow")
            self:SetBorder("yellow")
        else
            --self.border:SetAtlas("orderhalltalents-spellborder-green")
            self:SetBorder("green")
        end
    end
end

function ModernTalentsTalentIconMixin:Talent_OnTalentRecordTalentAdded(tabIndex, talentIndex, rank, maxRank)
    if self.tabIndex == tabIndex and self.talentIndex == talentIndex then
        self.icon:SetDesaturation(0)
        self.pointsLabel:SetText(rank)
        if rank == 0 then
            --self.border:SetAtlas("orderhalltalents-spellborder")
            self:SetBorder("gray")
            self.icon:SetDesaturation(1)
        elseif rank == maxRank then
            --self.border:SetAtlas("orderhalltalents-spellborder-yellow")
            self:SetBorder("yellow")
        else
            --self.border:SetAtlas("orderhalltalents-spellborder-green")
            self:SetBorder("green")
        end
    end
end

function ModernTalentsTalentIconMixin:SetNoRank()
    --self.border:SetAtlas("orderhalltalents-spellborder")
    self:SetBorder("gray")
    self.icon:SetDesaturation(1)
    self.pointsLabel:SetText(0)
end

--IsPassiveSpell

function ModernTalentsTalentIconMixin:Update()
    if self.tabIndex and self.talentIndex then
        local name, iconTexture, row, col, rank, maxRank, isExceptional, available, unKnown, isActive, y, talentID = GetTalentInfo(self.tabIndex, self.talentIndex)
        local activeTalentGroup = GetActiveTalentGroup(false, false)
        local tier, column, isLearnable = GetTalentPrereqs(self.tabIndex, self.talentIndex, false, false, activeTalentGroup)

        if name == "Ancestral Awakening" or name == "Mana Tide Totem" then
            --print(name, tier, column, isLearnable)
        end

        self.rank = rank;
        
        self.pointsBackground:Show()
        self.pointsLabel:Show()
        self.pointsLabel:SetText(rank)
        self.icon:SetDesaturation(0)

        if rank == 0 then
            --self.border:SetAtlas("orderhalltalents-spellborder")
            self:SetBorder("gray")
            self.icon:SetDesaturation(1)
        elseif rank == maxRank then
            --self.border:SetAtlas("orderhalltalents-spellborder-yellow")
            self:SetBorder("yellow")
        else
            --self.border:SetAtlas("orderhalltalents-spellborder-green")
            self:SetBorder("green")
        end
    else
        --DevTools_Dump(self)
        self.pointsLabel:SetText(0)
        --self.border:SetAtlas("orderhalltalents-spellborder")
        self:SetBorder("gray")
        self.icon:SetDesaturation(1)
    end
end


function ModernTalentsTalentIconMixin:ClearTalent()
    self.spellId = nil
    self.border:Hide()
    self.pointsBackground:Hide()
    self.pointsLabel:Hide()
    self.icon:Hide()
    self.talentIndex = false;
    self:SetScript("OnMouseDown", nil)
    --self.border:SetAtlas("orderhalltalents-spellborder")
    self:SetBorder("gray")
    self.icon:SetDesaturation(1)
end

local talentBorderAtlas = {
    ["square-ghost"] = { 76, 76, 0.22900390625, 0.30322265625, 0.3232421875, 0.4716796875, false, false },
    ["square-gray"] = { 64, 64, 0.22900390625, 0.29150390625, 0.4736328125, 0.5986328125, false, false },
    ["square-green"] = { 64, 64, 0.22900390625, 0.29150390625, 0.6005859375, 0.7255859375, false, false },
    ["square-greenglow"] = { 108, 108, 0.00048828125, 0.10595703125, 0.5556640625, 0.7666015625, false, false },
    ["square-locked"] = { 64, 64, 0.22900390625, 0.29150390625, 0.7275390625, 0.8525390625, false, false },
    ["square-red"] = { 64, 64, 0.22900390625, 0.29150390625, 0.8544921875, 0.9794921875, false, false },
    ["square-shadow"] = { 158, 158, 0.13623046875, 0.21337890625, 0.7001953125, 0.8544921875, false, false },
    ["square-yellow"] = { 64, 64, 0.30517578125, 0.36767578125, 0.1708984375, 0.2958984375, false, false },

    ["circle-ghost"] = { 52, 52, 0.42822265625, 0.47900390625, 0.5888671875, 0.6904296875, false, false },
    ["circle-gray"] = { 40, 40, 0.10693359375, 0.13134765625, 0.5556640625, 0.6044921875, false, false },
    ["circle-green"] = { 40, 40, 0.10693359375, 0.13134765625, 0.6064453125, 0.6552734375, false, false },
    ["circle-greenglow"] = { 82, 82, 0.09326171875, 0.13330078125, 0.7685546875, 0.8486328125, false, false },
    ["circle-locked"] = { 40, 40, 0.10693359375, 0.13134765625, 0.6572265625, 0.7060546875, false, false },
    ["circle-red"] = { 40, 40, 0.10693359375, 0.13134765625, 0.7080078125, 0.7568359375, false, false },
    ["circle-shadow"] = { 76, 76, 0.7314453125, 0.7685546875, 0.0830078125, 0.1572265625, false, false },
    ["circle-yellow"] = { 40, 40, 0.8837890625, 0.908203125, 0.1123046875, 0.1611328125, false, false },
}
function ModernTalentsTalentIconMixin:SetBorder(colour)
    local atlas = ""
    if self.isPassive then
        atlas = "circle-"..colour;
    else
        atlas = "square-"..colour;
    end
    self.border:SetTexCoord(talentBorderAtlas[atlas][3],talentBorderAtlas[atlas][4],talentBorderAtlas[atlas][5],talentBorderAtlas[atlas][6])
end