

--[[
    spec tab is to show info about the class specs
    talent tab is character talents live view
    template tab is to view edit any talent tree/class
]]

local name, addon = ...;

local Util = addon.Util;

local L = addon.Constants.Locales[GetLocale()]

local NUM_SPECIALIZATIONS = 3

--local letters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}

ModernTalentsMixin = {}

-- function ModernTalentsMixin:OnUpdate()
-- self.rebuildTalents
--     for k, v in ipairs(letters) do
        
--     end
-- end

function ModernTalentsMixin:OnLoad()

    self.talentArrowLinesPool = {}

    self:RegisterForDrag("LeftButton")

    self:RegisterEvent("PREVIEW_TALENT_POINTS_CHANGED")
    self:RegisterEvent("PREVIEW_PET_TALENT_POINTS_CHANGED")
    self:RegisterEvent("PLAYER_TALENT_UPDATE")
    self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
    self:RegisterEvent("CONFIRM_TALENT_WIPE")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_LEVEL_UP") --level, healthDelta, powerDelta, numNewTalents, numNewPvpTalentSlots, strengthDelta, agilityDelta, staminaDelta, intellectDelta
   
    NineSliceUtil.ApplyLayout(self, addon.Constants.NineSliceLayouts.ParentBorder)
    --NineSliceUtil.ApplyLayout(self.talentTreesParent.petTalentParent, addon.Constants.NineSliceLayouts.ParentBorder)

    self.specializationsParent.background:SetTexture("Interface/AddOns/ModernTalents/Media/Talents/Specialization.png")

    local atlasInfo = addon.Constants.Atlas["interface/talentframe/specialization"]["spec-background"]
    self.specializationsParent.background:SetTexCoord(atlasInfo[3],atlasInfo[4],atlasInfo[5],atlasInfo[6])

    self.tab1:SetText(SPECIALIZATION)
    self.tab2:SetText(TALENTS)
    self.tab3:SetText(GLYPHS)
    self.tab4:SetText(OPTIONS)

    PanelTemplates_SetNumTabs(self, 4);
    PanelTemplates_SetTab(self, 1);

    for _, tab in ipairs(self.tabs) do
        tab:SetScript("OnClick", function()
            self:SetView(tab:GetID())
        end)
    end

    --force talent preview enabled
    SetCVar("previewTalentsOption", true)

    local width = self:GetWidth()

    self.talentTreesParent.primaryTree:SetWidth(width*0.245)
    self.talentTreesParent.secondaryTree1:SetWidth(width*0.2)
    self.talentTreesParent.secondaryTree2:SetWidth(width*0.2)

    --init the talent trees
    for k, v in ipairs({"primaryTree", "secondaryTree1", "secondaryTree2"}) do

        self.talentTreesParent[v]:InitFramePool("Frame", "ModernTalentsTalentIconTemplate")
        --self.talentTreesParent[v]:InitFramePool("Button", "PlayerTalentButtonTemplate")
        self.talentTreesParent[v]:SetFixedColumnCount(4)
        self.talentTreesParent[v].ScrollBar:Hide()
        self.talentTreesParent[v].ScrollBar:HookScript("OnShow", function()
            self.talentTreesParent[v].ScrollBar:Hide()
        end)

        C_Timer.After(0.1, function()
            for row = 1, 7 do
                for col = 1, 4 do
                    self.talentTreesParent[v]:Insert({
                        rowId = row,
                        colId = col,
                    })
                end
            end
        end)
    end


    self.talentTreesParent.spec1:SetSizeRatio(44)
    self.talentTreesParent.spec1:SetScript("OnEnter", function()
        GameTooltip:SetOwner(self.talentTreesParent.spec1, "ANCHOR_RIGHT");
        GameTooltip:AddLine(TALENT_SPEC_PRIMARY);
        GameTooltip:AddLine(VOICE_CHAT_CHANNEL_INACTIVE_TOOLTIP_INSTRUCTIONS, 1,1,1);
        GameTooltip:Show()
    end)
    self.talentTreesParent.spec1:SetScript("OnMouseDown", function()
        local activeTalentGroup = GetActiveTalentGroup(false, false)
        if activeTalentGroup ~= 1 then
            _G["PlayerSpecTab1"]:Click()
            SetActiveTalentGroup(1)
        end
    end)
    self.talentTreesParent.spec2:SetSizeRatio(44)
    self.talentTreesParent.spec2:SetScript("OnEnter", function()
        GameTooltip:SetOwner(self.talentTreesParent.spec2, "ANCHOR_RIGHT");
        GameTooltip:AddLine(TALENT_SPEC_SECONDARY);
        GameTooltip:AddLine(VOICE_CHAT_CHANNEL_INACTIVE_TOOLTIP_INSTRUCTIONS, 1,1,1);
        GameTooltip:Show()
    end)
    self.talentTreesParent.spec2:SetScript("OnMouseDown", function()
        local activeTalentGroup = GetActiveTalentGroup(false, false)
        if activeTalentGroup ~= 2 then
            _G["PlayerSpecTab2"]:Click()
            SetActiveTalentGroup(2)
        end
    end)

    self.talentTreesParent.helptip.text:SetJustifyH("CENTER")
    self.talentTreesParent.helptip:SetText(TALENT_TREE_LOCKED_TOOLTIP)

    self.talentTreesParent.resetTalents:SetScript("OnEnter", function()
        GameTooltip:SetOwner(self.talentTreesParent.resetTalents, "ANCHOR_RIGHT");
        GameTooltip:SetText(TALENT_TOOLTIP_RESETTALENTGROUP);
    end)
    self.talentTreesParent.resetTalents:SetScript("OnClick", function()
        PlayerTalentFrameResetButton_OnClick()
        self:UpdateSpecializationTab()
        self:UpdateTalentTrees()
        self:UpdatePetTalentTree()
    end)

    self.talentTreesParent.learnTalents:SetScript("OnEnter", function()
        GameTooltip:SetOwner(self.talentTreesParent.learnTalents, "ANCHOR_RIGHT");
        GameTooltip:SetText(TALENT_TOOLTIP_LEARNTALENTGROUP);
    end)
    self.talentTreesParent.learnTalents:SetScript("OnClick", function()
        PlayerTalentFrameLearnButton_OnClick()
    end)

    self.talentTreesParent.talentImportExport:HookScript("OnTextChanged", function()
        local s = self.talentTreesParent.talentImportExport:GetText()
        self:CheckImportString(s)
    end)
    self.talentTreesParent.talentImportExport.ok:SetScript("OnMouseDown", function()
        local s = self.talentTreesParent.talentImportExport:GetText()
        self:ImportTalentString(s)
    end)
    self.talentTreesParent.talentImportExport.cancel:SetScript("OnMouseDown", function()
        self.talentTreesParent.talentImportExport:SetText("")
    end)

    self:SetupTalentRecorder()

    addon.CallbackRegistry:RegisterCallback(addon.Callbacks.Specialization_OnSelected, self.Specialization_OnSelected, self)
    addon.CallbackRegistry:RegisterCallback(addon.Callbacks.Talent_OnMouseDown, self.Talent_OnMouseDown, self)
    addon.CallbackRegistry:RegisterCallback(addon.Callbacks.Talent_OnTalentRecordSelectionChanged, self.Talent_OnTalentRecordSelectionChanged, self)
end


