

--[[
    spec tab is to show info about the class specs
    talent tab is character talents live view
    template tab is to view edit any talent tree/class
]]

local name, addon = ...;

local Util = addon.Util;

local NUM_SPECIALIZATIONS = 3

local letters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}

ModernTalentsMixin = {}

-- function ModernTalentsMixin:OnUpdate()
-- self.rebuildTalents
--     for k, v in ipairs(letters) do
        
--     end
-- end

function ModernTalentsMixin:OnLoad()

    self:RegisterForDrag("LeftButton")

    self:RegisterEvent("PREVIEW_TALENT_POINTS_CHANGED")
    self:RegisterEvent("PLAYER_TALENT_UPDATE")
    self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
    self:RegisterEvent("CONFIRM_TALENT_WIPE")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
   
    NineSliceUtil.ApplyLayout(self, addon.Constants.NineSliceLayouts.ParentBorder)

    self.specializationsParent.background:SetTexture("Interface/AddOns/ModernTalents/Media/Talents/Specialization.png")

    local atlasInfo = addon.Constants.Atlas["interface/talentframe/specialization"]["spec-background"]
    self.specializationsParent.background:SetTexCoord(atlasInfo[3],atlasInfo[4],atlasInfo[5],atlasInfo[6])

    --self.tab1:SetText(SWITCH)
    self.tab1:SetText(SPECIALIZATION)
    self.tab2:SetText(TALENTS)

    PanelTemplates_SetNumTabs(self, 2);
    PanelTemplates_SetTab(self, 1);

    for _, tab in ipairs(self.tabs) do
        tab:SetScript("OnClick", function()
            self:SetView(tab:GetID())
        end)
    end

    SetCVar("previewTalentsOption", true)

    local width = self:GetWidth()

    self.talentTreesParent:SetScript("OnShow", function()    
        --self:UpdateSpecializationTab()
    end)

    self.talentTreesParent.primaryTree:SetWidth(width*0.245)
    self.talentTreesParent.secondaryTree1:SetWidth(width*0.2)
    self.talentTreesParent.secondaryTree2:SetWidth(width*0.2)

    for k, v in ipairs({"primaryTree", "secondaryTree1", "secondaryTree2"}) do

        self.talentTreesParent[v]:InitFramePool("Frame", "ModernTalentsTalentIconTemplate")
        --self.talentTreesParent[v]:InitFramePool("Button", "PlayerTalentButtonTemplate")
        self.talentTreesParent[v]:SetFixedColumnCount(4)
        self.talentTreesParent[v].ScrollBar:Hide()

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
        self:UpdateSpecializationTab(true)
        self:UpdateTalentTrees()
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

    self.talentTreesParent.rebuildTalents:RegisterForClicks("AnyDown")
    self.talentTreesParent.rebuildTalents:SetAttribute("type", "macro")
    self.talentTreesParent.rebuildTalents:SetAttribute("macrotext", 
[[
/run TargetNearestFriend()
]])

    hooksecurefunc("ConfirmTalentWipe", function()
        -- self:IterAllTalentFrames(function(f)
        --     f.Update(f)
        -- end)
        -- self:UpdateTalentTrees()
    end)

    addon.CallbackRegistry:RegisterCallback(addon.Callbacks.Specialization_OnSelected, self.Specialization_OnSelected, self)
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
end

function ModernTalentsMixin:SetView(tabID)
    for k, view in ipairs(self.views) do
        view:Hide()
    end
    self.views[tabID]:Show()
    PanelTemplates_SetTab(self, tabID);
end

function ModernTalentsMixin:OnEvent(event, ...)
    if self[event] then
        self[event](self, ...)
    end
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
    self:UpdateSpecializationTab(true)
end

function ModernTalentsMixin:PLAYER_TALENT_UPDATE(...)
    self:IterAllTalentFrames(function(f)
        f.Update(f)
    end)
    self:UpdateTalentTrees()
    self:UpdateSpecializationTab()
end

