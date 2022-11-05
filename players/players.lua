
-- When player join, root element is the server itself ...
addEventHandler('onPlayerJoin', root, function()


    -- spawn player , source is the player
    spawnPlayer(source, 0, 0, 5)
    -- fade camera in
    fadeCamera(source, true)
    -- set camera target to be the spawned plauer
    setCameraTarget(source, source)
end)