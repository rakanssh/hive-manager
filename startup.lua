local config = require("config")
local debug = require("lib.debug")
if arg[1] == "debug" then
    debug.setEnabled(true)
end
local modem = peripheral.find("modem") or error("No modem found", 0)
-- TODO: Replace with dynamic scan for labelled output
local chest = peripheral.find("minecraft:chest") or error("No chest found", 0)
local function getHives()
    local remotePeripherals = modem.getNamesRemote()
    local hives = {}
    for _, remote in pairs(remotePeripherals) do
        if string.find(remote, "productivebees:advanced_hive") then
            table.insert(hives, remote)
        end
    end
    return hives
end


modem.open(config.modemChannel)

local hives = getHives()
local itemCount = 0
for _, hive in pairs(hives) do
    debug.print(string.format("Hive: %s", hive))
    local remoteHive = peripheral.wrap(hive)
    local items = remoteHive.list()
    local transferCount = 0
    
    for slot, item in pairs(items) do
        local moved = chest.pullItems(hive, slot)
        if moved > 0 then
            transferCount = transferCount + 1
        end
    end
    
    itemCount = itemCount + transferCount
end

debug.print(string.format("Transferred %s items", itemCount))