function ModernTalentsMixin:PREVIEW_TALENT_POINTS_CHANGED(...)
    local talentIndex, tabID, specGroup, delta = ...;

    -- self:IterAllTalentFrames(function(f)
    --     f.Update(f)
    -- end)

    addon.CallbackRegistry:TriggerEvent(addon.Callbacks.Talent_OnPreviewPointsChanged, talentIndex, tabID, delta)

    self:UpdateTalentTrees()

    --print(string.format("TalentIndex %s, TabID %s, SpecGroup %s, Delta %s", talentIndex, tabID, specGroup, delta))
end

function ModernTalentsMixin:Init()

    if not MT_ACCOUNT then
        MT_ACCOUNT = {
            talentLoadouts = {},
        }
    end

    if not MT_CHARACTER then
        MT_CHARACTER = {}
    end

    self.db = {
        account = MT_ACCOUNT,
        character = MT_CHARACTER,
    }

end


function ModernTalentsMixin:IterAllTalentFrames(func)
    for k, v in ipairs({"primaryTree", "secondaryTree1", "secondaryTree2"}) do
        for _, frame in ipairs(self.talentTreesParent[v]:GetFrames()) do
            func(frame)
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

    local menu = {
        {
            text = "  Save Talents",
            icon = "communities-icon-addgroupplus",
            func = function()
                self:SaveTalentPreviewLoadout()
            end,
        },
        {
            text = "Export",
            func = function()
                
            end,
        },
    }

    for k, v in ipairs(self.db.account.talentLoadouts) do
        table.insert(menu, {
            text = v.name,
            func = function()
                self:OnLoadoutSelected(v)
            end,
        })
    end


    self.talentTreesParent.talentLoadoutDropdown:SetMenu(menu)
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
        end
    })

    self:InitializeTalentTabDropdown()
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
            end
        })
    end

    self:InitializeTalentTabDropdown()

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
            self:BuildTalentTree(self.talentTreesParent.primaryTree, info.specID, true)
            self.talentTreesParent.primaryTree.treeIndex = i
        else
            self:BuildTalentTree(self.talentTreesParent["secondaryTree"..j], id, true)
            self.talentTreesParent["secondaryTree"..j].treeIndex = i
            j = j + 1;
        end
    end

    self:UpdateTalentTrees()
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

    for k, v in ipairs({"primaryTree", "secondaryTree1", "secondaryTree2"}) do

        local tree = self.talentTreesParent[v]

        if tree.treeIndex then

            local id, name, description, icon, pointsSpent, background, previewPointsSpent, isUnlocked = GetTalentTabInfo(tree.treeIndex, false, false, activeTalentGroup);

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
                        frame:EnableMouse(true)
                        if (frame.rowId <= lastRowOpen) and frame.talentIndex then
                            frame.icon:SetDesaturation(0)
                        else
                            frame.icon:SetDesaturation(1)
                        end
                    end
                else
                    for _, frame in ipairs(tree:GetFrames()) do
                        frame:EnableMouse(false)
                        frame.icon:SetDesaturation(1)
                    end
                end

            end

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

function ModernTalentsMixin:CreateClassData(classID)
    
    if not MT_ACCOUNT.classData then
        MT_ACCOUNT.classData = {}
    end
    MT_ACCOUNT.classData[classID] = {}
    for tabIndex = 1, GetNumTalentTabs() do
        local specID = GetTalentTabInfo(tabIndex)
        for talentIndex = 1, GetNumTalents(tabIndex) do
            local _, _, row, col = GetTalentInfo(tabIndex, talentIndex)

            if not MT_ACCOUNT.classData[classID][specID] then
                MT_ACCOUNT.classData[classID][specID] = {}
            end
            if not MT_ACCOUNT.classData[classID][specID][row] then
                MT_ACCOUNT.classData[classID][specID][row] = {}
            end
            MT_ACCOUNT.classData[classID][specID][row][col] = {
                tabIndex = tabIndex,
                talentIndex = talentIndex,
                talentSpellIDs = addon.Constants.TalentTrees[tostring(specID)][tostring(row)][tostring(col)]
            }

        end
    end

end


















