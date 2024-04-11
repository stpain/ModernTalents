

local name, addon = ...;

local talentFilePath = "Interface/AddOns/ModernTalents/Media/Talents";
local talentFilePrefix = "TalentsClassBackground";


local specThumbnails = {
["deathknightblood"] = { 306, 186, 0.00048828125, 0.14990234375, 0.00048828125, 0.09130859375, false, false },
["deathknightfrost"] = { 306, 186, 0.15087890625, 0.30029296875, 0.00048828125, 0.09130859375, false, false },
["deathknightunholy"] = { 306, 186, 0.30126953125, 0.45068359375, 0.00048828125, 0.09130859375, false, false },
["druidbalance"] = { 306, 186, 0.75244140625, 0.90185546875, 0.00048828125, 0.09130859375, false, false },
["druidferalcombat"] = { 306, 186, 0.00048828125, 0.14990234375, 0.09228515625, 0.18310546875, false, false },
["druidguardian"] = { 306, 186, 0.15087890625, 0.30029296875, 0.09228515625, 0.18310546875, false, false },
["druidrestoration"] = { 306, 186, 0.30126953125, 0.45068359375, 0.09228515625, 0.18310546875, false, false },
["hunterbeastmastery"] = { 306, 186, 0.75244140625, 0.90185546875, 0.09228515625, 0.18310546875, false, false },
["huntermarksmanship"] = { 306, 186, 0.00048828125, 0.14990234375, 0.18408203125, 0.27490234375, false, false },
["huntersurvival"] = { 306, 186, 0.15087890625, 0.30029296875, 0.18408203125, 0.27490234375, false, false },
["magearcane"] = { 306, 186, 0.30126953125, 0.45068359375, 0.18408203125, 0.27490234375, false, false },
["magefire"] = { 306, 186, 0.45166015625, 0.60107421875, 0.18408203125, 0.27490234375, false, false },
["magefrost"] = { 306, 186, 0.60205078125, 0.75146484375, 0.18408203125, 0.27490234375, false, false },
["monkbrewmaster"] = { 306, 186, 0.75244140625, 0.90185546875, 0.18408203125, 0.27490234375, false, false },
["monkmistweaver"] = { 306, 186, 0.00048828125, 0.14990234375, 0.27587890625, 0.36669921875, false, false },
["monkwindwalker"] = { 306, 186, 0.15087890625, 0.30029296875, 0.27587890625, 0.36669921875, false, false },
["paladinholy"] = { 306, 186, 0.30126953125, 0.45068359375, 0.27587890625, 0.36669921875, false, false },
["paladinprotection"] = { 306, 186, 0.45166015625, 0.60107421875, 0.27587890625, 0.36669921875, false, false },
["paladincombat"] = { 306, 186, 0.60205078125, 0.75146484375, 0.27587890625, 0.36669921875, false, false },
["priestdiscipline"] = { 306, 186, 0.75244140625, 0.90185546875, 0.27587890625, 0.36669921875, false, false },
["priestholy"] = { 306, 186, 0.00048828125, 0.14990234375, 0.36767578125, 0.45849609375, false, false },
["priestshadow"] = { 306, 186, 0.15087890625, 0.30029296875, 0.36767578125, 0.45849609375, false, false },
["rogueassassination"] = { 306, 186, 0.30126953125, 0.45068359375, 0.36767578125, 0.45849609375, false, false },
["roguecombat"] = { 306, 186, 0.45166015625, 0.60107421875, 0.36767578125, 0.45849609375, false, false },
["roguesubtlety"] = { 306, 186, 0.60205078125, 0.75146484375, 0.36767578125, 0.45849609375, false, false },
["shamanelementalcombat"] = { 306, 186, 0.75244140625, 0.90185546875, 0.36767578125, 0.45849609375, false, false },
["shamanenhancement"] = { 306, 186, 0.00048828125, 0.14990234375, 0.45947265625, 0.55029296875, false, false },
["shamanrestoration"] = { 306, 186, 0.00048828125, 0.14990234375, 0.55126953125, 0.64208984375, false, false },
["warlockcurses"] = { 306, 186, 0.00048828125, 0.14990234375, 0.64306640625, 0.73388671875, false, false },
["warlocksummoning"] = { 306, 186, 0.00048828125, 0.14990234375, 0.73486328125, 0.82568359375, false, false },
["warlockdestruction"] = { 306, 186, 0.00048828125, 0.14990234375, 0.82666015625, 0.91748046875, false, false },
["warriorarms"] = { 306, 186, 0.15087890625, 0.30029296875, 0.45947265625, 0.55029296875, false, false },
["warriorfury"] = { 306, 186, 0.30126953125, 0.45068359375, 0.45947265625, 0.55029296875, false, false },
["warriorprotection"] = { 306, 186, 0.45166015625, 0.60107421875, 0.45947265625, 0.55029296875, false, false },
}

