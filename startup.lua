print("How far should I dig?")
local todig = tonumber(read())
print("How far should I space the tunnels?")
local spacing = tonumber(read())+1
print("How many tunnels should I make?")
local tunnels = tonumber(read())
print("What direction should I move towards?\n[Left / Right]")
local temp = string.lower(read())
local direct = string.find(temp, "l") and 1 or -1
print("Do I drop everything other than ores?")
local temp = string.lower(read())
local drop = string.find(temp, "y") and 1 or 0
--[[local listed = string.gsub(read(), "%s", "")
local leave = {}

for word in string.gmatch(listed, "[^,]+") do
    table.insert(leave, word)
end]]
local directX = 1

local offsetX = 0
local offsetZ = 0

local waitingTime = 0

turtle.refuel()

--[[local function refuelByPeripherals()
    local periphs = peripheral.getNames()
    for _,periph in ipairs(periphs) do
        local periph = peripheral.wrap(periph)

        if periph.list then
            for slot,item in pairs(periph.list()) do
                
            end
        end
    end
end]]

local function refuelIfTooFar(x,z,wait)
    local refuelled = false
    while turtle.getFuelLevel() <= x+z and waitingTime < 5 do
        if not wait then waitingTime = 5 end

        term.clear()
        term.setCursorPos(0,0)
        term.write("Out of fuel!\n")

        for s=1,16 do
            if turtle.getFuelLevel() <= 0 then
                turtle.select(s)
                refuelled = turtle.refuel()
            end
        end

        if not refuelled and wait then
            sleep(2)
            waitingTime = waitingTime+1
            term.clear()

            if waitingTime >= 5 then
                -- Move back to origin
                shell.execute("shutdown")
            end
        end
    end
    waitingTime = 0
    return refuelled
end

for tunnel=1,tunnels do
    for dug=1,todig do
        turtle.dig()
        turtle.digUp()
        turtle.digDown()
        turtle.forward()
        offsetX = offsetX+directX
        
        -- Wait for fuel
        refuelIfTooFar(offsetX,offsetZ,true)
    end
    if direct==1 then turtle.turnLeft() else turtle.turnRight() end
    turtle.digDown()
    for _=1,spacing do
        turtle.dig()
        turtle.forward()
        turtle.digDown()
        offsetZ = offsetZ+1
    end
    if direct==1 then turtle.turnLeft() else turtle.turnRight() end

    direct = direct * -1
    directX = directX * -1
    local droppedOrAir = false
    if drop then
        term.clear()
        term.setCursorPos(0,0)
        term.write("Dumping bad items!")

        for s=1,16 do
            turtle.select(s)
            local item = turtle.getItemDetail()
            if textutils.serialise(item) ~= "nil" then
                if not string.find(item.name,"raw") and not string.find(item.name,"coal") and not string.find("minecraft:redstone minecraft:lapis_lazuli minecraft:diamond",item.name) then
                    turtle.dropDown()
                    droppedOrAir = true
                end
            else
                droppedOrAir = true
            end
        end
        term.clear()
    end

    if not droppedOrAir then
        term.write("No empty space!")
        shell.execute("shutdown")
    end
end
