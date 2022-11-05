
-- outputChatBox('type')

function createVehicleForPlayer(player, command, model)
    local db = exports.db:getConnection()
    local x, y ,z = getElementPosition(player)
    y = y + 5

    dbExec(db, 'insert into vehicles(model, x, y, z) values(?,?,?,?)', model,x, y, z)

    local vehicleObject = createVehicle(model, x, y, z)

    dbQuery(function(queryHandle) 
        local res = dbPoll(queryHandle, 0)
        local vehicle = res[1]


        setElementData(vehicleObject, "id", vehicle.id)

    end, db, 'select id from vehicles order by id desc limit 1')

end

addCommandHandler('makeveh', createVehicleForPlayer, false, false)

function loadAllVehicles(queryHandle)

    local res = dbPoll(queryHandle, 0)

    for index, vehicle in pairs(res) do 
         local vehicleObject = createVehicle(vehicle.model, vehicle.x, vehicle.y, vehicle.z)
-- Set vehicleObject to  specific id
        setElementData(vehicleObject, "id", vehicle.id)
    end
end

addEventHandler('onResourceStart', resourceRoot, function()
    local db = exports.db:getConnection()
    -- loadAllVehicles callback run when response is received from the db

     dbQuery(loadAllVehicles, db, 'select * from vehicles')
end)

addEventHandler('onResourceStop', resourceRoot, function()
    local db = exports.db:getConnection()

    local vehicles = getElementsByType('vehicle')

    for index, vehicle in pairs(vehicles) do
    local id = getElementData(vehicle, 'id')
    local x,y,z = getElementPosition(vehicle)


    dbExec(db, 'update vehicles set x = ?, y = ?, z = ? where id = ?', x, y, z, id)
end

end)