local Util = {}

function Util.GetAvailableTalentPointsForLevel(level)
    return ((level -10) / 2) +1;
end

function Util.GetClassData(classID)

    local class;
    if classID == 6 then
        class = "DeathKnight";
    else
        class = select(2, GetClassInfo(classID))
        class = class:lower():gsub("^%l", string.upper)
    end

    local bg1 = tostring(talentFilePath.."/"..talentFilePrefix..class.."1.png");
    local bg2 = tostring(talentFilePath.."/"..talentFilePrefix..class.."2.png");

    local specs = {}

    if classID == 11 then

        specs = {
            {
                backgroundFilePath = bg1,
                backgroundAtlas = {0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875},
            },
            {
                backgroundFilePath = bg1,
                backgroundAtlas = {0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875},
            },
            -- {
            --     backgroundFilePath = bg2,
            --     backgroundAtlas = {0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875},
            -- },
            {
                backgroundFilePath = bg2,
                backgroundAtlas = {0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875},
            },
        }

        for i = 1, 3 do
            local id, name, desc, fileID, x, classSpec, y = GetTalentTabInfo(i)
            local atlas = specThumbnails[classSpec:lower()]

            specs[i].tabID = i;
            specs[i].specID = id;

            specs[i].thumbnailAtlas = {atlas[3], atlas[4], atlas[5], atlas[6],}
            specs[i].description = desc;
            specs[i].name = name;

            specs[i].majorBonuses = {GetMajorTalentTreeBonuses(i)}
            specs[i].minorBonuses = {GetMinorTalentTreeBonuses(i)}
            for k, v in ipairs({GetTalentTreeMasterySpells(i)}) do
                table.insert(specs[i].minorBonuses, v)
            end
            --DevTools_Dump({GetTalentTreeEarlySpells(i)})

        end

    else

        specs = {
            {
                backgroundFilePath = bg1,
                backgroundAtlas = {0.00048828125, 0.78759765625, 0.00048828125, 0.37841796875},
            },
            {
                backgroundFilePath = bg1,
                backgroundAtlas = {0.00048828125, 0.78759765625, 0.37939453125, 0.75732421875},
            },
            {
                backgroundFilePath = bg2,
                backgroundAtlas = {0.00048828125, 0.78759765625, 0.0009765625, 0.7568359375},
            },
        }

        for i = 1, 3 do
            local id, name, desc, fileID, x, classSpec, y = GetTalentTabInfo(i)
            local atlas = specThumbnails[classSpec:lower()]

            specs[i].tabID = i;
            specs[i].specID = id;

            specs[i].thumbnailAtlas = {atlas[3], atlas[4], atlas[5], atlas[6],}
            specs[i].description = desc;
            specs[i].name = name;

            specs[i].majorBonuses = {GetMajorTalentTreeBonuses(i)}
            specs[i].minorBonuses = {GetMinorTalentTreeBonuses(i)}
            for k, v in ipairs({GetTalentTreeMasterySpells(i)}) do
                table.insert(specs[i].minorBonuses, v)
            end

        end

    end

    return specs;
end



addon.Util = Util;