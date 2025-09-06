print("How far should I dig?")
local todig = tonumber(read())
print("How far should I space the tunnels?")
local spacing = tonumber(read())+1
print("How many tunnels should I make?")
local tunnels = tonumber(read())
print("What direction should I move towards?\n[Left / Right]")
local temp = string.lower(tostring(read()))
local direct = string.find(temp, "l") and 1 or 0
--[[print("What do I leave?\n Examples: stone,deepslate,andesite")
local listed = string.gsub(read(), "%s", "")
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
            term.write("Out of fuel!")
            for s=1,16 do
                if turtle.getFuelLevel() <= 0 then
                    turtle.select(s)
                    turtle.refuel()
                end
            end
            sleep(2)
        end
    end
    if direct then turtle.turnLeft() else turtle.turnRight() end
    for _=1,spacing do turtle.dig();turtle.forward();turtle.digDown() end
    if direct then turtle.turnLeft() else turtle.turnRight() end

    direct = direct * -1
    --[[term.clear()
    term.write("Dumping bad items!")

    for s=1,16 do
        local item = turtle.getItemDetail(s)
        if item then
            for _,l in ipairs(listed) do
                if string.find(item.name, l) then
                    turtle.select(s)
                    turtle.dropDown()
                end
            end
        end
    end]]
    
end