---When the player clicks a talent we want to check if the player is actively recording talents, if so add this talent to the record
---@param name string talent name
---@param talent table talent data
function ModernTalentsMixin:Talent_OnMouseDown(name, talent)

    local tabIndex, talentIndex, maxRank = talent.tabIndex, talent.talentIndex, #talent.talentSpellIDs

    if self.talentRecord then
        local numAdded = 0;
        for k, v in ipairs(self.talentRecord) do
            if v.tabIndex == tabIndex and v.talentIndex == talentIndex then
                numAdded = numAdded + 1;
            end
        end
        if numAdded < maxRank then
            table.insert(self.talentRecord, {
                tabIndex = tabIndex,
                talentIndex = talentIndex,
            })

            self:UpdateTalentRecordText(string.format("Point %d - %s Rank %d", #self.talentRecord, name, numAdded + 1))
            --addon.CallbackRegistry:TriggerEvent(addon.Callbacks.Talent_OnTalentRecordTalentAdded, tabIndex, talentIndex, numAdded + 1, maxRank)

            --self:UpdateTalentTrees()
        end
    end
end


function ModernTalentsMixin:Talent_OnTalentRecordSelectionChanged(record)
    self.db.account.profiles[addon.thisCharacter].currentTalentRecording = record;
    self:OptionsPanel_OnTalentRecordSettingChanged()
end

--[[
    for a talent record to be applied the current talent point spending needs to be checked and
    match the talent record
    the important part is that the talents in the record upto the current point spent amount matches
]]
function ModernTalentsMixin:CheckTalentRecordCompatability(record, isPet)
    
    local numTalentPoints = GetNumTalentPoints()
    local activeTalentGroup = GetActiveTalentGroup(false, isPet)
    local unspentPoints = GetUnspentTalentPoints(false, isPet, activeTalentGroup)
    local pointsMatch = true;
    local spentPoints = numTalentPoints - unspentPoints;
    --print(spentPoints)
    if spentPoints > 0 then

        local currentTalents = {}
        for i = 1, spentPoints do
            local talent = record.record[i]
            if talent then
                local name, iconTexture, row, col, rank, maxRank, isExceptional, available = GetTalentInfo(talent.tabIndex, talent.talentIndex, false, isPet)
                --print(name, rank)
                if not currentTalents[name] then
                    currentTalents[name] = {
                        actual = rank,
                        record = 1,
                    }
                else
                    currentTalents[name].record = currentTalents[name].record + 1;
                end
            end
        end


        --[[
            check if the current talent point spend matches the talent record
        ]]
        for k, v in pairs(currentTalents) do
            if v.actual ~= v.record then
                pointsMatch = false;
            end
        end
    end
    return pointsMatch, spentPoints, unspentPoints;
end


--[[
    this is quite the function, the idea is to test if a talent record can eb applied with the players current talent point spend
]]
function ModernTalentsMixin:OptionsPanel_OnTalentRecordSettingChanged()

    local record = self.db.account.profiles[addon.thisCharacter].currentTalentRecording;

    local panel = self.options;
    if panel.autoLearnTalentRecording.active:GetChecked() then

        if self.db.account.profiles[addon.thisCharacter].currentTalentRecording and self.db.account.profiles[addon.thisCharacter].currentTalentRecording.name then
            
            panel.autoLearnTalentRecording.recordingDropdown:SetText(record.name)

            local tabID = record.record[1].tabIndex

            --print(string.format("%s has %d talent points recorded", record.name, #record.record))

            local t = {}
            for k, talent in ipairs(record.record) do
                local name, iconTexture, row, col, rank, maxRank, isExceptional, available = GetTalentInfo(talent.tabIndex, talent.talentIndex)
                table.insert(t, {
                    label = string.format("%d %s", k, name),
                    icon = iconTexture,
                })
            end
            panel.autoLearnTalentRecording.recordListview.scrollView:SetDataProvider(CreateDataProvider(t))

            local pointsMatch, spentPoints, unspentPoints = self:CheckTalentRecordCompatability(record, false)
            
            if (unspentPoints > 0) and (spentPoints < #record.record) then
                if pointsMatch then
                    local nextTalent = record.record[spentPoints + 1]
                    local nextTalentName, iconTexture, row, col, rank, maxRank, isExceptional, available = GetTalentInfo(nextTalent.tabIndex, nextTalent.talentIndex)
                    panel.autoLearnTalentRecording.active.label:SetText(string.format("%s is active, next talent %s", record.name, nextTalentName))
                    
                    StaticPopup_Show("ModernTalentsConfirmTalentRecordTalentSpendDialog", "You have unspent talent points, would you like to apply the selected talent record?", nil, {
                        accept = function()
                            self:Specialization_OnSelected(self.classSpecInfo[tabID])
                            self:SetView(2)
                            for i = spentPoints + 1, unspentPoints do
                                local talent = record.record[i]
                                if talent then
                                    local name, iconTexture, row, col, rank, maxRank, isExceptional, available = GetTalentInfo(talent.tabIndex, talent.talentIndex)
                                    AddPreviewTalentPoints(talent.tabIndex, talent.talentIndex, 1, false, activeTalentGroup);
                                end
                            end
                        end,
                        alt = function()
                            -- local numTalentToLearn = (#record.record - spentPoints)
                            -- local iter = spentPoints + 1

                            -- print(string.format("Learning %d talents, starting at %d", numTalentToLearn, spentPoints+1))

                            -- C_Timer.NewTicker(0.5, function()
                            --     local talent = record.record[iter]
                            --     if talent then
                            --         local name, iconTexture, row, col, rank, maxRank, isExceptional, available = GetTalentInfo(talent.tabIndex, talent.talentIndex)
                            --         print(name)
                            --         LearnTalent(talent.tabIndex, talent.talentIndex, false, activeTalentGroup);
                            --     end
                            --     iter = iter + 1;
                            -- end, numTalentToLearn)
                            -- self:SetView(2)

                            self:Specialization_OnSelected(self.classSpecInfo[tabID])
                            self:SetView(2)

                            --bit of a cheat but just apply the preview then confirm 
                            for i = spentPoints + 1, unspentPoints do
                                local talent = record.record[i]
                                if talent then
                                    --local name, iconTexture, row, col, rank, maxRank, isExceptional, available = GetTalentInfo(talent.tabIndex, talent.talentIndex)
                                    AddPreviewTalentPoints(talent.tabIndex, talent.talentIndex, 1, false, activeTalentGroup);
                                end
                            end
                            C_Timer.After(0.1, function()
                                PlayerTalentFrameLearnButton_OnClick()
                                StaticPopup1Button1:Click()
                                --print("remove this comment and learn talents")
                            end)
                        end,
                        cancel = function()
                            panel.autoLearnTalentRecording.active:SetChecked(false)
                            self.db.account.profiles[addon.thisCharacter].hasActiveTalentRecording = false
                            panel.autoLearnTalentRecording.active.label:SetText(ADDON_DISABLED)
                        end,
                    })
                end
            else
                if (spentPoints >= #record.record) then
                    panel.autoLearnTalentRecording.active.label:SetText("All talent record points have been spent!")
                else
                    panel.autoLearnTalentRecording.active.label:SetText(string.format("%s is active, %s", record.name, NEXT_TALENT_LEVEL:format(GetNextTalentLevel())))
                end
            end
        else
            panel.autoLearnTalentRecording.active.label:SetText("No talent record active, select from the drop down")
        end
    else
        panel.autoLearnTalentRecording.active.label:SetText("")
    end
end



function ModernTalentsMixin:SetupOptionsPanel()
    local panel = self.options;

    panel.cleanStart:SetScript("OnClick", function()
        self:Init(true)
    end)

    panel.refresh = function()

        if not panel:IsVisible() then
            return;
        end

        self:OptionsPanel_OnTalentRecordSettingChanged()

    end

    panel.background:SetAtlas(string.format("legionmission-complete-background-%s", select(2, UnitClass("player")):lower()))

    --talent recording
    panel.autoLearnTalentRecording.active:SetScript("OnClick", function(cb)
        self.db.account.profiles[addon.thisCharacter].hasActiveTalentRecording = cb:GetChecked()
        panel.refresh()
    end)

    panel.autoLearnTalentRecording.viewRecord:SetScript("OnClick", function()
        panel.autoLearnTalentRecording.recordListview:SetShown(not panel.autoLearnTalentRecording.recordListview:IsVisible())
    end)

    panel.autoLearnTalentRecording.recordingDropdown:SetScript("OnMouseDown", function()
        local t = {
            -- {
            --     text = CANCEL,
            --     func = function()
            --         self.db.account.profiles[addon.thisCharacter].hasActiveTalentRecording = false;
            --         self.db.account.profiles[addon.thisCharacter].currentTalentRecording = {}
            --         panel.refresh()
            --     end
            -- }
        }
        for k, v in ipairs(self.db.account.talentRecordings) do

            --at the moment dont allow pet recordings
            if not v.isPet and v.class == select(3, UnitClass("player")) then
                table.insert(t, {
                    text = v.name,
                    func = function()
                        self.db.account.profiles[addon.thisCharacter].currentTalentRecording = v;
                        panel.autoLearnTalentRecording.recordingDropdown:SetText(v.name)

                        local t = {}
                        for k, talent in ipairs(v.record) do
                            local name, iconTexture, row, col, rank, maxRank, isExceptional, available = GetTalentInfo(talent.tabIndex, talent.talentIndex)
                            table.insert(t, {
                                label = string.format("%d %s", k, name),
                                icon = iconTexture,
                            })
                        end
                        panel.autoLearnTalentRecording.recordListview.scrollView:SetDataProvider(CreateDataProvider(t))

                        addon.CallbackRegistry:TriggerEvent(addon.Callbacks.Talent_OnTalentRecordSelectionChanged, v)
                    end,
                })
            end
        end
        panel.autoLearnTalentRecording.recordingDropdown:SetMenu(t)
    end)




    panel:SetScript("OnShow", panel.refresh)

    panel.refresh()
end


function ModernTalentsMixin:SetupTalentRecorder()
    
    local panel = self.talentTreesParent.talentRecorderParent;

    for k, button in ipairs(panel.controls) do
        button:SetScript("OnLeave", function()
            GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
        end)
    end

    panel.record:RegisterForClicks("AnyDown")
    panel.restart:RegisterForClicks("AnyDown")

    panel.record:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT");
        GameTooltip:SetText(L.TALENT_RECORDER_START)
        GameTooltip:Show()
    end)
    panel.record:SetScript("OnClick", function()
        addon.CallbackRegistry:TriggerEvent(addon.Callbacks.Talent_OnTalentRecording, true)
        self.talentRecord = {}
        self:UpdateTalentRecordText("Recording...")
        -- self:IterAllTalentFrames(function(f)
        --     f:SetNoRank()
        -- end)
        panel.recordingAnim:Play()
        self.talentTreesParent.learnTalents:Disable()
        PlayerTalentFrameLearnButton:Disable()
        ModernTalentsFrameLearnButtonTutorialText:SetText(L.RECORD_TALENTS_HELPTIP)
    end)

    panel.restart:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT");
        GameTooltip:SetText(L.TALENT_RECORDER_RESTART)
        GameTooltip:Show()
    end)
    panel.restart:SetScript("OnClick", function()
        self.talentRecord = {}
        self:UpdateTalentRecordText("Record reset")
        -- self:IterAllTalentFrames(function(f)
        --     f:SetNoRank()
        -- end)
        self.talentTreesParent.learnTalents:Disable()
        PlayerTalentFrameLearnButton:Disable()
        ModernTalentsFrameLearnButtonTutorialText:SetText(L.RECORD_TALENTS_HELPTIP)
    end)

    panel.confirm:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT");
        GameTooltip:SetText(L.TALENT_RECORDER_CONFIRM)
        GameTooltip:Show()
    end)
    panel.confirm:SetScript("OnClick", function()
        StaticPopup_Show("ModernTalentsSaveLoadoutDialog", "Name", nil, {
            callback = function(n)
                local _, _, class = UnitClass("player")
                local isPet = self.talentTreesParent.petTalentParent:IsVisible() and true or false
                table.insert(self.db.account.talentRecordings, {
                    name = n,
                    class = class,
                    record = self.talentRecord,
                    isPet = isPet,
                })
                addon.CallbackRegistry:TriggerEvent(addon.Callbacks.Talent_OnTalentRecording, false)
                self:IterAllTalentFrames(function(f)
                    f.Update(f)
                end)
                panel.recordingAnim:Stop()
                panel:Hide()
                self.talentRecord = nil
                self.talentTreesParent.learnTalents:Enable()
                PlayerTalentFrameLearnButton:Enable()
                ModernTalentsFrameLearnButtonTutorialText:SetText(TALENT_TREE_PREVIEW_TUTORIAL)
                self:UpdateTalentTrees()
            end
        })
    end)

    panel.cancel:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT");
        GameTooltip:SetText(L.TALENT_RECORDER_CANCEL)
        GameTooltip:Show()
    end)
    panel.cancel:SetScript("OnClick", function()
        addon.CallbackRegistry:TriggerEvent(addon.Callbacks.Talent_OnTalentRecording, false)
        self:IterAllTalentFrames(function(f)
            f.Update(f)
        end)
        panel.recordingAnim:Stop()
        panel:Hide()
        self.talentTreesParent.learnTalents:Enable()
        PlayerTalentFrameLearnButton:Enable()
        ModernTalentsFrameLearnButtonTutorialText:SetText(TALENT_TREE_PREVIEW_TUTORIAL)
        self:UpdateTalentTrees()
    end)
end

function ModernTalentsMixin:UpdateTalentRecordText(text)
    self.talentTreesParent.talentRecorderParent.text:SetText(text)
end

function ModernTalentsMixin:SetTalentInfoText(text)
    self.talentTreesParent.importInfoFadeOut:Stop()
    self.talentTreesParent.importInfo:SetAlpha(1.0)
    self.talentTreesParent.importInfo:SetText(text)
    self.talentTreesParent.importInfoFadeOut:Play()
end

function ModernTalentsMixin:OnShow()
    ShowUIPanel(PlayerTalentFrame);
    HideUIPanel(PlayerTalentFrame);

    local class, fileName, classID = UnitClass("player")
    self:InitializeClassSpecializations(classID)

    self:InitializeTalentTabDropdown()
    self:UpdateSpecializationTab()
    self:UpdateTalentTrees()
    self:UpdatePetTalentTree()
end

function ModernTalentsMixin:SetView(tabID)
    for k, view in ipairs(self.views) do
        view:Hide()
    end
    self.views[tabID]:Show()
    PanelTemplates_SetTab(self, tabID);
end

function ModernTalentsMixin:ToggleHunterPetTalents(showPet)
    
    if showPet then
        self.talentTreesParent.primaryTree:Hide()
        self.talentTreesParent.secondaryTree1:Hide()
        self.talentTreesParent.secondaryTree2:Hide()
        self.talentTreesParent.helptip:Hide()

        self.talentTreesParent.petTalentParent:Show()


        PlayerTalentFrameTab2:Click()

    else
        self.talentTreesParent.primaryTree:Show()
        self.talentTreesParent.secondaryTree1:Show()
        self.talentTreesParent.secondaryTree2:Show()
        self.talentTreesParent.helptip:Show()

        self.talentTreesParent.petTalentParent:Hide()

        PlayerTalentFrameTab1:Click()

    end
end

function ModernTalentsMixin:OnEvent(event, ...)
    if self[event] then
        self[event](self, ...)
    end
end

function ModernTalentsMixin:PLAYER_LEVEL_UP(...)

    local level, healthDelta, powerDelta, numNewTalents, numNewPvpTalentSlots, strengthDelta, agilityDelta, staminaDelta, intellectDelta = ...;

    if numNewTalents > 0 then
        if self.db.account.profiles[addon.thisCharacter].hasActiveTalentRecording then
            
            local record = self.db.account.profiles[addon.thisCharacter].currentTalentRecording;

            local pointsMatch, spentPoints, unspentPoints = self:CheckTalentRecordCompatability(record, false)

            if (unspentPoints > 0) and (spentPoints < #record.record) then
                if pointsMatch then
                    local nextTalent = record.record[spentPoints + 1]
                    local nextTalentName, iconTexture, row, col, rank, maxRank, isExceptional, available = GetTalentInfo(nextTalent.tabIndex, nextTalent.talentIndex)
                    
                    local activeTalentGroup = GetActiveTalentGroup(false, false)
                    LearnTalent(nextTalent.tabIndex, nextTalent.talentIndex, false, false);
                end
            end

        end
    end
end

function ModernTalentsMixin:ApplyNextTalentRecording()
    
end

function ModernTalentsMixin:PLAYER_ENTERING_WORLD(...)

    self:Init()
    -- local isInitialLogin, isReload = ...;
end

function ModernTalentsMixin:ACTIVE_TALENT_GROUP_CHANGED(...)
    self:IterAllTalentFrames(function(f)
        f.Update(f)
    end)
    self:UpdateTalentTrees()
    self:UpdatePetTalentTree()
    self:UpdateSpecializationTab(true)
end

function ModernTalentsMixin:PLAYER_TALENT_UPDATE(...)
    self:IterAllTalentFrames(function(f)
        f.Update(f)
    end)
    self:UpdateTalentTrees()
    self:UpdateSpecializationTab()
end

function ModernTalentsMixin:PREVIEW_PET_TALENT_POINTS_CHANGED(...)

    local talentIndex, tabID, activeTalentGroup, delta = ...;

    --print(talentIndex, tabID, delta)

    addon.CallbackRegistry:TriggerEvent(addon.Callbacks.Talent_OnPreviewPointsChanged, talentIndex, tabID, delta)

    self:UpdatePetTalentTree()
end

function ModernTalentsMixin:PREVIEW_TALENT_POINTS_CHANGED(...)
    local talentIndex, tabID, activeTalentGroup, delta = ...;

    addon.CallbackRegistry:TriggerEvent(addon.Callbacks.Talent_OnPreviewPointsChanged, talentIndex, tabID, delta)

    self:UpdateTalentTrees()

    --print(string.format("TalentIndex %s, TabID %s, SpecGroup %s, Delta %s", talentIndex, tabID, specGroup, delta))
end

function ModernTalentsMixin:Init(forceReset)

    if forceReset then
        MT_ACCOUNT = nil;
        MT_CHARACTER = nil;
    end

    local name, realm = UnitName("player")
    if not realm then
        realm = GetNormalizedRealmName()
    end
    addon.thisCharacter = string.format("%s-%s", name, realm)

    if not MT_ACCOUNT then
        MT_ACCOUNT = {
            talentLoadouts = {},
            talentRecordings = {},
            profiles = {},
        }
    end

    if not MT_CHARACTER then
        MT_CHARACTER = {}
    end

    self.db = {
        account = MT_ACCOUNT,
        character = MT_CHARACTER,
    }

    if not self.db.account.profiles[addon.thisCharacter] then
        self.db.account.profiles[addon.thisCharacter] = {
            name = name,
            classID = select(3, UnitClass("player")),
            hasActiveTalentRecording = false,
            currentTalentRecording = {},
        }
    end

    local _, class = UnitClass("player")
    if class == "HUNTER" then
        self.talentTreesParent.petSpec:SetSizeRatio(36)
        self.talentTreesParent.playerSpec:SetSizeRatio(36)
        SetPortraitTexture(self.talentTreesParent.petSpec.icon, "pet")
        SetPortraitTexture(self.talentTreesParent.playerSpec.icon, "player")

        self.talentTreesParent.petSpec:SetScript("OnMouseDown", function()
            self:ToggleHunterPetTalents(true)
        end)
        self.talentTreesParent.playerSpec:SetScript("OnMouseDown", function()
            self:ToggleHunterPetTalents()
        end)

        self.talentTreesParent.petTalentParent.talentTree:SetWidth(300)
        self.talentTreesParent.petTalentParent.talentTree:InitFramePool("Frame", "ModernTalentsTalentIconTemplate")
        self.talentTreesParent.petTalentParent.talentTree:SetFixedColumnCount(4)
        self.talentTreesParent.petTalentParent.talentTree.ScrollBar:Hide()
        self.talentTreesParent.petTalentParent.talentTree.ScrollBar:HookScript("OnShow", function()
            self.talentTreesParent.petTalentParent.talentTree.ScrollBar:Hide()
        end)

        C_Timer.After(0.1, function()
            for row = 1, 7 do
                for col = 1, 4 do
                    self.talentTreesParent.petTalentParent.talentTree:Insert({
                        rowId = row,
                        colId = col,
                    })
                end
            end
        end)

        self.talentTreesParent.petTalentParent:SetScript("OnShow", function()
            self:BuildPetTalentTree()
            self.talentTreesParent.petTalentParent.model:SetUnit("pet")
        end)

        -- self.talentTreesParent.petTalentParent.model.ControlFrame.OnLoad(self.talentTreesParent.petTalentParent.model.ControlFrame)
        --self.talentTreesParent.petTalentParent.model.ControlFrame:SetModelScene(self.talentTreesParent.petTalentParent.model);

        --DevTools_Dump({self.talentTreesParent.petTalentParent.model.ControlFrame.zoomOutButton})

        --self.talentTreesParent.petTalentParent.model.petSlotID = 0
        --self.talentTreesParent.petTalentParent.model:SetCameraOrientationByYawPitchRoll(1.57, 1.57, 3.14)
        self.talentTreesParent.petTalentParent.model:HookScript("OnMouseDown", function(model, button)
            if button == "LeftButton" then
                model.rotating = true
                model.rotateStartCursorX = GetCursorPosition()

            else

                -- local PET_STABLE_MODEL_SCENE_ID = 718;
                -- model.petSlotID = model.petSlotID + 1;
                -- if model.petSlotID > 5 then
                --     model.petSlotID = 0;
                -- end

                --local forceSceneChange = true;
                --model:TransitionToModelSceneID(PET_STABLE_MODEL_SCENE_ID, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_DISCARD, forceSceneChange);
                --local creatureDisplayID = C_PlayerInfo.GetPetStableCreatureDisplayInfoID(model.petSlotID);

                -- if creatureDisplayID then

                --     local actor = model:GetActorAtIndex(1);
                --     if actor then
                --         actor:SetModelByCreatureDisplayID(creatureDisplayID);
                --     else
                --         local actor = model:CreateActor()
                --         actor:SetModelByCreatureDisplayID(creatureDisplayID);

                --         -- these args don't match the wiki
                --         --zoom + moves actor away, x + moves actor left, y + moves actor up
                --         actor:SetPosition(6, 0, -0.5)
                --         actor:SetPitch(3.14) --this is a forward roll
                --         actor:SetRoll(3.14) --this is a barrel roll
                --         actor:SetYaw(1.57) --this rotates

                --     end
                -- end

                --model:TransitionToModelSceneID(PET_STABLE_MODEL_SCENE_ID, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_DISCARD, forceSceneChange);
            end
        end)
    
        self.talentTreesParent.petTalentParent.model:HookScript("OnMouseUp", function(model, button)
            if button == "LeftButton" then
                model.rotating = false
            end
        end)
    
        self.talentTreesParent.petTalentParent.model:HookScript("OnUpdate", function(model)
            if ( model.rotating ) then
                local x = GetCursorPosition();
                local diff = (x - model.rotateStartCursorX) * MODELFRAME_DRAG_ROTATION_CONSTANT;
                model.rotateStartCursorX = GetCursorPosition();
                model.yaw = (model.yaw or 1) + diff;
                -- model.pitch = (model.pitch or 1) + diff;
                -- model.roll = (model.roll or 1) + diff;
                if ( model.yaw < 0 ) then
                    model.yaw = model.yaw + (2 * PI);
                end
                if ( model.yaw > (2 * PI) ) then
                    model.yaw = model.yaw - (2 * PI);
                end
                -- if ( model.roll < 0 ) then
                --     model.roll = model.roll + (2 * PI);
                -- end
                -- if ( model.roll > (2 * PI) ) then
                --     model.roll = model.roll - (2 * PI);
                -- end
                -- if ( model.pitch < 0 ) then
                --     model.pitch = model.pitch + (2 * PI);
                -- end
                -- if ( model.pitch > (2 * PI) ) then
                --     model.pitch = model.pitch - (2 * PI);
                -- end
                model:SetRotation(model.yaw, false);
                --model:SetCameraOrientationByYawPitchRoll(model.yaw, 0,0)
                -- local actor = model:GetActorAtIndex(1);
                -- if actor then
                --     actor:SetYaw(model.yaw, false);
                -- end
            end
        end)



        self.talentTreesParent.petTalentParent.model:SetUnit("pet")

    else
        self.talentTreesParent.petSpec:Hide()
        self.talentTreesParent.playerSpec:Hide()
    end

    self:SetupOptionsPanel()

    --self:CreateClassData()

end


function ModernTalentsMixin:IterAllTalentFrames(func)
    for k, v in ipairs({"primaryTree", "secondaryTree1", "secondaryTree2"}) do
        for _, frame in ipairs(self.talentTreesParent[v]:GetFrames()) do
            func(frame)
        end
    end
end

function ModernTalentsMixin:FindTalentFromAddress(treeIndex, row, col)
    local index = ((row - 1) * 4) + col
    for k, v in ipairs({"primaryTree", "secondaryTree1", "secondaryTree2"}) do
        if self.talentTreesParent[v].treeIndex == treeIndex then
            return self.talentTreesParent[v].frames[index]
        end
    end
end

function ModernTalentsMixin:IterTalentTreeFrames(tabID, func)
    for k, v in ipairs({"primaryTree", "secondaryTree1", "secondaryTree2"}) do
        if self.talentTreesParent[v].treeIndex == tabID then
            for _, frame in ipairs(self.talentTreesParent[v]:GetFrames()) do
                func(frame)
            end
        end
    end
end


function ModernTalentsMixin:IterTalentTreesOrdered(func)
    local tabOrder = {}
    local fail;
    for k, v in ipairs({"primaryTree", "secondaryTree1", "secondaryTree2"}) do
        if not self.talentTreesParent[v].treeIndex then
            fail = true
        else
            tabOrder[self.talentTreesParent[v].treeIndex] = v
        end
    end
    if not fail then
        for k, v in ipairs(tabOrder) do
            for _, frame in ipairs(self.talentTreesParent[v]:GetFrames()) do
                func(frame)
            end
        end
    else

    end
end

function ModernTalentsMixin:CheckImportString(dataString)

    local source;
    local class, talents
    --https://www.wowhead.com/cata/talent-calc/paladin/003-32023023122100121231-002
    if string.find(dataString, "www.wowhead.com", nil, true) then
        source = "wowhead";
        local _, _, _, expansion, _, _class, _talents = strsplit("/", dataString)
        class = _class:upper()
        talents = _talents
    end

    if source and class and talents then
        local pointsSpent = self:GetTalentPointsFromDataString(talents)
        local pointString = string.format("%d-%d-%d", pointsSpent[1].points, pointsSpent[2].points, pointsSpent[3].points)
        self:SetTalentInfoText(string.format("Talent Data from %s for %s [%s]", source, class, pointString))
    end
end

function ModernTalentsMixin:InitializeTalentTabDropdown()

    local loadoutMenu = {}
    for k, v in ipairs(self.db.account.talentLoadouts) do
        if not loadoutMenu[v.class] then
            loadoutMenu[v.class] = {}
        end
        table.insert(loadoutMenu[v.class], v)
    end

    local classLoadoutMenu = {
        {
            text = UnitClass("player"),
            isTitle = true,
            notCheckable = true,
        }
    }
    for classID, loadouts in pairs(loadoutMenu) do
        if classID == select(3, UnitClass("player")) then
            for k, v in ipairs(loadouts) do
                table.insert(classLoadoutMenu, {
                    text = v.name,
                    notCheckable = true,
                    func = function()
                        self:OnLoadoutSelected(v)
                    end,
                })
            end
        end
    end

    local menu = {
        {
            text = string.format("%s %s", CreateAtlasMarkup("communities-icon-addgroupplus", 18, 18), L.SAVE_TALENTS),
            notCheckable = true,
            func = function()
                self:SaveTalentPreviewLoadout()
            end,
        },
        -- {
        --     text = "Export",
        --     notCheckable = true,
        --     func = function()
                
        --     end,
        -- },
        {
            text = string.format("%s %s", CreateAtlasMarkup("MovieRecordingIcon", 18, 18), L.RECORD_TALENTS),
            notCheckable = true,
            func = function()
                self.talentTreesParent.talentRecorderParent:Show()
            end,
        },
        {
            text = L.APPLY_TALENT_LOADOUT,
            hasArrow = true,
            notCheckable = true,
            menuList = classLoadoutMenu,
        },
    }



    UIDropDownMenu_SetWidth(self.talentTreesParent.talentLoadoutDropdown, 140)
    UIDropDownMenu_Initialize(self.talentTreesParent.talentLoadoutDropdown, function()

    end)

    --     for k, v in ipairs(menu) do
    --         local info = UIDropDownMenu_CreateInfo()
    --         if level == 1 then
    --             if k == 1 then
    --                 info.text = string.format("%s %s", CreateAtlasMarkup("communities-icon-addgroupplus"), v.text)
    --             else
    --                 info.text = v.text
    --             end
    --             info.notCheckable = true
    --             if v.func then
    --                 info.func = v.func
    --             end
    --             if k == 3 then
    --                 info.hasArrow = true
    --                 info.menuList = classLoadoutMenu
    --             end

    --             UIDropDownMenu_AddButton(info)
    --         else

    --             UIDropDownMenu_AddButton(info, level)
    --         end

    --         UIDropDownMenu_AddButton(info)
    --     end
    -- end)

    ModernTalentsTalentLoadoutDropdownButton:SetScript("OnClick", function()
        EasyMenu(menu, self.talentTreesParent.talentLoadoutDropdown, self.talentTreesParent.talentLoadoutDropdown, 10, 10, "NONE", 3)
    end)


    --self.talentTreesParent.talentLoadoutDropdown:SetMenu(menu)
end

function ModernTalentsMixin:OnLoadoutSelected(data)
    local tabID, loadout = self:ConvertTalentStringToInternalTable(data.loadout)
    self:AttemptPreviewTalentLoadout(data.class, tabID, loadout)
end


---Attempt to apply the talent loadout to the current activeSpecGroup
---@param class number checks the talent loadout against the current character class
---@param tabID number check the selected spec against the talent loadout spec
---@param loadout table a table of talent points that is looped and fed into the Blizz AddPreviewTalentPoints api
function ModernTalentsMixin:AttemptPreviewTalentLoadout(class, tabID, loadout)

    if loadout and (class == select(3, UnitClass("player"))) and self.selectedSpecInfo and (self.selectedSpecInfo.tabID == tabID) then

        PlayerTalentFrameResetButton_OnClick()
        self:SetView(2)

        self:Specialization_OnSelected(self.classSpecInfo[tabID])

        local activeTalentGroup = GetActiveTalentGroup(false, false)

        local i = 1;
        C_Timer.NewTicker(0.01, function()
            local talent = loadout[i]
            AddPreviewTalentPoints(talent.tabIndex, talent.talentIndex, 1, false, activeTalentGroup);
            i = i + 1;
        end, #loadout)

    else

        --add more fail reasons in time
        self:SetTalentInfoText(string.format("That loadout isn't compatible"))
    end
    
end

---Create a talent data string using the wowhead hyphen format
function ModernTalentsMixin:SaveTalentPreviewLoadout()

    local trees = {
        [1] = "",
        [2] = "",
        [3] = "",
    }
    local treeIndex = 0
    self:IterTalentTreesOrdered(function(f)
        if f.rowId == 1 and f.colId == 1 then
            treeIndex = treeIndex + 1
        end
        if f.talentIndex then
            trees[treeIndex] = string.format("%s%s", trees[treeIndex], f.previewRank or 0)
        end
    end)
    local s = string.format("%s-%s-%s", trees[1], trees[2], trees[3])

    StaticPopup_Show("ModernTalentsSaveLoadoutDialog", "Name", nil, {
        callback = function(name)
            local _, _, class = UnitClass("player")
            table.insert(self.db.account.talentLoadouts, {
                name = name,
                class = class,
                loadout = s,
            })
            self:InitializeTalentTabDropdown()
        end
    })

end

---Takes a string and looks for valid class and talent data
---@param dataString string import containing data
function ModernTalentsMixin:ImportTalentString(dataString)
    
    local source;
    local class, talents
    --https://www.wowhead.com/cata/talent-calc/paladin/003-32023023122100121231-002
    if string.find(dataString, "www.wowhead.com", nil, true) then
        source = "wowhead";
        local _, _, _, expansion, _, _class, _talents = strsplit("/", dataString)
        --print(expansion, class, talents)
        class = _class:upper()
        talents = _talents
    end

    for i = 1, 12 do
        local _, c, id = GetClassInfo(i)
        if c == class then
            class = id
        end
    end

    if source and (type(class) == "number") and talents then
        StaticPopup_Show("ModernTalentsSaveLoadoutDialog", "Name", nil, {
            callback = function(name)
                table.insert(self.db.account.talentLoadouts, {
                    name = name,
                    class = class,
                    loadout = talents,
                })
                self:InitializeTalentTabDropdown()
            end
        })
    end

end


---Parse a talent data string and return tab point spend data
---@param dataString string talent point data string
---@return table tab point spend - not sorted
function ModernTalentsMixin:GetTalentPointsFromDataString(dataString)

    local tabs = {strsplit("-", dataString)}

    --Cata requires 31 points to be spent in a primary tree before spending elsewhere
    --we need to know which tree to target first
    local pointsSpent = {
        { id = 1, points = 0 },
        { id = 2, points = 0 },
        { id = 3, points = 0 },
    }

    --loop the data and add the points spent per tree
    --then apply a simple sort allowing us to access the tree in the correct order
    for k, tab in ipairs(tabs) do
        if tab and (#tab > 0) then
            local tbl = {string.byte(tab, 1, #tab)}
            for i = 1, #tbl do
                local c = tonumber(string.char(tbl[i]))
                pointsSpent[k].points = pointsSpent[k].points + c
            end
        end
    end

    return pointsSpent;
end


---Create a table of talent points in col > row order that uses correct main spec
---@param dataString string talent data string
---@return number tabID of main spec
---@return table talents talents in point spent order assuming l-r t-b ordering of tree
function ModernTalentsMixin:ConvertTalentStringToInternalTable(dataString)

    if dataString then
        
        --wowhead uses a hyphen to split tree data
        local tabs = {strsplit("-", dataString)}

        --Cata requires 31 points to be spent in a primary tree before spending elsewhere
        --we need to know which tree to target first
        local pointsSpent = self:GetTalentPointsFromDataString(dataString)
        table.sort(pointsSpent, function(a, b)
            return a.points > b.points
        end)

        --not sure a timer is truely required but it shouldn't hurt to use
        local queue = {}

        --[[
            due to the UI of the addon the trees are not always ordered left to right as per the Blizzard UI
            
            to combat this requires some work as we need to pair the talent data with a treeIndex and talentIndex
            for the api to apply the preview

            loop the addon trees using the points spent sort table
            loop the tree talents and insert into the queue
        ]]
        for i, tab in ipairs(pointsSpent) do
            for _, v in ipairs({"primaryTree", "secondaryTree1", "secondaryTree2"}) do

                if self.talentTreesParent[v].treeIndex == tab.id then

                    local j = 1;
                    local talentString = tabs[tab.id]
                    if talentString then
                        for k, talent in ipairs(self.talentTreesParent[v]:GetFrames()) do
                            if talent.talentIndex then
                                --local rank = tonumber(string.char(tbl[j]))
                                local rank = tonumber(string.sub(talentString, j,j))
                                if rank and rank > 0 then
                                    for x = 1, rank do
                                        table.insert(queue, {
                                            tabIndex = tab.id,
                                            talentIndex = talent.talentIndex,
                                        })
                                        --print(tab.id, talent.rowId, talent.colId, rank)
                                    end
                                end
                                j = j + 1;
                            end
                        end
                    end
                end
            end
        end

        --DevTools_Dump(queue)

        return pointsSpent[1].id, queue


        -- local i = 1;
        -- C_Timer.NewTicker(0.01, function()
        --     local talent = queue[i]
        --     AddPreviewTalentPoints(queue[i].tabIndex, queue[i].talentIndex, 1, false, activeTalentGroup);
        --     i = i + 1;
        -- end, #queue)
    end
end


---Load the characters class spec data into the spec tab, this is done once for the players live talents/specs
---@param classID any
function ModernTalentsMixin:InitializeClassSpecializations(classID)

    self.classSpecInfo = Util.GetClassData(classID)

    local specPanel = self.specializationsParent;

    for k, frame in ipairs(specPanel.specs) do
        frame:Hide()
    end

    for i = 1, NUM_SPECIALIZATIONS do
        specPanel.specs[i]:Show()
        specPanel.specs[i]:SetWidth(specPanel:GetWidth() / NUM_SPECIALIZATIONS)
        specPanel.specs[i]:SetSpec(self.classSpecInfo[i])

        local role1, role2 = GetTalentTreeRoles(i, self.inspect, self.pet);
        specPanel.specs[i]:SetRole(role1, role2)

        if i > 1 then
            specPanel.specs[i]:ShowDivider()
        end
    end

    self:UpdateSpecializationTab(true)
end

function ModernTalentsMixin:UpdateSpecializationTab(showTab)

    local specPanel = self.specializationsParent;

    --get the tree with most points spent and assume its the chosen spec
    local points, tree, spec = 0, 0, 0
    for i = 1, NUM_SPECIALIZATIONS do
        local id, name, desc, fileID, pointsSpent, classSpec, y = GetTalentTabInfo(i)
        if pointsSpent > points then
            points = pointsSpent
            tree = i
            spec = id
        end

        --hide any selected artwork/highlighting
        specPanel.specs[i]:SetSelected()
    end

    for i = 1, NUM_SPECIALIZATIONS do
        
        if (points > 0) then
            specPanel.specs[i]:EnableActivateButton(false)
            if (i == tree) then
                specPanel.specs[tree]:SetSelected(true)
                self:Specialization_OnSelected(self.classSpecInfo[tree])
            end
        else
            specPanel.specs[i]:SetSelected()
            specPanel.specs[i]:EnableActivateButton(true)
            if self.classSpecInfo then
                self:Specialization_OnSelected(self.classSpecInfo[3])
            end
            if showTab then
                self:SetView(1)
            end
        end

    end

end


function ModernTalentsMixin:Specialization_OnSelected(info)

    self.selectedSpecInfo = info

    --keep the Blizzard UI updated
    local parent = _G["PlayerTalentFramePanel"..info.tabID]
    PlayerTalentFrameTalents.summariesShownWhenPrimary = false;
    if ( GetCVarBool("previewTalentsOption") ) then
        SetPreviewPrimaryTalentTree(parent.talentTree, parent.talentGroup);
    else
        SetPrimaryTalentTree(parent.talentTree);
    end
    
    self:SetView(2)

    self.talentTreesParent.background:SetTexture(info.backgroundFilePath)
    self.talentTreesParent.background:SetTexCoord(info.backgroundAtlas[1],info.backgroundAtlas[2],info.backgroundAtlas[3],info.backgroundAtlas[4])

    local j = 1;
    for i = 1, 3 do
        local id, name, description, icon, pointsSpent, background, previewPointsSpent, isUnlocked = GetTalentTabInfo(i)

        if id == info.specID then
            self.talentTreesParent.primaryTree.treeIndex = i
            self:BuildTalentTree(self.talentTreesParent.primaryTree, info.specID, true)
        else
            self.talentTreesParent["secondaryTree"..j].treeIndex = i
            self:BuildTalentTree(self.talentTreesParent["secondaryTree"..j], id, true)
            j = j + 1;
        end
    end

    self:UpdateTalentTrees()
    self:UpdatePetTalentTree()
end



function ModernTalentsMixin:UpdatePetTalentTree()

    --this needs to go elsewhere really
    if UnitName("pet") then
        self.talentTreesParent.petTalentParent.petName:SetText(string.format("%s %s %s", UnitName("pet"), LEVEL, UnitLevel("pet")))
    end
    
    local activeTalentGroup = GetActiveTalentGroup(false, true)

    local tree = self.talentTreesParent.petTalentParent.talentTree

    local id, name, description, icon, pointsSpent, background, previewPointsSpent, isUnlocked = GetTalentTabInfo(1, false, true, activeTalentGroup)

    if not name then
        return
    end

    local points = ( GetCVarBool("previewTalentsOption") == true ) and (pointsSpent + previewPointsSpent) or pointsSpent

    if isUnlocked then
        tree.header:SetText(string.format("%s\n%d %s", name, points, "Points spent"):upper())
    else
        tree.header:SetText(string.format("%s %s", name, CreateAtlasMarkup(addon.Constants.AtlasShortcuts.Padlock, 20, 24, 0, -18)))
    end

    local lastRowOpen = math.ceil(points / 5)

    if points % 5 == 0 then
        lastRowOpen = lastRowOpen + 1;
    end

    local unlockOffset = math.ceil(points / 5)
    if unlockOffset > 7 then
        unlockOffset = 7
    end
    if points % 5 == 0 then
        unlockOffset = unlockOffset + 1;
    end
    local rowHeight = tree:GetHeight() / 6

    tree.rowLockIcon:ClearAllPoints()
    tree.rowLockIcon:SetPoint("BOTTOMRIGHT", tree, "TOPLEFT", 0, (unlockOffset * -rowHeight))

    if unlockOffset < 7 then
        local spendText = "Spend %d\nto unlock"
        tree.pointsInfo:SetText(string.format(spendText, (unlockOffset * 5) - points))

        tree.rowLockIcon:Show()
        tree.pointsInfo:Show()

    else
        tree.rowLockIcon:Hide()
        tree.pointsInfo:Hide()
    end

    for _, frame in ipairs(tree:GetFrames()) do
        if (frame.rowId <= lastRowOpen) and frame.talentIndex then
            frame.icon:SetDesaturation(0)
        else
            frame.icon:SetDesaturation(1)
        end
    end
end


---Loop the talent trees and update the ui elements
function ModernTalentsMixin:UpdateTalentTrees()

    --local primaryTree = GetPreviewPrimaryTalentTree(false, false, spec.talentGroup) or GetPrimaryTalentTree(false, false, spec.talentGroup);

    --HasPetUI()
    --PlayerSpecTab_OnClick

    --self.talentTreesParent.helptip:Hide() NEXT_TALENT_LEVEL, GetNextTalentLevel()

    --self.talentTreesParent.helptip:SetText(string.format("%s\n%d %s %s", TALENT_TREE_LOCKED_TOOLTIP, GetNumTalentPoints(), BONUS_TALENTS, AVAILABLE))

    --GetUnspentTalentPoints(inspec, pet, group)
    --GetNumTalentPoints() --get available points

    --local id, name, description, icon, pointsSpent, background, previewPointsSpent, isUnlocked = GetTalentTabInfo(self.talentTree, self.inspect, self.pet, self.talentGroup);



    local activeTalentGroup = GetActiveTalentGroup(false, false)

    for i = 1, 2 do
        local tabID = GetPreviewPrimaryTalentTree(false, false, i) or GetPrimaryTalentTree(false, false, i)
        if tabID then
            local id, name, description, icon, pointsSpent, background, previewPointsSpent, isUnlocked = GetTalentTabInfo(tabID, false, false, i)
            if icon then
                self.talentTreesParent["spec"..i].icon:SetTexture(icon)
            end
        else
            self.talentTreesParent["spec"..i].icon:SetTexture(134400)
        end
        self.talentTreesParent["spec"..i].border:SetAtlas("charactercreate-ring-metallight")
    end

    self.talentTreesParent["spec"..activeTalentGroup].border:SetAtlas("charactercreate-ring-select")

    local treePoints = {0,0,0}
    local treeLastRowOpen = {1,1,1}
    local hasSpentPoints = false

    for k, line in ipairs(self.talentArrowLinesPool) do
        line:ClearAllPoints()
        line:Hide()
    end

    local lineIter = 1;

    for k, v in ipairs({"primaryTree", "secondaryTree1", "secondaryTree2"}) do

        local tree = self.talentTreesParent[v]

        if tree.treeIndex then

            local id, name, description, icon, pointsSpent, background, previewPointsSpent, isUnlocked = GetTalentTabInfo(tree.treeIndex, false, false, activeTalentGroup);

            if (previewPointsSpent > 0) and hasSpentPoints == false then
                hasSpentPoints = true
            end

            local points = ( GetCVarBool("previewTalentsOption") == true ) and (pointsSpent + previewPointsSpent) or pointsSpent

            treePoints[k] = points

            if isUnlocked then
                tree.header:SetText(string.format("%s\n%d %s", name, points, "Points spent"):upper())
            else
                tree.header:SetText(string.format("%s %s", name, CreateAtlasMarkup(addon.Constants.AtlasShortcuts.Padlock, 20, 24, 0, -18)))
            end

            local lastRowOpen = math.ceil(points / 5)

            if points % 5 == 0 then
                lastRowOpen = lastRowOpen + 1;
            end

            treeLastRowOpen[tree.treeIndex] = lastRowOpen
               
            if k == 1 then

                local unlockOffset = math.ceil(points / 5)
                if unlockOffset > 7 then
                    unlockOffset = 7
                end
                if points % 5 == 0 then
                    unlockOffset = unlockOffset + 1;
                end
                local rowHeight = tree:GetHeight() / 7
    
                tree.rowLockIcon:ClearAllPoints()
                tree.rowLockIcon:SetPoint("BOTTOMRIGHT", tree, "TOPLEFT", 0, (unlockOffset * -rowHeight))

                if unlockOffset < 7 then
                    local spendText = "Spend %d\nto unlock"
                    tree.pointsInfo:SetText(string.format(spendText, (unlockOffset * 5) - points))

                    tree.rowLockIcon:Show()
                    tree.pointsInfo:Show()

                else
                    tree.rowLockIcon:Hide()
                    tree.pointsInfo:Hide()
                end

                for _, frame in ipairs(tree:GetFrames()) do
                    if (frame.rowId <= lastRowOpen) and frame.talentIndex then
                        frame.icon:SetDesaturation(0)
                    else
                        frame.icon:SetDesaturation(1)
                    end
                end

            else
                if treePoints[1] > 30 then
                    for _, frame in ipairs(tree:GetFrames()) do
                        --frame:EnableMouse(true)
                        if (frame.rowId <= lastRowOpen) and frame.talentIndex then
                            frame.icon:SetDesaturation(0)
                        else
                            frame.icon:SetDesaturation(1)
                        end
                    end
                else
                    for _, frame in ipairs(tree:GetFrames()) do
                        --frame:EnableMouse(false)
                        frame.icon:SetDesaturation(1)
                    end
                end

            end

        end

    end

    ModernTalentsFrameLearnButtonTutorial:Hide()

    if hasSpentPoints then
        ModernTalentsFrameLearnButtonTutorial:Show()
    else
        if type(self.talentRecord) == "table" then
            ModernTalentsFrameLearnButtonTutorial:Show()
        else
            ModernTalentsFrameLearnButtonTutorial:Hide()
        end
    end

    if treePoints[1] > 30 then

        self.talentTreesParent.secondaryTree1.isUnlocked = true
        self.talentTreesParent.secondaryTree2.isUnlocked = true

        local pointsSpent = treePoints[1] + treePoints[2] + treePoints[3]

        if (GetNumTalentPoints() - pointsSpent) > 0 then
            self.talentTreesParent.helptip:SetText(string.format("%d Points Available", GetNumTalentPoints() - pointsSpent))

        else
            if GetNextTalentLevel() then
                self.talentTreesParent.helptip:SetText(NEXT_TALENT_LEVEL:format(GetNextTalentLevel()))
            end
        end


    else
        self.talentTreesParent.helptip:SetText(TALENT_TREE_LOCKED_TOOLTIP)

        self.talentTreesParent.secondaryTree1.isUnlocked = false
        self.talentTreesParent.secondaryTree2.isUnlocked = false
    end

    --this seems a bit much and should be incorporated into the above logic

    --[[
        it seems that using the above logic will cause the line to show hide as per row unlocking
        this is somewhat ok but i feel showing the relation permanently is better
    ]]
    for tabID = 1, 3 do
        self:IterTalentTreeFrames(tabID, function(f)

            if f.tabIndex and f.talentIndex then
                local tier, column, isLearnable = GetTalentPrereqs(f.tabIndex, f.talentIndex, false, false, activeTalentGroup)

                if tier and column then
                    --print(name, "has pre req")
                    local talent = self:FindTalentFromAddress(tabID, tier, column)
                    local _name, iconTexture, row, col, _rank, _maxRank, isExceptional, available, unKnown, isActive, y, talentID = GetTalentInfo(talent.tabIndex, talent.talentIndex)
                    
                    if ( GetCVarBool("previewTalentsOption") == true ) then
                        _rank = talent.previewRank
                    end
                    

                    if not self.talentArrowLinesPool[lineIter] then
                        local line = f:CreateLine(nil, "BACKGROUND", nil, -5)
                        line:SetThickness(6)
                        line:SetColorTexture(0.5, 0.5, 0.5)
                        self.talentArrowLinesPool[lineIter] = line
                    end

                    if _rank < _maxRank then
                        f.icon:SetDesaturation(1)
                        self.talentArrowLinesPool[lineIter]:SetColorTexture(0.5, 0.5, 0.5)
                    else
                        if treeLastRowOpen[tabID] >= f.rowId then
                            self.talentArrowLinesPool[lineIter]:SetColorTexture(0.9,0.8,0.0)
                            f.icon:SetDesaturation(0)
                        else
                            self.talentArrowLinesPool[lineIter]:SetColorTexture(0.5, 0.5, 0.5)
                            f.icon:SetDesaturation(1)
                        end
                    end

                    self.talentArrowLinesPool[lineIter]:SetParent(f)
                    self.talentArrowLinesPool[lineIter]:SetStartPoint("CENTER", talent, 0, 0)
                    self.talentArrowLinesPool[lineIter]:SetEndPoint("CENTER", f, 0, 0)
                    self.talentArrowLinesPool[lineIter]:Show()

                    lineIter = lineIter + 1
                end

            end
        end)
    end


end

---Build the talent tree for a specified talent tree ID
---@param tree frame the gridview tree to populate
---@param specID number the talent tab ID
---@param isPlayer any true if player to set talent indexes otherwise a valid classID
function ModernTalentsMixin:BuildTalentTree(tree, specID, isPlayer)

    local classID;
    if isPlayer == true then
        classID = select(3, UnitClass("player"))
    else
        if type(isPlayer) == "number" then
            classID = isPlayer
        end
    end

    if not classID then
        return
    end

    local activeTalentGroup = GetActiveTalentGroup(false, false)

    for k, frame in ipairs(tree:GetFrames()) do
        frame:ClearTalent()

        local row, col = frame.rowId, frame.colId
        if addon.Constants.TalentTrees[classID] and addon.Constants.TalentTrees[classID][specID] and addon.Constants.TalentTrees[classID][specID][row] and addon.Constants.TalentTrees[classID][specID][row][col] then
            
            if isPlayer then
                frame:SetTalentIndex(addon.Constants.TalentTrees[classID][specID][row][col])
            else
                frame:SetBaseTalent(addon.Constants.TalentTrees[classID][specID][row][col])
            end
        end

        -- if not isUnlocked then
        --     frame:EnableMouse(false)
        -- end
    end


end



function ModernTalentsMixin:BuildPetTalentTree()

    local activeTalentGroup = GetActiveTalentGroup(false, true)

    local specID, name, description, icon, pointsSpent, background, previewPointsSpent, isUnlocked = GetTalentTabInfo(1, false, true, activeTalentGroup);

    for k, frame in ipairs(self.talentTreesParent.petTalentParent.talentTree:GetFrames()) do
        frame:ClearTalent()

        local row, col = frame.rowId, frame.colId
        row = tostring(row)
        col = tostring(col)

        if addon.Constants.PetTalents and addon.Constants.PetTalents[specID] and addon.Constants.PetTalents[specID][row] and addon.Constants.PetTalents[specID][row][col] then
            
            frame:SetTalentIndex(addon.Constants.PetTalents[specID][row][col], true)
        end

    end
end





















--[[
    This systhem could almost be used to power the UI rather than using the massive data table
    However, the talent index is only used to learn talents and so only really applies to the players active talent set.
]]
function ModernTalentsMixin:MapClassTalentIndexes()
    
    self.talentIndexMap = {}
    for tabIndex = 1, GetNumTalentTabs() do
        local specID = GetTalentTabInfo(tabIndex)
        for talentIndex = 1, GetNumTalents(tabIndex) do
            local _, _, row, col = GetTalentInfo(tabIndex, talentIndex)

            if not self.talentIndexMap[specID] then
                self.talentIndexMap[specID] = {}
            end
            if not self.talentIndexMap[specID][row] then
                self.talentIndexMap[specID][row] = {}
            end
            self.talentIndexMap[specID][row][col] = {
                tabIndex = tabIndex,
                talentIndex = talentIndex,
            }

        end
    end

end

function ModernTalentsMixin:CreateClassData()

    --print("pet stuff")
    if MT_ACCOUNT then
    
        local id, name, description, icon, pointsSpent, background, previewPointsSpent, isUnlocked = GetTalentTabInfo(1, false, true, 1);

        if not MT_ACCOUNT.petTalents then
            MT_ACCOUNT.petTalents = {}
        end

        if id then
            if not MT_ACCOUNT.petTalents[id] then
                MT_ACCOUNT.petTalents[id] = {}
            end

            for talentIndex = 1, GetNumTalents(1, false, true) do

                -- 411 cunning "" 132168 0 HunterPetCunning 0 true
                -- 410 ferocity "" 132143 0 HunterPetFerocity 0 true
                -- 409 tenacity "" 132183 0 HunterPetTenacity 0 true


                local name, icon, row, col, rank, maxRank, isExceptional, available, x, y, z, talentID = GetTalentInfo(1, talentIndex, false, true, 1)

                row = tostring(row)
                col = tostring(col)

                local spells = {}
                for k, v in ipairs(addon.rawPetTalentData) do
                    if v[1] == talentID then
                        for i = 13, 15 do
                            if v[i] > 0 then
                                table.insert(spells, v[i])
                            end
                        end
                    end
                end

                if name then
                    if not MT_ACCOUNT.petTalents[id][row] then
                        MT_ACCOUNT.petTalents[id][row] = {}
                    end

                    MT_ACCOUNT.petTalents[id][row][col] = {
                        tabIndex = 1,
                        talentIndex = talentIndex,
                        talentSpellIDs = spells,
                    }
                end

            end
        end

    end

end













