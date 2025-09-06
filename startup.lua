print("How far should I dig?")
local todig = tonumber(read())
print("How far should I space the tunnels?")
local spacing = tonumber(read())+1
print("How many tunnels should I make?")
local tunnels = tonumber(read())
print("What direction should I move towards?\n[Left / Right]")
local temp = string.lower(read())
local direct = string.find(temp, "l") and 1 or 0
print("Do I drop everything other than ores?")
local temp = string.lower(read())
local drop = string.find(temp, "y") and 1 or 0
--[[local listed = string.gsub(read(), "%s", "")
local leave = {}

for word in string.gmatch(listed, "[^,]+") do
    table.insert(leave, word)
end]]

turtle.refuel()

for tunnel=1,tunnels do
    for dug=1,todig do
        turtle.dig()
        turtle.digUp()
        turtle.digDown()
        turtle.forward()

        while turtle.getFuelLevel() <= 0 do
            term.clear()
            term.setCursorPos(0,0)
            term.write("Out of fuel!")
            for s=1,16 do
                if turtle.getFuelLevel() <= 0 then
                    turtle.select(s)
                    turtle.refuel()
                end
            end
            sleep(2)
            term.clear()
        end
    end
    if direct==1 then turtle.turnLeft() else turtle.turnRight() end
    for _=1,spacing do turtle.dig();turtle.forward();turtle.digDown() end
    if direct==1 then turtle.turnLeft() else turtle.turnRight() end

    direct = direct * -1
    if drop then
        term.clear()
        term.setCursorPos(0,0)
        term.write("Dumping bad items!")

        for s=1,16 do
            local item = turtle.getItemDetail(s)
            if item then
                if not string.find(item.name,"raw") and not string.find("Redstone Dust Lapis Lazuli Diamond",item.displayName) then
                    turtle.select(s)
                    turtle.dropDown()
                end
            end
        end
        term.clear()
    end
end
