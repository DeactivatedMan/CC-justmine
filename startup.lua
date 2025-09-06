print("How far should I dig?\n")
local todig = tonumber(read())

turtle.refuel()

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
