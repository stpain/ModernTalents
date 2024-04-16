

local name, addon = ...;

StaticPopupDialogs['ModernTalentsSaveLoadoutDialog'] = {
    text = "%s.",
    button1 = YES,
    button2 = NO,
    OnAccept = function(self, data)
        local str = self.editBox:GetText()
        if str and (#str > 0) and (str ~= " ") then
            data.callback(str)
        end
    end,
    OnCancel = function(self)

    end,
    timeout = 0,
    hasEditBox = true,
    whileDead = true,
    hideOnEscape = false,
    preferredIndex = 3,
    showAlert = 1,
}

StaticPopupDialogs['ModernTalentsConfirmTalentRecordTalentSpendDialog'] = {
    text = "%s.",
    button1 = PREVIEW,
    button2 = LEARN,
    button3 = NO,
    OnAccept = function(self, data)
        data.accept()
    end,
    OnAlt = function(self, data)
        data.cancel()
    end,
    OnCancel = function(self, data)
        data.alt()
    end,
    timeout = 0,
    --hasEditBox = true,
    whileDead = true,
    hideOnEscape = false,
    preferredIndex = 3,
    showAlert = 1,
}

addon.Constants = {}

addon.Constants.Locales = {
    enUS = {
        SAVE_TALENTS = "Save Talents",
        RECORD_TALENTS = "Record Talents",
        APPLY_TALENT_LOADOUT = "Apply Talent loadout",

        TALENT_RECORDER_START = "Start recording talents",
        TALENT_RECORDER_RESTART = "Restart recording",
        TALENT_RECORDER_CONFIRM = "Save talent recording",
        TALENT_RECORDER_CANCEL = "Cancel",

        RECORD_TALENTS_HELPTIP = "You are currently recording talents, during this time learning talents is disabled."
    }
}

addon.Constants.AtlasShortcuts = {
    Padlock = "AdventureMapIcon-Lock",
    PadlockLarge = "BonusChest-Lock",
}

addon.Constants.NineSliceLayouts = {
    ParentBorder = {
        TopLeftCorner =	{ atlas = "Tooltip-NineSlice-CornerTopLeft", x=-3, y=3 },
        TopRightCorner =	{ atlas = "Tooltip-NineSlice-CornerTopRight", x=3, y=3 },
        BottomLeftCorner =	{ atlas = "Tooltip-NineSlice-CornerBottomLeft", x=-3, y=-3 },
        BottomRightCorner =	{ atlas = "Tooltip-NineSlice-CornerBottomRight", x=3, y=-3 },
        TopEdge = { atlas = "_Tooltip-NineSlice-EdgeTop", },
        BottomEdge = { atlas = "_Tooltip-NineSlice-EdgeBottom", },
        LeftEdge = { atlas = "!Tooltip-NineSlice-EdgeLeft", },
        RightEdge = { atlas = "!Tooltip-NineSlice-EdgeRight", },
    },
    ListviewMetal = {
        TopLeftCorner =	{ atlas = "UI-Frame-DiamondMetal-CornerTopLeft", x=-15, y=15 },
        TopRightCorner =	{ atlas = "UI-Frame-DiamondMetal-CornerTopRight", x=15, y=15 },
        BottomLeftCorner =	{ atlas = "UI-Frame-DiamondMetal-CornerBottomLeft", x=-15, y=-15 },
        BottomRightCorner =	{ atlas = "UI-Frame-DiamondMetal-CornerBottomRight", x=15, y=-15 },
        TopEdge = { atlas = "_UI-Frame-DiamondMetal-EdgeTop", },
        BottomEdge = { atlas = "_UI-Frame-DiamondMetal-EdgeBottom", },
        LeftEdge = { atlas = "!UI-Frame-DiamondMetal-EdgeLeft", },
        RightEdge = { atlas = "!UI-Frame-DiamondMetal-EdgeRight", },
        Center = { layer = "BACKGROUND", atlas = "ClassHall_InfoBoxMission-BackgroundTile", x = -20, y = 20, x1 = 20, y1 = -20 },
    },
    DeckListviewItem = {
        ["TopRightCorner"] = { atlas = "Tooltip-NineSlice-CornerTopRight" },
		["TopLeftCorner"] = { atlas = "Tooltip-NineSlice-CornerTopLeft" },
		["BottomLeftCorner"] = { atlas = "Tooltip-NineSlice-CornerBottomLeft" },
		["BottomRightCorner"] = { atlas = "Tooltip-NineSlice-CornerBottomRight" },
		["TopEdge"] = { atlas = "_Tooltip-NineSlice-EdgeTop" },
		["BottomEdge"] = { atlas = "_Tooltip-NineSlice-EdgeBottom" },
		["LeftEdge"] = { atlas = "!Tooltip-NineSlice-EdgeLeft" },
		["RightEdge"] = { atlas = "!Tooltip-NineSlice-EdgeRight" },
    }
}

addon.Constants.Atlas = {
    ["interface/talentframe/specialization"] = {
		["spec-background"] = { 1612, 856, 0.00048828125, 0.78759765625, 0.00048828125, 0.41845703125, false, false },
		["spec-columndivider"] = { 7, 856, 0.982421875, 0.98583984375, 0.00048828125, 0.41845703125, false, false },
		["spec-dividerline"] = { 254, 2, 0.00048828125, 0.12451171875, 0.93798828125, 0.93896484375, false, false },
		["spec-hover-background"] = { 395, 856, 0.78857421875, 0.9814453125, 0.00048828125, 0.41845703125, false, false },
		["spec-role-dps"] = { 29, 29, 0.15869140625, 0.1728515625, 0.86865234375, 0.8828125, false, false },
		["spec-role-heal"] = { 29, 29, 0.173828125, 0.18798828125, 0.86865234375, 0.8828125, false, false },
		["spec-role-tank"] = { 29, 29, 0.15869140625, 0.1728515625, 0.8837890625, 0.89794921875, false, false },
		["spec-sampleabilityring"] = { 62, 60, 0.15869140625, 0.18896484375, 0.83837890625, 0.86767578125, false, false },
		["spec-selected-background1"] = { 395, 856, 0.00048828125, 0.193359375, 0.41943359375, 0.83740234375, false, false },
		["spec-selected-background2"] = { 395, 856, 0.1943359375, 0.38720703125, 0.41943359375, 0.83740234375, false, false },
		["spec-selected-background3"] = { 395, 856, 0.38818359375, 0.5810546875, 0.41943359375, 0.83740234375, false, false },
		["spec-selected-background4"] = { 395, 856, 0.58203125, 0.77490234375, 0.41943359375, 0.83740234375, false, false },
		["spec-selected-background5"] = { 395, 856, 0.77587890625, 0.96875, 0.41943359375, 0.83740234375, false, false },
		["spec-thumbnailborder-off"] = { 322, 202, 0.00048828125, 0.15771484375, 0.83837890625, 0.93701171875, false, false },
		["spec-thumbnailborder-on"] = { 322, 202, 0.1943359375, 0.3515625, 0.83837890625, 0.93701171875, false, false },
	},
	["interface/talentframe/specialization2"] = {
		["spec-animations-mask-filigree-activate"] = { 2048, 1024, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/specializationclassthumbnails"] = {
		["spec-thumbnail-deathknight-blood"] = { 306, 186, 0.00048828125, 0.14990234375, 0.00048828125, 0.09130859375, false, false },
		["spec-thumbnail-deathknight-frost"] = { 306, 186, 0.15087890625, 0.30029296875, 0.00048828125, 0.09130859375, false, false },
		["spec-thumbnail-deathknight-unholy"] = { 306, 186, 0.30126953125, 0.45068359375, 0.00048828125, 0.09130859375, false, false },
		["spec-thumbnail-demonhunter-havoc"] = { 306, 186, 0.45166015625, 0.60107421875, 0.00048828125, 0.09130859375, false, false },
		["spec-thumbnail-demonhunter-vengeance"] = { 306, 186, 0.60205078125, 0.75146484375, 0.00048828125, 0.09130859375, false, false },
		["spec-thumbnail-druid-balance"] = { 306, 186, 0.75244140625, 0.90185546875, 0.00048828125, 0.09130859375, false, false },
		["spec-thumbnail-druid-feral"] = { 306, 186, 0.00048828125, 0.14990234375, 0.09228515625, 0.18310546875, false, false },
		["spec-thumbnail-druid-guardian"] = { 306, 186, 0.15087890625, 0.30029296875, 0.09228515625, 0.18310546875, false, false },
		["spec-thumbnail-druid-restoration"] = { 306, 186, 0.30126953125, 0.45068359375, 0.09228515625, 0.18310546875, false, false },
		["spec-thumbnail-evoker-augmentation"] = { 306, 186, 0.60205078125, 0.75146484375, 0.45947265625, 0.55029296875, false, false },
		["spec-thumbnail-evoker-devastation"] = { 306, 186, 0.45166015625, 0.60107421875, 0.09228515625, 0.18310546875, false, false },
		["spec-thumbnail-evoker-preservation"] = { 306, 186, 0.60205078125, 0.75146484375, 0.09228515625, 0.18310546875, false, false },
		["spec-thumbnail-hunter-beastmastery"] = { 306, 186, 0.75244140625, 0.90185546875, 0.09228515625, 0.18310546875, false, false },
		["spec-thumbnail-hunter-marksmanship"] = { 306, 186, 0.00048828125, 0.14990234375, 0.18408203125, 0.27490234375, false, false },
		["spec-thumbnail-hunter-survival"] = { 306, 186, 0.15087890625, 0.30029296875, 0.18408203125, 0.27490234375, false, false },
		["spec-thumbnail-mage-arcane"] = { 306, 186, 0.30126953125, 0.45068359375, 0.18408203125, 0.27490234375, false, false },
		["spec-thumbnail-mage-fire"] = { 306, 186, 0.45166015625, 0.60107421875, 0.18408203125, 0.27490234375, false, false },
		["spec-thumbnail-mage-frost"] = { 306, 186, 0.60205078125, 0.75146484375, 0.18408203125, 0.27490234375, false, false },
		["spec-thumbnail-monk-brewmaster"] = { 306, 186, 0.75244140625, 0.90185546875, 0.18408203125, 0.27490234375, false, false },
		["spec-thumbnail-monk-mistweaver"] = { 306, 186, 0.00048828125, 0.14990234375, 0.27587890625, 0.36669921875, false, false },
		["spec-thumbnail-monk-windwalker"] = { 306, 186, 0.15087890625, 0.30029296875, 0.27587890625, 0.36669921875, false, false },
		["spec-thumbnail-paladin-holy"] = { 306, 186, 0.30126953125, 0.45068359375, 0.27587890625, 0.36669921875, false, false },
		["spec-thumbnail-paladin-protection"] = { 306, 186, 0.45166015625, 0.60107421875, 0.27587890625, 0.36669921875, false, false },
		["spec-thumbnail-paladin-retribution"] = { 306, 186, 0.60205078125, 0.75146484375, 0.27587890625, 0.36669921875, false, false },
		["spec-thumbnail-priest-discipline"] = { 306, 186, 0.75244140625, 0.90185546875, 0.27587890625, 0.36669921875, false, false },
		["spec-thumbnail-priest-holy"] = { 306, 186, 0.00048828125, 0.14990234375, 0.36767578125, 0.45849609375, false, false },
		["spec-thumbnail-priest-shadow"] = { 306, 186, 0.15087890625, 0.30029296875, 0.36767578125, 0.45849609375, false, false },
		["spec-thumbnail-rogue-assassination"] = { 306, 186, 0.30126953125, 0.45068359375, 0.36767578125, 0.45849609375, false, false },
		["spec-thumbnail-rogue-outlaw"] = { 306, 186, 0.45166015625, 0.60107421875, 0.36767578125, 0.45849609375, false, false },
		["spec-thumbnail-rogue-subtlety"] = { 306, 186, 0.60205078125, 0.75146484375, 0.36767578125, 0.45849609375, false, false },
		["spec-thumbnail-shaman-elemental"] = { 306, 186, 0.75244140625, 0.90185546875, 0.36767578125, 0.45849609375, false, false },
		["spec-thumbnail-shaman-enhancement"] = { 306, 186, 0.00048828125, 0.14990234375, 0.45947265625, 0.55029296875, false, false },
		["spec-thumbnail-shaman-restoration"] = { 306, 186, 0.00048828125, 0.14990234375, 0.55126953125, 0.64208984375, false, false },
		["spec-thumbnail-warlock-affliction"] = { 306, 186, 0.00048828125, 0.14990234375, 0.64306640625, 0.73388671875, false, false },
		["spec-thumbnail-warlock-demonology"] = { 306, 186, 0.00048828125, 0.14990234375, 0.73486328125, 0.82568359375, false, false },
		["spec-thumbnail-warlock-destruction"] = { 306, 186, 0.00048828125, 0.14990234375, 0.82666015625, 0.91748046875, false, false },
		["spec-thumbnail-warrior-arms"] = { 306, 186, 0.15087890625, 0.30029296875, 0.45947265625, 0.55029296875, false, false },
		["spec-thumbnail-warrior-fury"] = { 306, 186, 0.30126953125, 0.45068359375, 0.45947265625, 0.55029296875, false, false },
		["spec-thumbnail-warrior-protection"] = { 306, 186, 0.45166015625, 0.60107421875, 0.45947265625, 0.55029296875, false, false },
	},
	["interface/talentframe/talentframeatlas"] = {
		["_Talent-blue-glow"] = { 16, 16, 0, 0.0625, 0.0009765625, 0.0166015625, true, false },
		["_Talent-Bottom-Tile"] = { 64, 5, 0, 0.25, 0.0771484375, 0.08203125, true, false },
		["_Talent-green-glow"] = { 16, 16, 0, 0.0625, 0.083984375, 0.099609375, true, false },
		["_Talent-Top-Tile"] = { 64, 13, 0, 0.25, 0.0625, 0.0751953125, true, false },
		["pvptalents-background"] = { 131, 379, 0.00390625, 0.515625, 0.5546875, 0.9248046875, false, false },
		["pvptalents-list-background"] = { 147, 40, 0.19921875, 0.7734375, 0.1474609375, 0.1865234375, false, false },
		["pvptalents-list-background-mouseover"] = { 147, 40, 0.26171875, 0.8359375, 0.1962890625, 0.2353515625, false, false },
		["pvptalents-list-background-selected"] = { 147, 40, 0.27734375, 0.8515625, 0.251953125, 0.291015625, false, false },
		["pvptalents-list-checkmark"] = { 28, 26, 0.78125, 0.890625, 0.1474609375, 0.1728515625, false, false },
		["pvptalents-selectedarrow"] = { 43, 44, 0.79296875, 0.9609375, 0.455078125, 0.498046875, false, false },
		["pvptalents-talentborder"] = { 58, 58, 0.5234375, 0.75, 0.634765625, 0.69140625, false, false },
		["pvptalents-talentborder-empty"] = { 80, 80, 0.5234375, 0.8359375, 0.5546875, 0.6328125, false, false },
		["pvptalents-talentborder-glow"] = { 68, 68, 0.00390625, 0.26953125, 0.302734375, 0.369140625, false, false },
		["pvptalents-talentborder-locked"] = { 58, 58, 0.7578125, 0.984375, 0.634765625, 0.69140625, false, false },
		["pvptalents-warmode-firecover"] = { 127, 73, 0.00390625, 0.5, 0.9267578125, 0.998046875, false, false },
		["pvptalents-warmode-glow"] = { 105, 110, 0.5234375, 0.93359375, 0.693359375, 0.80078125, false, false },
		["pvptalents-warmode-incentive-ring"] = { 48, 48, 0.00390625, 0.19140625, 0.1474609375, 0.1943359375, false, false },
		["pvptalents-warmode-orb"] = { 80, 84, 0.32421875, 0.63671875, 0.37109375, 0.453125, false, false },
		["pvptalents-warmode-ring"] = { 80, 84, 0.64453125, 0.95703125, 0.37109375, 0.453125, false, false },
		["pvptalents-warmode-ring-disabled"] = { 80, 84, 0.00390625, 0.31640625, 0.37109375, 0.453125, false, false },
		["pvptalents-warmode-swords"] = { 46, 43, 0.75390625, 0.93359375, 0.1015625, 0.1435546875, false, false },
		["pvptalents-warmode-swords-disabled"] = { 46, 43, 0.79296875, 0.97265625, 0.302734375, 0.3447265625, false, false },
		["Talent-Background"] = { 32, 43, 0, 0.125, 0.0185546875, 0.060546875, true, false },
		["Talent-BottomLeftCurlies"] = { 65, 55, 0.5234375, 0.77734375, 0.921875, 0.9755859375, false, false },
		["Talent-BottomRightCurlies"] = { 65, 55, 0.27734375, 0.53125, 0.302734375, 0.3564453125, false, false },
		["Talent-Highlight"] = { 200, 53, 0.00390625, 0.78515625, 0.455078125, 0.5068359375, false, false },
		["Talent-RingWithDot"] = { 121, 120, 0.5234375, 0.99609375, 0.802734375, 0.919921875, false, false },
		["Talent-Selection"] = { 190, 45, 0.00390625, 0.74609375, 0.1015625, 0.1455078125, false, false },
		["Talent-Selection-Legendary"] = { 190, 45, 0.00390625, 0.74609375, 0.5087890625, 0.552734375, false, false },
		["Talent-Separator"] = { 68, 50, 0.00390625, 0.26953125, 0.251953125, 0.30078125, false, false },
		["Talent-TopLeftCurlies"] = { 63, 55, 0.5390625, 0.78515625, 0.302734375, 0.3564453125, false, false },
		["Talent-TopRightCurlies"] = { 64, 55, 0.00390625, 0.25390625, 0.1962890625, 0.25, false, false },
	},
	["interface/talentframe/talents"] = {
		["talents-arrow-head-ghost"] = { 14, 12, 0.94384765625, 0.95751953125, 0.0009765625, 0.0244140625, false, false },
		["talents-arrow-head-gray"] = { 14, 12, 0.95849609375, 0.97216796875, 0.0009765625, 0.0244140625, false, false },
		["talents-arrow-head-locked"] = { 14, 12, 0.97314453125, 0.98681640625, 0.0009765625, 0.0244140625, false, false },
		["talents-arrow-head-red"] = { 14, 12, 0.96630859375, 0.97998046875, 0.0380859375, 0.0615234375, false, false },
		["talents-arrow-head-yellow"] = { 14, 12, 0.98095703125, 0.99462890625, 0.0380859375, 0.0615234375, false, false },
		["talents-background-bottombar"] = { 1612, 82, 0.00048828125, 0.78759765625, 0.0009765625, 0.0810546875, false, false },
		["talents-button-reset"] = { 20, 20, 0.94580078125, 0.96533203125, 0.0380859375, 0.0771484375, false, false },
		["talents-button-undo"] = { 21, 20, 0.92431640625, 0.94482421875, 0.0380859375, 0.0771484375, false, false },
		["talents-gate"] = { 84, 14, 0.00048828125, 0.08251953125, 0.9658203125, 0.9931640625, false, false },
		["talents-gate-open"] = { 84, 14, 0.8837890625, 0.9658203125, 0.0830078125, 0.1103515625, false, false },
		["talents-icon-learnableplus"] = { 19, 18, 0.92431640625, 0.94287109375, 0.0009765625, 0.0361328125, false, false },
		["talents-node-choice-ghost"] = { 60, 52, 0.36865234375, 0.42724609375, 0.1708984375, 0.2724609375, false, false },
		["talents-node-choice-gray"] = { 58, 52, 0.36865234375, 0.42529296875, 0.2744140625, 0.3759765625, false, false },
		["talents-node-choice-green"] = { 58, 52, 0.36865234375, 0.42529296875, 0.3779296875, 0.4794921875, false, false },
		["talents-node-choice-greenglow"] = { 88, 84, 0.13623046875, 0.22216796875, 0.3681640625, 0.5322265625, false, false },
		["talents-node-choice-locked"] = { 58, 52, 0.36865234375, 0.42529296875, 0.4814453125, 0.5830078125, false, false },
		["talents-node-choice-red"] = { 58, 52, 0.36865234375, 0.42529296875, 0.5849609375, 0.6865234375, false, false },
		["talents-node-choice-shadow"] = { 76, 76, 0.693359375, 0.73046875, 0.0830078125, 0.1572265625, false, false },
		["talents-node-choice-yellow"] = { 58, 52, 0.36865234375, 0.42529296875, 0.6884765625, 0.7900390625, false, false },
		["talents-node-choiceflyout-circle-ghost"] = { 68, 68, 0.13623046875, 0.20263671875, 0.8564453125, 0.9892578125, false, false },
		["talents-node-choiceflyout-circle-gray"] = { 64, 64, 0.09326171875, 0.12451171875, 0.9306640625, 0.9931640625, false, false },
		["talents-node-choiceflyout-circle-green"] = { 64, 64, 0.30517578125, 0.33642578125, 0.9228515625, 0.9853515625, false, false },
		["talents-node-choiceflyout-circle-greenglow"] = { 108, 108, 0.42822265625, 0.48095703125, 0.4814453125, 0.5869140625, false, false },
		["talents-node-choiceflyout-circle-locked"] = { 64, 64, 0.42822265625, 0.45947265625, 0.7958984375, 0.8583984375, false, false },
		["talents-node-choiceflyout-circle-red"] = { 64, 64, 0.42822265625, 0.45947265625, 0.8603515625, 0.9228515625, false, false },
		["talents-node-choiceflyout-circle-shadow"] = { 154, 154, 0.22900390625, 0.30419921875, 0.1708984375, 0.3212890625, false, false },
		["talents-node-choiceflyout-circle-yellow"] = { 64, 64, 0.42822265625, 0.45947265625, 0.9248046875, 0.9873046875, false, false },
		["talents-node-choiceflyout-square-ghost"] = { 76, 76, 0.22900390625, 0.30322265625, 0.3232421875, 0.4716796875, false, false },
		["talents-node-choiceflyout-square-gray"] = { 64, 64, 0.22900390625, 0.29150390625, 0.4736328125, 0.5986328125, false, false },
		["talents-node-choiceflyout-square-green"] = { 64, 64, 0.22900390625, 0.29150390625, 0.6005859375, 0.7255859375, false, false },
		["talents-node-choiceflyout-square-greenglow"] = { 108, 108, 0.00048828125, 0.10595703125, 0.5556640625, 0.7666015625, false, false },
		["talents-node-choiceflyout-square-locked"] = { 64, 64, 0.22900390625, 0.29150390625, 0.7275390625, 0.8525390625, false, false },
		["talents-node-choiceflyout-square-red"] = { 64, 64, 0.22900390625, 0.29150390625, 0.8544921875, 0.9794921875, false, false },
		["talents-node-choiceflyout-square-shadow"] = { 158, 158, 0.13623046875, 0.21337890625, 0.7001953125, 0.8544921875, false, false },
		["talents-node-choiceflyout-square-yellow"] = { 64, 64, 0.30517578125, 0.36767578125, 0.1708984375, 0.2958984375, false, false },
		["talents-node-circle-ghost"] = { 52, 52, 0.42822265625, 0.47900390625, 0.5888671875, 0.6904296875, false, false },
		["talents-node-circle-gray"] = { 40, 40, 0.10693359375, 0.13134765625, 0.5556640625, 0.6044921875, false, false },
		["talents-node-circle-green"] = { 40, 40, 0.10693359375, 0.13134765625, 0.6064453125, 0.6552734375, false, false },
		["talents-node-circle-greenglow"] = { 82, 82, 0.09326171875, 0.13330078125, 0.7685546875, 0.8486328125, false, false },
		["talents-node-circle-locked"] = { 40, 40, 0.10693359375, 0.13134765625, 0.6572265625, 0.7060546875, false, false },
		["talents-node-circle-red"] = { 40, 40, 0.10693359375, 0.13134765625, 0.7080078125, 0.7568359375, false, false },
		["talents-node-circle-shadow"] = { 76, 76, 0.7314453125, 0.7685546875, 0.0830078125, 0.1572265625, false, false },
		["talents-node-circle-yellow"] = { 40, 40, 0.8837890625, 0.908203125, 0.1123046875, 0.1611328125, false, false },
		["talents-node-pvp-filled"] = { 58, 52, 0.36865234375, 0.42529296875, 0.7919921875, 0.8935546875, false, false },
		["talents-node-pvp-green"] = { 58, 52, 0.36865234375, 0.42529296875, 0.8955078125, 0.9970703125, false, false },
		["talents-node-pvp-inspect"] = { 58, 52, 0.42822265625, 0.48486328125, 0.1708984375, 0.2724609375, false, false },
		["talents-node-pvp-inspect-empty"] = { 58, 52, 0.42822265625, 0.48486328125, 0.2744140625, 0.3759765625, false, false },
		["talents-node-pvp-locked"] = { 58, 52, 0.42822265625, 0.48486328125, 0.3779296875, 0.4794921875, false, false },
		["talents-node-pvp-shadow"] = { 78, 77, 0.654296875, 0.6923828125, 0.0830078125, 0.158203125, false, false },
		["talents-node-pvpflyout-green"] = { 38, 38, 0.76953125, 0.806640625, 0.0830078125, 0.1572265625, false, false },
		["talents-node-pvpflyout-yellow"] = { 38, 38, 0.8076171875, 0.8447265625, 0.0830078125, 0.1572265625, false, false },
		["talents-node-pvpflyout-yellow-dimmed"] = { 38, 38, 0.845703125, 0.8828125, 0.0830078125, 0.1572265625, false, false },
		["talents-node-square-ghost"] = { 52, 52, 0.42822265625, 0.47900390625, 0.6923828125, 0.7939453125, false, false },
		["talents-node-square-gray"] = { 40, 40, 0.09326171875, 0.13232421875, 0.8505859375, 0.9287109375, false, false },
		["talents-node-square-green"] = { 40, 40, 0.455078125, 0.494140625, 0.0830078125, 0.1611328125, false, false },
		["talents-node-square-greenglow"] = { 84, 84, 0.13623046875, 0.21826171875, 0.5341796875, 0.6982421875, false, false },
		["talents-node-square-locked"] = { 40, 40, 0.4951171875, 0.5341796875, 0.0830078125, 0.1611328125, false, false },
		["talents-node-square-red"] = { 40, 40, 0.53515625, 0.57421875, 0.0830078125, 0.1611328125, false, false },
		["talents-node-square-shadow"] = { 78, 78, 0.615234375, 0.6533203125, 0.0830078125, 0.1591796875, false, false },
		["talents-node-square-yellow"] = { 40, 40, 0.5751953125, 0.6142578125, 0.0830078125, 0.1611328125, false, false },
		["talents-pvpflyout-background-bottom"] = { 276, 36, 0.78857421875, 0.92333984375, 0.0009765625, 0.0361328125, false, false },
		["talents-pvpflyout-background-middle"] = { 276, 482, 0.00048828125, 0.13525390625, 0.0830078125, 0.5537109375, false, false },
		["talents-pvpflyout-background-top"] = { 276, 29, 0.78857421875, 0.92333984375, 0.0380859375, 0.06640625, false, false },
		["talents-pvpflyout-rowhighlight"] = { 276, 44, 0.13623046875, 0.40576171875, 0.0830078125, 0.1689453125, false, false },
		["talents-search-exactmatch"] = { 63, 63, 0.30517578125, 0.36669921875, 0.2978515625, 0.4208984375, false, false },
		["talents-search-match"] = { 63, 63, 0.30517578125, 0.36669921875, 0.4228515625, 0.5458984375, false, false },
		["talents-search-notonactionbar"] = { 63, 63, 0.30517578125, 0.36669921875, 0.5478515625, 0.6708984375, false, false },
		["talents-search-notonactionbarhidden"] = { 63, 63, 0.30517578125, 0.36669921875, 0.6728515625, 0.7958984375, false, false },
		["talents-search-relatedmatch"] = { 63, 63, 0.30517578125, 0.36669921875, 0.7978515625, 0.9208984375, false, false },
		["talents-search-suggestion-itemborder"] = { 18, 18, 0.96630859375, 0.97509765625, 0.0634765625, 0.0810546875, false, false },
		["talents-search-suggestion-magnifyingglass"] = { 12, 12, 0.98779296875, 0.99951171875, 0.0009765625, 0.0244140625, false, false },
		["talents-warmode-indent"] = { 97, 87, 0.40673828125, 0.4541015625, 0.0830078125, 0.16796875, false, false },
		["talents-warmode-ring"] = { 94, 100, 0.00048828125, 0.09228515625, 0.7685546875, 0.9638671875, false, false },
		["talents-warmode-ring-disabled"] = { 94, 100, 0.13623046875, 0.22802734375, 0.1708984375, 0.3662109375, false, false },
	},
	["interface/talentframe/talentsanimations2"] = {
		["talents-animations-activationgrid"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-animations-class-evoker"] = { 461, 461, 0.64013671875, 0.865234375, 0.37939453125, 0.6044921875, false, false },
		["talents-animations-particles"] = { 1308, 774, 0.00048828125, 0.63916015625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsanimations3"] = {
		["talents-animations-class-deathknight"] = { 461, 461, 0.50146484375, 0.7265625, 0.00048828125, 0.2255859375, false, false },
		["talents-animations-class-demonhunter"] = { 461, 461, 0.7275390625, 0.95263671875, 0.00048828125, 0.2255859375, false, false },
		["talents-animations-class-druid"] = { 461, 461, 0.50146484375, 0.7265625, 0.2265625, 0.45166015625, false, false },
		["talents-animations-class-hunter"] = { 461, 461, 0.7275390625, 0.95263671875, 0.2265625, 0.45166015625, false, false },
		["talents-animations-class-mage"] = { 461, 461, 0.00048828125, 0.2255859375, 0.50146484375, 0.7265625, false, false },
		["talents-animations-class-monk"] = { 461, 461, 0.00048828125, 0.2255859375, 0.7275390625, 0.95263671875, false, false },
		["talents-animations-class-paladin"] = { 461, 461, 0.2265625, 0.45166015625, 0.50146484375, 0.7265625, false, false },
		["talents-animations-class-priest"] = { 461, 461, 0.2265625, 0.45166015625, 0.7275390625, 0.95263671875, false, false },
		["talents-animations-class-rogue"] = { 461, 461, 0.45263671875, 0.677734375, 0.50146484375, 0.7265625, false, false },
		["talents-animations-class-shaman"] = { 461, 461, 0.45263671875, 0.677734375, 0.7275390625, 0.95263671875, false, false },
		["talents-animations-class-warlock"] = { 461, 461, 0.6787109375, 0.90380859375, 0.50146484375, 0.7265625, false, false },
		["talents-animations-class-warrior"] = { 461, 461, 0.6787109375, 0.90380859375, 0.7275390625, 0.95263671875, false, false },
		["talents-animations-gridburst"] = { 1024, 1024, 0.00048828125, 0.50048828125, 0.00048828125, 0.50048828125, false, false },
	},
	["interface/talentframe/talentsanimations4"] = {
		["talents-animations-titans"] = { 972, 810, 0.0009765625, 0.9501953125, 0.0009765625, 0.7919921875, false, false },
	},
	["interface/talentframe/talentsanimationsmaskfiligree"] = {
		["talents-animations-mask-filigree"] = { 2048, 1024, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmaskfiligreeactivate"] = {
		["talents-animations-mask-filigree-activate"] = { 2048, 1024, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmaskfull"] = {
		["talents-animations-mask-full"] = { 1024, 1024, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmasknodesheenchoice"] = {
		["talents-node-choice-sheenmask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmasknodesheenchoiceflyoutcircle"] = {
		["talents-node-choiceflyout-circle-sheenmask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmasknodesheenchoiceflyoutsquare"] = {
		["talents-node-choiceflyout-square-sheenmask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmasknodesheencircle"] = {
		["talents-node-circle-sheenmask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmasknodesheensquare"] = {
		["talents-node-square-sheenmask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmaskspecart"] = {
		["talents-animations-mask-specart"] = { 2048, 1024, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationsmaskspecartmid"] = {
		["talents-animations-mask-specart-mid"] = { 2048, 1024, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsanimationssheen"] = {
		["talents-animations-clouds"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-animations-sheen"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsarrowline"] = {
		["talents-arrow-line-ghost"] = { 8, 8, 0, 1, 0.0078125, 0.1328125, true, false },
		["talents-arrow-line-gray"] = { 8, 8, 0, 1, 0.1484375, 0.2734375, true, false },
		["talents-arrow-line-locked"] = { 8, 8, 0, 1, 0.2890625, 0.4140625, true, false },
		["talents-arrow-line-red"] = { 8, 8, 0, 1, 0.5703125, 0.6953125, true, false },
		["talents-arrow-line-yellow"] = { 8, 8, 0, 1, 0.4296875, 0.5546875, true, false },
	},
	["interface/talentframe/talentsclassbackgrounddeathknight1"] = {
		["talents-background-deathknight-blood"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-deathknight-frost"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgrounddeathknight2"] = {
		["talents-background-deathknight-unholy"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },
	},
	["interface/talentframe/talentsclassbackgrounddemonhunter"] = {
		["talents-background-demonhunter-havoc"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-demonhunter-vengeance"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgrounddruid1"] = {
		["talents-background-druid-balance"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-druid-feral"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgrounddruid2"] = {
		["talents-background-druid-guardian"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-druid-restoration"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgroundevoker"] = {
		["talents-background-evoker-devastation"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-evoker-preservation"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgroundevoker2"] = {
		["talents-background-evoker-augmentation"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },
	},
	["interface/talentframe/talentsclassbackgroundhunter1"] = {
		["talents-background-hunter-beastmastery"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-hunter-marksmanship"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgroundhunter2"] = {
		["talents-background-hunter-survival"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },
	},
	["interface/talentframe/talentsclassbackgroundmage1"] = {
		["talents-background-mage-arcane"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-mage-fire"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgroundmage2"] = {
		["talents-background-mage-frost"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },
	},
	["interface/talentframe/talentsclassbackgroundmonk1"] = {
		["talents-background-monk-brewmaster"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-monk-mistweaver"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgroundmonk2"] = {
		["talents-background-monk-windwalker"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },
	},
	["interface/talentframe/talentsclassbackgroundpaladin1"] = {
		["talents-background-paladin-holy"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-paladin-protection"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgroundpaladin2"] = {
		["talents-background-paladin-retribution"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },
	},
	["interface/talentframe/talentsclassbackgroundpriest1"] = {
		["talents-background-priest-discipline"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-priest-holy"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgroundpriest2"] = {
		["talents-background-priest-shadow"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },
	},
	["interface/talentframe/talentsclassbackgroundrogue1"] = {
		["talents-background-rogue-assassination"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-rogue-outlaw"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgroundrogue2"] = {
		["talents-background-rogue-subtlety"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },
	},
	["interface/talentframe/talentsclassbackgroundshaman1"] = {
		["talents-background-shaman-elemental"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-shaman-enhancement"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgroundshaman2"] = {
		["talents-background-shaman-restoration"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },
	},
	["interface/talentframe/talentsclassbackgroundwarlock1"] = {
		["talents-background-warlock-affliction"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-warlock-demonology"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgroundwarlock2"] = {
		["talents-background-warlock-destruction"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },
	},
	["interface/talentframe/talentsclassbackgroundwarrior1"] = {
		["talents-background-warrior-arms"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875, false, false },
		["talents-background-warrior-fury"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875, false, false },
	},
	["interface/talentframe/talentsclassbackgroundwarrior2"] = {
		["talents-background-warrior-protection"] = { 1612, 774, 0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375, false, false },
	},
	["interface/talentframe/talentsmasknodechoice"] = {
		["talents-node-choice-mask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsmasknodechoiceflyout"] = {
		["talents-node-choiceflyout-mask"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsmasknodechoicehalf"] = {
		["talents-node-choice-mask-half"] = { 64, 64, 0, 1, 0, 1, false, false },
	},
	["interface/talentframe/talentsmasknodecircle"] = {
		["talents-node-circle-mask"] = { 64, 64, 0, 1, 0, 1, false, false },
	}
}

addon.rawPetTalentData = {
    {2106,2,0,0,410,0,0,0,0,0,0,0,61680,61681,52858,0,0,0,0,0,0,0,0,0,0,0,0},
    {2107,0,0,0,410,0,0,0,0,0,0,0,61682,61683,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2109,0,1,1,410,0,0,0,0,0,2055742496,209715200,61684,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2110,2,0,0,409,0,0,0,0,0,0,0,61680,61681,52858,0,0,0,0,0,0,0,0,0,0,0,0},
    {2111,2,1,3,410,0,0,0,0,0,713565216,243269632,61685,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2112,0,0,2,410,0,0,0,0,0,0,0,61686,61687,61688,0,0,0,0,0,0,0,0,0,0,0,0},
    {2113,0,0,3,410,0,0,0,0,0,0,0,61689,61690,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2114,0,0,0,409,0,0,0,0,0,0,0,61682,61683,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2116,0,0,2,409,0,0,0,0,0,0,0,61686,61687,61688,0,0,0,0,0,0,0,0,0,0,0,0},
    {2117,0,0,3,409,0,0,0,0,0,0,0,61689,61690,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2118,0,0,0,411,0,0,0,0,0,0,0,61682,61683,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2119,0,1,1,411,0,0,0,0,0,268648448,-2147483648,61684,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2120,0,0,2,411,0,0,0,0,0,0,0,61686,61687,61688,0,0,0,0,0,0,0,0,0,0,0,0},
    {2121,0,0,3,411,0,0,0,0,0,0,0,61689,61690,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2122,1,0,3,409,0,0,0,0,0,0,0,53175,53176,0,0,0,0,0,0,0,2117,0,0,1,0,0},
    {2123,2,0,1,409,0,0,0,0,0,0,0,53178,53179,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2124,1,0,0,410,0,0,0,0,0,0,0,53180,53181,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2125,1,0,2,410,0,0,0,0,0,0,0,53182,53183,53184,0,0,0,0,0,0,0,0,0,0,0,0},
    {2126,1,0,0,409,0,0,0,0,0,0,0,53182,53183,53184,0,0,0,0,0,0,0,0,0,0,0,0},
    {2127,1,0,3,411,0,0,0,0,0,0,0,53182,53183,53184,0,0,0,0,0,0,0,0,0,0,0,0},
    {2128,1,0,1,410,0,0,0,0,0,0,0,53186,53187,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2129,3,0,2,410,0,0,0,0,0,0,0,53203,53204,53205,0,0,0,0,0,0,0,0,0,0,0,0},
    {2151,1,0,3,410,0,0,0,0,0,0,0,19596,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2152,2,0,2,410,0,0,0,0,0,0,0,53409,53411,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2153,4,1,1,410,0,0,0,0,0,0,0,53426,0,0,0,0,0,0,0,0,2156,0,0,0,0,0},
    {2154,3,0,3,410,0,0,0,0,0,0,0,53427,53429,53430,0,0,0,0,0,0,0,0,0,0,0,0},
    {2155,4,1,0,410,0,0,0,0,0,0,0,53401,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2156,3,1,1,410,0,0,0,0,0,0,0,55709,0,0,0,0,0,0,0,0,2128,0,0,1,0,0},
    {2157,4,1,2,410,0,0,0,0,0,0,0,53434,0,0,0,0,0,0,0,0,2129,0,0,2,0,0},
    {2160,1,0,1,409,0,0,0,0,0,0,0,19596,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2161,3,0,3,409,0,0,0,0,0,0,0,53427,53429,53430,0,0,0,0,0,0,0,0,0,0,0,0},
    {2162,2,0,2,409,0,0,0,0,0,0,0,53409,53411,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2163,3,0,2,409,0,0,0,0,0,0,0,53450,53451,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2165,1,0,0,411,0,0,0,0,0,0,0,19596,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2166,2,0,0,411,0,0,0,0,0,0,0,61680,61681,52858,0,0,0,0,0,0,0,0,0,0,0,0},
    {2167,2,0,1,411,0,0,0,0,0,0,0,53409,53411,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2168,3,0,1,411,0,0,0,0,0,0,0,53427,53429,53430,0,0,0,0,0,0,0,0,0,0,0,0},
    {2169,4,1,3,409,0,0,0,0,0,0,0,53476,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2170,4,1,1,409,0,0,0,0,0,0,0,53477,0,0,0,0,0,0,0,0,2123,0,0,1,0,0},
    {2171,4,1,0,409,0,0,0,0,0,0,0,53478,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2172,4,1,2,409,0,0,0,0,0,0,0,53480,0,0,0,0,0,0,0,0,2163,0,0,1,0,0},
    {2173,1,0,2,409,0,0,0,0,0,0,0,53481,53482,0,0,0,0,0,0,0,2116,0,0,2,0,0},
    {2175,4,1,2,411,0,0,0,0,0,0,0,53490,0,0,0,0,0,0,0,0,2177,0,0,1,0,0},
    {2177,3,0,2,411,0,0,0,0,0,0,0,52234,53497,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2181,4,1,0,411,0,0,0,0,0,0,0,53508,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2182,1,0,2,411,0,0,0,0,0,0,0,53514,53516,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2183,3,0,3,411,0,0,0,0,0,0,0,53511,53512,0,0,0,0,0,0,0,2127,0,0,2,0,0},
    {2184,4,1,1,411,0,0,0,0,0,0,0,53517,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2201,0,1,1,411,0,0,0,0,0,21238021,0,23145,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2203,0,1,1,410,0,0,0,0,0,2064,268435456,23145,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2206,2,1,2,411,0,0,0,0,0,0,0,54044,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2207,1,0,1,411,0,0,0,0,0,268648448,-2147483648,53483,53485,0,0,0,0,0,0,0,2119,0,0,0,0,0},
    {2208,1,0,1,411,0,0,0,0,0,21238021,0,53554,53555,0,0,0,0,0,0,0,2201,0,0,0,0,0},
    {2219,2,1,3,410,0,0,0,0,0,2064,268435456,52825,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2237,0,1,1,409,0,0,0,0,0,0,0,61685,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2253,5,0,2,410,0,0,0,0,0,0,0,62758,62762,0,0,0,0,0,0,0,2157,0,0,0,0,0},
    {2254,5,0,0,410,0,0,0,0,0,0,0,62759,62760,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2255,5,0,2,409,0,0,0,0,0,0,0,62758,62762,0,0,0,0,0,0,0,2172,0,0,0,0,0},
    {2256,5,0,0,411,0,0,0,0,0,0,0,62758,62762,0,0,0,0,0,0,0,2181,0,0,0,0,0},
    {2257,4,0,3,411,0,0,0,0,0,0,0,53450,53451,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2258,5,0,1,409,0,0,0,0,0,0,0,62764,62765,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2277,2,1,3,409,0,0,0,0,0,0,0,63900,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {2278,5,1,3,411,0,0,0,0,0,0,0,53480,0,0,0,0,0,0,0,0,2257,0,0,1,0,0},    
}

addon.Constants.PetTalents = {
    [410] = {
        ["1"] = {
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 2,
                ["talentSpellIDs"] = {
                    61682, -- [1]
                    61683, -- [2]
                },
            },
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 6,
                ["talentSpellIDs"] = {
                    61689, -- [1]
                    61690, -- [2]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 5,
                ["talentSpellIDs"] = {
                    61686, -- [1]
                    61687, -- [2]
                    61688, -- [3]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 3,
                ["talentSpellIDs"] = {
                    61684, -- [1]
                },
            },
        },
        ["3"] = {
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 1,
                ["talentSpellIDs"] = {
                    61680, -- [1]
                    61681, -- [2]
                    52858, -- [3]
                },
            },
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 4,
                ["talentSpellIDs"] = {
                    61685, -- [1]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 12,
                ["talentSpellIDs"] = {
                    53409, -- [1]
                    53411, -- [2]
                },
            },
        },
        ["2"] = {
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 7,
                ["talentSpellIDs"] = {
                    53180, -- [1]
                    53181, -- [2]
                },
            },
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 11,
                ["talentSpellIDs"] = {
                    19596, -- [1]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 8,
                ["talentSpellIDs"] = {
                    53182, -- [1]
                    53183, -- [2]
                    53184, -- [3]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 9,
                ["talentSpellIDs"] = {
                    53186, -- [1]
                    53187, -- [2]
                },
            },
        },
        ["5"] = {
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 15,
                ["talentSpellIDs"] = {
                    53401, -- [1]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 17,
                ["talentSpellIDs"] = {
                    53434, -- [1]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 13,
                ["talentSpellIDs"] = {
                    53426, -- [1]
                },
            },
        },
        ["4"] = {
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 14,
                ["talentSpellIDs"] = {
                    53427, -- [1]
                    53429, -- [2]
                    53430, -- [3]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 10,
                ["talentSpellIDs"] = {
                    53203, -- [1]
                    53204, -- [2]
                    53205, -- [3]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 16,
                ["talentSpellIDs"] = {
                    55709, -- [1]
                },
            },
        },
        ["6"] = {
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 20,
                ["talentSpellIDs"] = {
                    62758, -- [1]
                    62762, -- [2]
                },
            },
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 21,
                ["talentSpellIDs"] = {
                    62759, -- [1]
                    62760, -- [2]
                },
            },
        },
    },
    [411] = {
        ["1"] = {
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 1,
                ["talentSpellIDs"] = {
                    61682, -- [1]
                    61683, -- [2]
                },
            },
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 4,
                ["talentSpellIDs"] = {
                    61689, -- [1]
                    61690, -- [2]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 3,
                ["talentSpellIDs"] = {
                    61686, -- [1]
                    61687, -- [2]
                    61688, -- [3]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 2,
                ["talentSpellIDs"] = {
                    61684, -- [1]
                },
            },
        },
        ["3"] = {
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 7,
                ["talentSpellIDs"] = {
                    61680, -- [1]
                    61681, -- [2]
                    52858, -- [3]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 17,
                ["talentSpellIDs"] = {
                    54044, -- [1]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 8,
                ["talentSpellIDs"] = {
                    53409, -- [1]
                    53411, -- [2]
                },
            },
        },
        ["2"] = {
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 6,
                ["talentSpellIDs"] = {
                    19596, -- [1]
                },
            },
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 5,
                ["talentSpellIDs"] = {
                    53182, -- [1]
                    53183, -- [2]
                    53184, -- [3]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 13,
                ["talentSpellIDs"] = {
                    53514, -- [1]
                    53516, -- [2]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 18,
                ["talentSpellIDs"] = {
                    53483, -- [1]
                    53485, -- [2]
                },
            },
        },
        ["5"] = {
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 12,
                ["talentSpellIDs"] = {
                    53508, -- [1]
                },
            },
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 21,
                ["talentSpellIDs"] = {
                    53450, -- [1]
                    53451, -- [2]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 10,
                ["talentSpellIDs"] = {
                    53490, -- [1]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 15,
                ["talentSpellIDs"] = {
                    53517, -- [1]
                },
            },
        },
        ["4"] = {
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 14,
                ["talentSpellIDs"] = {
                    53511, -- [1]
                    53512, -- [2]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 11,
                ["talentSpellIDs"] = {
                    52234, -- [1]
                    53497, -- [2]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 9,
                ["talentSpellIDs"] = {
                    53427, -- [1]
                    53429, -- [2]
                    53430, -- [3]
                },
            },
        },
        ["6"] = {
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 20,
                ["talentSpellIDs"] = {
                    62758, -- [1]
                    62762, -- [2]
                },
            },
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 22,
                ["talentSpellIDs"] = {
                    53480, -- [1]
                },
            },
        },
    },
    [409] = {
        ["1"] = {
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 2,
                ["talentSpellIDs"] = {
                    61682, -- [1]
                    61683, -- [2]
                },
            },
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 4,
                ["talentSpellIDs"] = {
                    61689, -- [1]
                    61690, -- [2]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 3,
                ["talentSpellIDs"] = {
                    61686, -- [1]
                    61687, -- [2]
                    61688, -- [3]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 17,
                ["talentSpellIDs"] = {
                    61685, -- [1]
                },
            },
        },
        ["3"] = {
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 1,
                ["talentSpellIDs"] = {
                    61680, -- [1]
                    61681, -- [2]
                    52858, -- [3]
                },
            },
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 20,
                ["talentSpellIDs"] = {
                    63900, -- [1]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 10,
                ["talentSpellIDs"] = {
                    53409, -- [1]
                    53411, -- [2]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 6,
                ["talentSpellIDs"] = {
                    53178, -- [1]
                    53179, -- [2]
                },
            },
        },
        ["2"] = {
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 7,
                ["talentSpellIDs"] = {
                    53182, -- [1]
                    53183, -- [2]
                    53184, -- [3]
                },
            },
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 5,
                ["talentSpellIDs"] = {
                    53175, -- [1]
                    53176, -- [2]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 16,
                ["talentSpellIDs"] = {
                    53481, -- [1]
                    53482, -- [2]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 8,
                ["talentSpellIDs"] = {
                    19596, -- [1]
                },
            },
        },
        ["5"] = {
            ["1"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 14,
                ["talentSpellIDs"] = {
                    53478, -- [1]
                },
            },
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 12,
                ["talentSpellIDs"] = {
                    53476, -- [1]
                },
            },
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 15,
                ["talentSpellIDs"] = {
                    53480, -- [1]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 13,
                ["talentSpellIDs"] = {
                    53477, -- [1]
                },
            },
        },
        ["4"] = {
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 11,
                ["talentSpellIDs"] = {
                    53450, -- [1]
                    53451, -- [2]
                },
            },
            ["4"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 9,
                ["talentSpellIDs"] = {
                    53427, -- [1]
                    53429, -- [2]
                    53430, -- [3]
                },
            },
        },
        ["6"] = {
            ["3"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 18,
                ["talentSpellIDs"] = {
                    62758, -- [1]
                    62762, -- [2]
                },
            },
            ["2"] = {
                ["tabIndex"] = 1,
                ["talentIndex"] = 19,
                ["talentSpellIDs"] = {
                    62764, -- [1]
                    62765, -- [2]
                },
            },
        },
    },
}

addon.Constants.TalentTrees = {
    [1] = {
        [815] = {
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        16487, -- [1]
                        16489, -- [2]
                        16492, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        12322, -- [1]
                        85741, -- [2]
                        85742, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        12320, -- [1]
                        12852, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        20502, -- [1]
                        20503, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        12321, -- [1]
                        12835, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 21,
                    ["talentSpellIDs"] = {
                        61216, -- [1]
                        61221, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        12323, -- [1]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        12319, -- [1]
                        12971, -- [2]
                        12972, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        12292, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        12317, -- [1]
                        13045, -- [2]
                        13046, -- [3]
                    },
                }, -- [3]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        81913, -- [1]
                        81914, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        85288, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        29801, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        60970, -- [1]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        46910, -- [1]
                    },
                }, -- [1]
                nil, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        12329, -- [1]
                        12950, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        46908, -- [1]
                        46909, -- [2]
                    },
                }, -- [4]
            }, -- [5]
            {
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        46913, -- [1]
                        46914, -- [2]
                        46915, -- [3]
                    },
                },
                [3] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        29888, -- [1]
                        29889, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        46917, -- [1]
                    },
                },
                [3] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        81099, -- [1]
                    },
                },
            }, -- [7]
        },
        [746] = {
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        84570, -- [1]
                        84571, -- [2]
                        84572, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        84579, -- [1]
                        84580, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        80976, -- [1]
                        80977, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        12295, -- [1]
                        12676, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        29834, -- [1]
                        29838, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        12834, -- [1]
                        12849, -- [2]
                        12867, -- [3]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        12290, -- [1]
                        12963, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        56636, -- [1]
                        56637, -- [2]
                        56638, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        12328, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        16493, -- [1]
                        16494, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        12289, -- [1]
                        12668, -- [2]
                    },
                }, -- [4]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        86655, -- [1]
                        12330, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        85730, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        29836, -- [1]
                        29859, -- [2]
                    },
                }, -- [3]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        84583, -- [1]
                        84587, -- [2]
                        84588, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        64976, -- [1]
                    },
                }, -- [2]
                nil, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        29723, -- [1]
                        29725, -- [2]
                    },
                }, -- [4]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        46867, -- [1]
                        56611, -- [2]
                    },
                }, -- [1]
                [3] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        85388, -- [1]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        46924, -- [1]
                    },
                },
            }, -- [7]
        },
        [845] = {
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        50685, -- [1]
                        50686, -- [2]
                        50687, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        12299, -- [1]
                        12761, -- [2]
                        12762, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        84614, -- [1]
                        84615, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        12298, -- [1]
                        12724, -- [2]
                        12725, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        29598, -- [1]
                        84607, -- [2]
                        84608, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        84604, -- [1]
                        84621, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        12311, -- [1]
                        12958, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        12975, -- [1]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        12809, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        29593, -- [1]
                        29594, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        57499, -- [1]
                    },
                }, -- [4]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        12797, -- [1]
                        12799, -- [2]
                    },
                }, -- [1]
                nil, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        20243, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        80128, -- [1]
                        80129, -- [2]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        80979, -- [1]
                        80980, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        50720, -- [1]
                    },
                }, -- [2]
                nil, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        86894, -- [1]
                        86896, -- [2]
                    },
                }, -- [4]
            }, -- [5]
            {
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        46945, -- [1]
                        46949, -- [2]
                    },
                },
                [3] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        46951, -- [1]
                        46952, -- [2]
                        46953, -- [3]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        46968, -- [1]
                    },
                },
            }, -- [7]
        },
    }, -- [1]
    [2] = {
        [839] = {
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        63646, -- [1]
                        63647, -- [2]
                        63648, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        20224, -- [1]
                        20225, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        87163, -- [1]
                        87164, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        53695, -- [1]
                        53696, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        20143, -- [1]
                        20144, -- [2]
                        20145, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        20487, -- [1]
                        20488, -- [2]
                    },
                }, -- [3]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        84631, -- [1]
                        84633, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        20911, -- [1]
                        84628, -- [2]
                        84629, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        53595, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        84635, -- [1]
                        84636, -- [2]
                    },
                }, -- [4]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        20177, -- [1]
                        20179, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        53600, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        75806, -- [1]
                        85043, -- [2]
                    },
                }, -- [3]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        26016, -- [1]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        20925, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        85639, -- [1]
                        85646, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        70940, -- [1]
                    },
                }, -- [4]
            }, -- [5]
            {
                [3] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        31848, -- [1]
                        31849, -- [2]
                        84854, -- [3]
                    },
                },
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        53709, -- [1]
                        53710, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        31850, -- [1]
                    },
                },
            }, -- [7]
        },
        [831] = {
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        20359, -- [1]
                        20360, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        20138, -- [1]
                        20139, -- [2]
                        20140, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        53671, -- [1]
                        53673, -- [2]
                        54151, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        85462, -- [1]
                        85463, -- [2]
                        85464, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        20234, -- [1]
                        20235, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        20237, -- [1]
                        20238, -- [2]
                    },
                }, -- [3]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        31825, -- [1]
                        85510, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        31842, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        53569, -- [1]
                        53576, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        88820, -- [1]
                        88821, -- [2]
                    },
                }, -- [4]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        53556, -- [1]
                        53557, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        53563, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        85495, -- [1]
                        85498, -- [2]
                        85499, -- [3]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        53551, -- [1]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        20049, -- [1]
                        20056, -- [2]
                        20057, -- [3]
                    },
                }, -- [1]
                nil, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        31821, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        93418, -- [1]
                        93417, -- [2]
                    },
                }, -- [4]
            }, -- [5]
            {
                [3] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        31828, -- [1]
                        31829, -- [2]
                    },
                },
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        84800, -- [1]
                        85511, -- [2]
                        85512, -- [3]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        85222, -- [1]
                    },
                },
            }, -- [7]
        },
        [855] = {
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        9799, -- [1]
                        25988, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        31866, -- [1]
                        31867, -- [2]
                        31868, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        87174, -- [1]
                        87175, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        20174, -- [1]
                        20175, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        85457, -- [1]
                        85458, -- [2]
                        87461, -- [3]
                    },
                }, -- [2]
                nil, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        26022, -- [1]
                        26023, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        31876, -- [1]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        53486, -- [1]
                        53488, -- [2]
                        87138, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        87168, -- [1]
                        87172, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        53385, -- [1]
                    },
                }, -- [4]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        85285, -- [1]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        25956, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        85126, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        53375, -- [1]
                        90286, -- [2]
                        53376, -- [3]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        85803, -- [1]
                        85804, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        20066, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        85117, -- [1]
                        86172, -- [2]
                    },
                }, -- [3]
            }, -- [5]
            {
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        53380, -- [1]
                        53381, -- [2]
                        53382, -- [3]
                    },
                },
                [3] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        85446, -- [1]
                        85795, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        85696, -- [1]
                    },
                },
            }, -- [7]
        },
    }, -- [2]
    [3] = {
        [809] = {
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        56339, -- [1]
                        56340, -- [2]
                        56341, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        52783, -- [1]
                        52785, -- [2]
                        52786, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        19464, -- [1]
                        82834, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        19286, -- [1]
                        19287, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        19376, -- [1]
                        63457, -- [2]
                        63458, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        19184, -- [1]
                        19387, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        53298, -- [1]
                        53299, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        34497, -- [1]
                        34498, -- [2]
                        34499, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        19306, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        56342, -- [1]
                        56343, -- [2]
                    },
                }, -- [3]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        34491, -- [1]
                        34492, -- [2]
                        34493, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        83494, -- [1]
                        83495, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        56333, -- [1]
                        56336, -- [2]
                    },
                }, -- [3]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        82832, -- [1]
                        82833, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        19386, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        53295, -- [1]
                        53296, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        53290, -- [1]
                    },
                }, -- [4]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        53302, -- [1]
                        53303, -- [2]
                        53304, -- [3]
                    },
                }, -- [1]
                [3] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        87934, -- [1]
                        87935, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        3674, -- [1]
                    },
                },
            }, -- [7]
        },
        [811] = {
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        35029, -- [1]
                        35030, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        82682, -- [1]
                        82683, -- [2]
                        82684, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        19590, -- [1]
                        19592, -- [2]
                        82687, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        19559, -- [1]
                        19560, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        19578, -- [1]
                        20895, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        19621, -- [1]
                        19622, -- [2]
                        19623, -- [3]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        19572, -- [1]
                        19573, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        53256, -- [1]
                        53259, -- [2]
                        53260, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        82726, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        82692, -- [1]
                    },
                }, -- [3]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        53262, -- [1]
                        53263, -- [2]
                        53264, -- [3]
                    },
                }, -- [1]
                [3] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        82748, -- [1]
                        82749, -- [2]
                    },
                },
            }, -- [4]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        82898, -- [1]
                        82899, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        19574, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        34460, -- [1]
                    },
                }, -- [3]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        56314, -- [1]
                        56315, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        34692, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        53252, -- [1]
                        53253, -- [2]
                    },
                }, -- [3]
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        53270, -- [1]
                    },
                },
            }, -- [7]
        },
        [807] = {
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        34950, -- [1]
                        34954, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        19416, -- [1]
                        19417, -- [2]
                        19418, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        34948, -- [1]
                        34949, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        83340, -- [1]
                        83356, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        53221, -- [1]
                        53222, -- [2]
                        53224, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        34482, -- [1]
                        34483, -- [2]
                    },
                }, -- [3]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        34490, -- [1]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        35100, -- [1]
                        35102, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        53234, -- [1]
                        53237, -- [2]
                        53238, -- [3]
                    },
                }, -- [3]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        35104, -- [1]
                        35110, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        19506, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        83489, -- [1]
                        83490, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        82893, -- [1]
                        82894, -- [2]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        53228, -- [1]
                        53232, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        34485, -- [1]
                        34486, -- [2]
                        34487, -- [3]
                    },
                }, -- [2]
                nil, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        23989, -- [1]
                    },
                }, -- [4]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        83558, -- [1]
                        83560, -- [2]
                    },
                }, -- [1]
                [3] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        53241, -- [1]
                        53243, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        53209, -- [1]
                    },
                },
            }, -- [7]
        },
    }, -- [3]
    [4] = {
        [183] = {
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        13975, -- [1]
                        14062, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        14079, -- [1]
                        14080, -- [2]
                        84661, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        14179, -- [1]
                        58422, -- [2]
                        58423, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        13981, -- [1]
                        14066, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        51692, -- [1]
                        51696, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        14057, -- [1]
                        14072, -- [2]
                        79141, -- [3]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        13976, -- [1]
                        13979, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        79150, -- [1]
                        79151, -- [2]
                        79152, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        51632, -- [1]
                        91023, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        16511, -- [1]
                    },
                }, -- [3]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        51698, -- [1]
                        51700, -- [2]
                        51701, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        14183, -- [1]
                    },
                }, -- [2]
                nil, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        31211, -- [1]
                        31212, -- [2]
                        31213, -- [3]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        31228, -- [1]
                        31229, -- [2]
                        31230, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        14185, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        79146, -- [1]
                        79147, -- [2]
                    },
                }, -- [3]
            }, -- [5]
            {
                [3] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        14171, -- [1]
                        14172, -- [2]
                    },
                },
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        51708, -- [1]
                        51709, -- [2]
                        51710, -- [3]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        51713, -- [1]
                    },
                },
            }, -- [7]
        },
        [182] = {
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        79121, -- [1]
                        79122, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        14162, -- [1]
                        14163, -- [2]
                        14164, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        14128, -- [1]
                        14132, -- [2]
                        14135, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        14156, -- [1]
                        14160, -- [2]
                        14161, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        31208, -- [1]
                        31209, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        13733, -- [1]
                        13865, -- [2]
                        13866, -- [3]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        79123, -- [1]
                        79125, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        51625, -- [1]
                        51626, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        14177, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        16513, -- [1]
                        16514, -- [2]
                        16515, -- [3]
                    },
                }, -- [3]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        31380, -- [1]
                        31382, -- [2]
                        31383, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        14186, -- [1]
                        14190, -- [2]
                    },
                }, -- [2]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        14158, -- [1]
                        14159, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        58426, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        58410, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        14168, -- [1]
                        14169, -- [2]
                    },
                }, -- [4]
            }, -- [5]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        51664, -- [1]
                        51665, -- [2]
                        51667, -- [3]
                    },
                },
                [3] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        79133, -- [1]
                        79134, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        79140, -- [1]
                    },
                },
            }, -- [7]
        },
        [181] = {
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        79007, -- [1]
                        79008, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        13732, -- [1]
                        13863, -- [2]
                        79004, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        13705, -- [1]
                        13832, -- [2]
                        13843, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        14165, -- [1]
                        14166, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        13743, -- [1]
                        13875, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        18427, -- [1]
                        18428, -- [2]
                        18429, -- [3]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        13754, -- [1]
                        13867, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        13712, -- [1]
                        13788, -- [2]
                        13789, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        84617, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        79077, -- [1]
                        79079, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        13741, -- [1]
                        13793, -- [2]
                    },
                }, -- [4]
            }, -- [3]
            {
                [3] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        31124, -- [1]
                        31126, -- [2]
                    },
                },
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        35541, -- [1]
                        35550, -- [2]
                        35551, -- [3]
                    },
                },
            }, -- [4]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        5952, -- [1]
                        51679, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        13750, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        51682, -- [1]
                        58413, -- [2]
                    },
                }, -- [3]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        84652, -- [1]
                        84653, -- [2]
                        84654, -- [3]
                    },
                }, -- [1]
                [3] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        79095, -- [1]
                        79096, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        51690, -- [1]
                    },
                },
            }, -- [7]
        },
    }, -- [4]
    [5] = {
        [760] = {
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        14748, -- [1]
                        14768, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        47586, -- [1]
                        47587, -- [2]
                        47588, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        14520, -- [1]
                        14780, -- [2]
                        14781, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        81659, -- [1]
                        81662, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        87151, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        14747, -- [1]
                        14770, -- [2]
                        14771, -- [3]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        63574, -- [1]
                        78500, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        57470, -- [1]
                        57472, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        10060, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        14523, -- [1]
                        81749, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        89485, -- [1]
                    },
                }, -- [4]
            }, -- [3]
            {
                nil, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        47535, -- [1]
                        47536, -- [2]
                        47537, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        52795, -- [1]
                        52797, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        33201, -- [1]
                        33202, -- [2]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        89488, -- [1]
                        89489, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        47509, -- [1]
                        47511, -- [2]
                        47515, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        33206, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 21,
                    ["talentSpellIDs"] = {
                        92295, -- [1]
                        92297, -- [2]
                    },
                }, -- [4]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        45234, -- [1]
                        45243, -- [2]
                    },
                }, -- [1]
                [3] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        47516, -- [1]
                        47517, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        62618, -- [1]
                    },
                },
            }, -- [7]
        },
        [813] = {
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        14908, -- [1]
                        15020, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        33158, -- [1]
                        33159, -- [2]
                        33160, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        18530, -- [1]
                        18531, -- [2]
                        18533, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                nil, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        19236, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        88687, -- [1]
                        88690, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        14892, -- [1]
                        15362, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        63534, -- [1]
                        63542, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        34753, -- [1]
                        34859, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        724, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        14898, -- [1]
                        81625, -- [2]
                    },
                }, -- [4]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 21,
                    ["talentSpellIDs"] = {
                        95649, -- [1]
                    },
                }, -- [1]
                nil, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        20711, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        63730, -- [1]
                        63733, -- [2]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        64127, -- [1]
                        64129, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        14751, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        88627, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        33142, -- [1]
                        33145, -- [2]
                    },
                }, -- [4]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        47558, -- [1]
                        47559, -- [2]
                        47560, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        87430, -- [1]
                        87431, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        34861, -- [1]
                    },
                }, -- [3]
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        47788, -- [1]
                    },
                },
            }, -- [7]
        },
        [795] = {
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        15259, -- [1]
                        15307, -- [2]
                        15308, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        15275, -- [1]
                        15317, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        15274, -- [1]
                        15311, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        15392, -- [1]
                        15448, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        15273, -- [1]
                        15312, -- [2]
                        15313, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        63625, -- [1]
                        63626, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        47573, -- [1]
                        47577, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                nil, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        15473, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        47569, -- [1]
                        47570, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        33191, -- [1]
                        78228, -- [2]
                    },
                }, -- [4]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        15487, -- [1]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        15286, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 21,
                    ["talentSpellIDs"] = {
                        88994, -- [1]
                        88995, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        14910, -- [1]
                        33371, -- [2]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        47580, -- [1]
                        47581, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        34914, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        87192, -- [1]
                        87195, -- [2]
                    },
                }, -- [3]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        64044, -- [1]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        87099, -- [1]
                        87100, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        78202, -- [1]
                        78203, -- [2]
                        78204, -- [3]
                    },
                }, -- [3]
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        47585, -- [1]
                    },
                },
            }, -- [7]
        },
    }, -- [5]
    [6] = {
        [398] = {
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        48979, -- [1]
                        49483, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        49182, -- [1]
                        49500, -- [2]
                        49501, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        48978, -- [1]
                        49390, -- [2]
                        49391, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        94553, -- [1]
                        94555, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        49004, -- [1]
                        49508, -- [2]
                        49509, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        81131, -- [1]
                        81132, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        85793, -- [1]
                        85794, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        49219, -- [1]
                        49627, -- [2]
                        49628, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        49222, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        49042, -- [1]
                        49786, -- [2]
                        49787, -- [3]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        53137, -- [1]
                        53138, -- [2]
                    },
                }, -- [4]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        81125, -- [1]
                        81127, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        49027, -- [1]
                        49542, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        50365, -- [1]
                        50371, -- [2]
                    },
                }, -- [3]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        52284, -- [1]
                        81163, -- [2]
                        81164, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        48982, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        55233, -- [1]
                    },
                }, -- [3]
            }, -- [5]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        62905, -- [1]
                        62908, -- [2]
                        81138, -- [3]
                    },
                },
                [3] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        81135, -- [1]
                        81136, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        49028, -- [1]
                    },
                },
            }, -- [7]
        },
        [399] = {
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        49455, -- [1]
                        50147, -- [2]
                        91145, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        55061, -- [1]
                        55062, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        49226, -- [1]
                        50137, -- [2]
                        50138, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        51468, -- [1]
                        51472, -- [2]
                        51473, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        49039, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        51983, -- [1]
                        51986, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        49137, -- [1]
                        49657, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        49024, -- [1]
                        49538, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        49149, -- [1]
                        50115, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        51123, -- [1]
                        51127, -- [2]
                        51128, -- [3]
                    },
                }, -- [3]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        49188, -- [1]
                        56822, -- [2]
                        59057, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        51271, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        55610, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        81327, -- [1]
                        81328, -- [2]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        50040, -- [1]
                        50041, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        49203, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        50384, -- [1]
                        50385, -- [2]
                    },
                }, -- [3]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        65661, -- [1]
                        66191, -- [2]
                        66192, -- [3]
                    },
                }, -- [1]
                [3] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        81330, -- [1]
                        81332, -- [2]
                        81333, -- [3]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        49184, -- [1]
                    },
                },
            }, -- [7]
        },
        [400] = {
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        49588, -- [1]
                        49589, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        48962, -- [1]
                        49567, -- [2]
                        49568, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        49036, -- [1]
                        49562, -- [2]
                        81334, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        55666, -- [1]
                        55667, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        81338, -- [1]
                        81339, -- [2]
                    },
                }, -- [2]
                nil, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        48963, -- [1]
                        49564, -- [2]
                        49565, -- [3]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        51459, -- [1]
                        51462, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        49016, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        91316, -- [1]
                        91319, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        48965, -- [1]
                        49571, -- [2]
                        49572, -- [3]
                    },
                }, -- [4]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        96269, -- [1]
                        96270, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        49224, -- [1]
                        49610, -- [2]
                        49611, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        51745, -- [1]
                        51746, -- [2]
                        91323, -- [3]
                    },
                }, -- [3]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        49194, -- [1]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        51052, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        50391, -- [1]
                        50392, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        63560, -- [1]
                    },
                }, -- [4]
            }, -- [5]
            {
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        51099, -- [1]
                        51160, -- [2]
                    },
                },
                [3] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        49018, -- [1]
                        49529, -- [2]
                        49530, -- [3]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        49206, -- [1]
                    },
                },
            }, -- [7]
        },
    }, -- [6]
    [7] = {
        [263] = {
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        16266, -- [1]
                        29079, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        77536, -- [1]
                        77537, -- [2]
                        77538, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        16261, -- [1]
                        16290, -- [2]
                        51881, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        30160, -- [1]
                        29179, -- [2]
                        29180, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        16256, -- [1]
                        16281, -- [2]
                        16282, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        16262, -- [1]
                        16287, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        86935, -- [1]
                        86936, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        16252, -- [1]
                        16306, -- [2]
                        16307, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        17364, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        51525, -- [1]
                        51526, -- [2]
                        51527, -- [3]
                    },
                }, -- [3]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        63373, -- [1]
                        63374, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        16086, -- [1]
                        16544, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        77655, -- [1]
                        77656, -- [2]
                        77657, -- [3]
                    },
                }, -- [3]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        51523, -- [1]
                        51524, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        30823, -- [1]
                    },
                }, -- [2]
                nil, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        30802, -- [1]
                        30808, -- [2]
                    },
                }, -- [4]
            }, -- [5]
            {
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        51528, -- [1]
                        51529, -- [2]
                        51530, -- [3]
                    },
                },
                [3] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        77700, -- [1]
                        77701, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        51533, -- [1]
                    },
                },
            }, -- [7]
        },
        [261] = {
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        17485, -- [1]
                        17486, -- [2]
                        17487, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        16039, -- [1]
                        16109, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        16035, -- [1]
                        16105, -- [2]
                        16106, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        16038, -- [1]
                        16160, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        28996, -- [1]
                        28997, -- [2]
                        28998, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        16040, -- [1]
                        16113, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        30672, -- [1]
                        30673, -- [2]
                        30674, -- [3]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        88756, -- [1]
                        88764, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        16164, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        28999, -- [1]
                        29000, -- [2]
                    },
                }, -- [3]
            }, -- [3]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        51466, -- [1]
                        51470, -- [2]
                    },
                },
                [3] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        51480, -- [1]
                        51481, -- [2]
                        51482, -- [3]
                    },
                },
            }, -- [4]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        88766, -- [1]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        16166, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        51483, -- [1]
                        51485, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        77746, -- [1]
                    },
                }, -- [4]
            }, -- [5]
            {
                [3] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        77755, -- [1]
                        77756, -- [2]
                    },
                },
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        86183, -- [1]
                        86184, -- [2]
                        86185, -- [3]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        61882, -- [1]
                    },
                },
            }, -- [7]
        },
        [262] = {
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        77829, -- [1]
                        77830, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        16179, -- [1]
                        16214, -- [2]
                        16215, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        84846, -- [1]
                        84847, -- [2]
                        84848, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        16180, -- [1]
                        16196, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        16173, -- [1]
                        16222, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        77794, -- [1]
                        77795, -- [2]
                        77796, -- [3]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        30881, -- [1]
                        30883, -- [2]
                        30884, -- [3]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        16176, -- [1]
                        16235, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        16188, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        30867, -- [1]
                        30868, -- [2]
                        30869, -- [3]
                    },
                }, -- [3]
            }, -- [3]
            {
                nil, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        16187, -- [1]
                        16205, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        77130, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        86959, -- [1]
                        86962, -- [2]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        51556, -- [1]
                        51557, -- [2]
                        51558, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        16190, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        82984, -- [1]
                        82988, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        98008, -- [1]
                    },
                }, -- [4]
            }, -- [5]
            {
                [3] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        51554, -- [1]
                        51555, -- [2]
                    },
                },
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        51562, -- [1]
                        51563, -- [2]
                        51564, -- [3]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        61295, -- [1]
                    },
                },
            }, -- [7]
        },
    }, -- [7]
    [8] = {
        [851] = {
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        29074, -- [1]
                        29075, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        11083, -- [1]
                        84253, -- [2]
                        84254, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        11078, -- [1]
                        11080, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        11119, -- [1]
                        11120, -- [2]
                        12846, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        18459, -- [1]
                        18460, -- [2]
                        54734, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        31641, -- [1]
                        31642, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        11103, -- [1]
                        12357, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        86948, -- [1]
                        86949, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        11113, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        44445, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        11115, -- [1]
                        11367, -- [2]
                    },
                }, -- [4]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        11094, -- [1]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        11129, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 21,
                    ["talentSpellIDs"] = {
                        44446, -- [1]
                        44448, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        86914, -- [1]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        84673, -- [1]
                        84674, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        31661, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        31679, -- [1]
                        31680, -- [2]
                        86880, -- [3]
                    },
                }, -- [3]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        34293, -- [1]
                        34295, -- [2]
                    },
                }, -- [1]
                [3] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        11095, -- [1]
                        12872, -- [2]
                        12873, -- [3]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        44457, -- [1]
                    },
                },
            }, -- [7]
        },
        [799] = {
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 21,
                    ["talentSpellIDs"] = {
                        11213, -- [1]
                        12574, -- [2]
                        12575, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        11255, -- [1]
                        12598, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        44400, -- [1]
                        44402, -- [2]
                        44403, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        29447, -- [1]
                        55339, -- [2]
                        55340, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        84722, -- [1]
                        84723, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        83513, -- [1]
                        83515, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        31569, -- [1]
                        31570, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        44378, -- [1]
                        44379, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        12043, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        44404, -- [1]
                        54486, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        31574, -- [1]
                        31575, -- [2]
                        54354, -- [3]
                    },
                }, -- [4]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        11210, -- [1]
                        12592, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        82930, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        44394, -- [1]
                        44395, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 22,
                    ["talentSpellIDs"] = {
                        90787, -- [1]
                        90788, -- [2]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        31571, -- [1]
                        31572, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        31589, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        86181, -- [1]
                        86209, -- [2]
                    },
                }, -- [3]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        54646, -- [1]
                    },
                }, -- [1]
                [3] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        31584, -- [1]
                        31585, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        12042, -- [1]
                    },
                },
            }, -- [7]
        },
        [823] = {
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        83049, -- [1]
                        83050, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        11151, -- [1]
                        12952, -- [2]
                        12953, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        11170, -- [1]
                        12982, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        31670, -- [1]
                        31672, -- [2]
                        55094, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        11190, -- [1]
                        12489, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        83156, -- [1]
                        83157, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        11175, -- [1]
                        12569, -- [2]
                        12571, -- [3]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        11185, -- [1]
                        12487, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        12472, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        44543, -- [1]
                        44545, -- [2]
                        83074, -- [3]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        86259, -- [1]
                        86260, -- [2]
                        86314, -- [3]
                    },
                }, -- [4]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        44561, -- [1]
                        86500, -- [2]
                        86508, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        11958, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        44546, -- [1]
                        44548, -- [2]
                        44549, -- [3]
                    },
                }, -- [3]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        44745, -- [1]
                        54787, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        11426, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        86303, -- [1]
                        86304, -- [2]
                    },
                }, -- [3]
            }, -- [5]
            {
                [3] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        84726, -- [1]
                        84727, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        44572, -- [1]
                    },
                },
            }, -- [7]
        },
    }, -- [8]
    [9] = {
        [871] = {
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        18827, -- [1]
                        18829, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        18182, -- [1]
                        18183, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        17810, -- [1]
                        17811, -- [2]
                        17812, -- [3]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        18179, -- [1]
                        85479, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        17804, -- [1]
                        17805, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        63108, -- [1]
                        86667, -- [2]
                    },
                }, -- [3]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        18223, -- [1]
                    },
                }, -- [1]
                nil, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        53754, -- [1]
                        53759, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        47195, -- [1]
                        47196, -- [2]
                        47197, -- [3]
                    },
                }, -- [4]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        30054, -- [1]
                        30057, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        86121, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        32385, -- [1]
                        32387, -- [2]
                        32392, -- [3]
                    },
                }, -- [3]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        47198, -- [1]
                        47199, -- [2]
                        47200, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        18094, -- [1]
                        18095, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        86664, -- [1]
                    },
                }, -- [3]
            }, -- [5]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        47201, -- [1]
                        47202, -- [2]
                        47203, -- [3]
                    },
                },
                [3] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        85099, -- [1]
                        85100, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        48181, -- [1]
                    },
                },
            }, -- [7]
        },
        [867] = {
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        18697, -- [1]
                        18698, -- [2]
                        18699, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        18694, -- [1]
                        85283, -- [2]
                        85284, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        47230, -- [1]
                        47231, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        88446, -- [1]
                        88447, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        30326, -- [1]
                        85175, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        30143, -- [1]
                        30144, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        18709, -- [1]
                        18710, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        85106, -- [1]
                        85107, -- [2]
                        85108, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        47193, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        18703, -- [1]
                        18704, -- [2]
                    },
                }, -- [3]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        47245, -- [1]
                        47246, -- [2]
                        47247, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        71521, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        89604, -- [1]
                        89605, -- [2]
                    },
                }, -- [3]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        85109, -- [1]
                        85110, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        85105, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        63156, -- [1]
                        63158, -- [2]
                    },
                }, -- [3]
            }, -- [5]
            {
                [3] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        47236, -- [1]
                    },
                },
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        85103, -- [1]
                        85104, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        59672, -- [1]
                    },
                },
            }, -- [7]
        },
        [865] = {
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        17788, -- [1]
                        17789, -- [2]
                        17790, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        17793, -- [1]
                        17796, -- [2]
                        17801, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        17815, -- [1]
                        17833, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        85113, -- [1]
                        85114, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        17954, -- [1]
                        17955, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        17927, -- [1]
                        17929, -- [2]
                    },
                }, -- [3]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        18119, -- [1]
                        18120, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        47258, -- [1]
                        47259, -- [2]
                        47260, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        17877, -- [1]
                    },
                }, -- [3]
            }, -- [3]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        91986, -- [1]
                        85112, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        30293, -- [1]
                        30295, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        34935, -- [1]
                        34938, -- [2]
                        34939, -- [3]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        91713, -- [1]
                    },
                }, -- [4]
            }, -- [4]
            {
                nil, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        47266, -- [1]
                        47267, -- [2]
                        47268, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        30283, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        30299, -- [1]
                        30301, -- [2]
                    },
                }, -- [4]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        47220, -- [1]
                        47221, -- [2]
                    },
                }, -- [1]
                [3] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        80240, -- [1]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        50796, -- [1]
                    },
                },
            }, -- [7]
        },
    }, -- [9]
    [11] = {
        [752] = {
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        16880, -- [1]
                        61345, -- [2]
                        61346, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        16814, -- [1]
                        16815, -- [2]
                        16816, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        35363, -- [1]
                        35364, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        57810, -- [1]
                        57811, -- [2]
                        57812, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        16845, -- [1]
                        16846, -- [2]
                        16847, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        33592, -- [1]
                        33596, -- [2]
                    },
                }, -- [3]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        81061, -- [1]
                        81062, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        24858, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        50516, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        93398, -- [1]
                        93399, -- [2]
                    },
                }, -- [4]
            }, -- [3]
            {
                nil, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        48389, -- [1]
                        48392, -- [2]
                        48393, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        48488, -- [1]
                        48514, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        78675, -- [1]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        33597, -- [1]
                        33599, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        33831, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        93401, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        48506, -- [1]
                    },
                }, -- [4]
            }, -- [5]
            {
                [3] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        33603, -- [1]
                        33604, -- [2]
                        33605, -- [3]
                    },
                },
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        78788, -- [1]
                        78789, -- [2]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 1,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        48505, -- [1]
                    },
                },
            }, -- [7]
        },
        [748] = {
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        78784, -- [1]
                        78785, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        16833, -- [1]
                        16834, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        17069, -- [1]
                        17070, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        17003, -- [1]
                        17004, -- [2]
                        17005, -- [3]
                    },
                }, -- [4]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        78734, -- [1]
                        78735, -- [2]
                        78736, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        48411, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        17111, -- [1]
                        17112, -- [2]
                        17113, -- [3]
                    },
                }, -- [3]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        48496, -- [1]
                        48499, -- [2]
                        48500, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        48539, -- [1]
                        48544, -- [2]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        17116, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        17104, -- [1]
                        24943, -- [2]
                    },
                }, -- [4]
            }, -- [3]
            {
                nil, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        17074, -- [1]
                        17075, -- [2]
                        17076, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        33879, -- [1]
                        33880, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 21,
                    ["talentSpellIDs"] = {
                        92363, -- [1]
                        92364, -- [2]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        34151, -- [1]
                        81274, -- [2]
                        81275, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        48438, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        88423, -- [1]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        33881, -- [1]
                        33882, -- [2]
                    },
                }, -- [4]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        51179, -- [1]
                        51180, -- [2]
                        51181, -- [3]
                    },
                }, -- [1]
                [3] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        33886, -- [1]
                    },
                },
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 3,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        33891, -- [1]
                    },
                },
            }, -- [7]
        },
        [750] = {
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 2,
                    ["talentSpellIDs"] = {
                        17002, -- [1]
                        24866, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 22,
                    ["talentSpellIDs"] = {
                        17056, -- [1]
                        17058, -- [2]
                        17059, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 20,
                    ["talentSpellIDs"] = {
                        16972, -- [1]
                        16974, -- [2]
                    },
                }, -- [3]
            }, -- [1]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 18,
                    ["talentSpellIDs"] = {
                        48483, -- [1]
                        48484, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 6,
                    ["talentSpellIDs"] = {
                        48532, -- [1]
                        80552, -- [2]
                        80553, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 19,
                    ["talentSpellIDs"] = {
                        37116, -- [1]
                        37117, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 21,
                    ["talentSpellIDs"] = {
                        16858, -- [1]
                        16859, -- [2]
                    },
                }, -- [4]
            }, -- [2]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 10,
                    ["talentSpellIDs"] = {
                        48492, -- [1]
                        48494, -- [2]
                        48495, -- [3]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 3,
                    ["talentSpellIDs"] = {
                        49377, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 4,
                    ["talentSpellIDs"] = {
                        78892, -- [1]
                        78893, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 1,
                    ["talentSpellIDs"] = {
                        16929, -- [1]
                        16930, -- [2]
                        16931, -- [3]
                    },
                }, -- [4]
            }, -- [3]
            {
                nil, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 11,
                    ["talentSpellIDs"] = {
                        17007, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 7,
                    ["talentSpellIDs"] = {
                        16940, -- [1]
                        16941, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 5,
                    ["talentSpellIDs"] = {
                        33872, -- [1]
                        33873, -- [2]
                    },
                }, -- [4]
            }, -- [4]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 12,
                    ["talentSpellIDs"] = {
                        80316, -- [1]
                        80317, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 8,
                    ["talentSpellIDs"] = {
                        61336, -- [1]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 17,
                    ["talentSpellIDs"] = {
                        80314, -- [1]
                        80315, -- [2]
                    },
                }, -- [3]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 16,
                    ["talentSpellIDs"] = {
                        57878, -- [1]
                        57880, -- [2]
                    },
                }, -- [4]
            }, -- [5]
            {
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 13,
                    ["talentSpellIDs"] = {
                        80318, -- [1]
                        80319, -- [2]
                    },
                }, -- [1]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 14,
                    ["talentSpellIDs"] = {
                        48432, -- [1]
                        48433, -- [2]
                        48434, -- [3]
                    },
                }, -- [2]
                {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 9,
                    ["talentSpellIDs"] = {
                        80313, -- [1]
                    },
                }, -- [3]
            }, -- [6]
            {
                [2] = {
                    ["tabIndex"] = 2,
                    ["talentIndex"] = 15,
                    ["talentSpellIDs"] = {
                        50334, -- [1]
                    },
                },
            }, -- [7]
        },
    },
}
