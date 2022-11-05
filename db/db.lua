-- DB connection
local db 

addEventHandler('onResourceStart', resourceRoot, function()

    db = dbConnect("mysql", "dbname=mtaserver; host=localhost;", "root","")

end)

function getConnection()
    return db
end