local modem = peripheral.find("modem") or error("No modem found", 0)
-- check for debug flag
local debug = false
if arg[1] == "debug" then
    debug = true
end

modem.open(1)

local hives = getHives()
local itemCount = 0
for _, hive in pairs(hives) do
    debugPrint(string.format("Hive: %s", hive))
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

print(string.format("Transferred %s items", itemCount))

local function debugPrint(message)
    if debug then
        print(message)
    end
end

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


