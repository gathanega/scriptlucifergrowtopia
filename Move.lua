---===== INFO BUYER =====--- 
ItemsMove = 4585
worldtake =  "" 
iddoortake = "" 
worlddrop = ""
iddoordrop = ""
---===== Others =====---
delayjoin = 4500
posdrop = 20
rangeautocollect = 3 

----===== AREA DIBAWAH SANGAT SENSITIF OEMJI =====----

function flut(objID)
    count = 0
    for _, object in pairs(getObjects()) do
        if object.id == objID then
            count = count + object.count
        end
    end
    return count
end

function back()
for _, tile in pairs(getTiles()) do
  if tile.bg == posdrop or tile.fg == posdrop then
    findPath(tile.x-1,tile.y) 
sleep(1050)
drop(ItemsMove)
sleep(1000)
    if findItem(ItemsMove) == 0 then
   break
   
   end
   end
   end
end
   
function back1()
collectSet(true, rangeautocollect)
 collect(rangeautocollect) 
 for _, object in pairs(getObjects()) do
if object.id == ItemsMove  then
sleep(1000)
findPath(math.floor(object.x/32), math.floor(object.y/32))
sleep(300)
if findItem(ItemsMove) > 1 then
break
end
end
end
end 
   

function reconnect()
    while getBot().status ~= "online" do
        connect()
        sleep(3000)
        if getBot().status == "online" then
            return
        end
    end
end


function main()
reconnect()
if findItem(ItemsMove) == 0 and getBot().world == worldtake:upper() then
sendPacket("action|join_request\nname|"..worldtake.. "|".. iddoortake.."\ninvitedWorld|0",3)
sleep(delayjoin)
    back1()
        sleep(1000)

elseif findItem(ItemsMove) == 0 and getBot().world ~= worldtake:upper() then
sendPacket("action|join_request\nname|"..worldtake.. "|".. iddoortake.."\ninvitedWorld|0",3)
sleep(delayjoin)

 elseif findItem(ItemsMove) > 0 and getBot().world ~= worlddrop:upper() then
    sleep(1000)
    collectSet(false, rangeautocollect)
sendPacket("action|join_request\nname|"..worlddrop.. "|".. iddoordrop.."\ninvitedWorld|0",3)
sleep(delayjoin)

    
    elseif findItem(ItemsMove) > 0 and getBot().world == worlddrop:upper() then
    sleep(1000)
    collectSet(false, rangeautocollect)
sendPacket("action|join_request\nname|"..worlddrop.. "|".. iddoordrop.."\ninvitedWorld|0",3)
sleep(delayjoin)
back()
end
end



while true do
main()
end

