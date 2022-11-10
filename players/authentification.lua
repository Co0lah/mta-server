local MINIMUM_PASSWORD_LENGTH = 6

local function isPasswordValid(password)
    return string.len(password) >= MINIMUM_PASSWORD_LENGTH
end


addCommandHandler('register', function(player, command, username, password)

    if not username or not password then 
        return outputChatBox('INFOS: Type /' .. command ..' [username] [password]', player,  255, 255, 255)
    end
    if getAccount(username) then
        return outputChatBox("An account already exists with that name.", player, 255, 100, 100)
    end

    if not isPasswordValid(password) then
        return outputChatBox("Password is not valid, must be at least 6 characters", player, 255, 85, 85)
    end

    passwordHash(password, 'bcrypt', {}, function(hashedPassword)
    
        local account = addAccount(username, hashedPassword)
        setAccountData(account, 'hashed_password', hashedPassword)



        outputChatBox('Successfully Registered with username : '.. username ..' ! You may now /accountLogin', player, 100, 255, 100)
    end)
end)

addCommandHandler('accountLogin', function(player, command, username, password)
    if not username or not password then 
        return outputChatBox('INFOS: Type /' .. command ..' [username] [password]', player,  255, 255, 255)
    end

    local account = getAccount(username)
    if not account then
        return outputChatBox('No such account found in db', player, 255, 100, 100)
    end

    local hashedPassword = getAccountData(account, 'hashed_password')
    passwordVerify(password, hashedPassword, function(isValid)
        if not isValid then
            return outputChatBox('No such account found in db', player, 255, 100, 100)
        end
    
    if logIn(player, account, hashedPassword) then
        -- return outputChatBox('Successfully logged in!', player, 100, 255, 100)
    end

    -- return outputChatBox('An unknown error has occured', player, 255, 100, 100)
end)

end, false, false)

addCommandHandler('accountLogout', function(player, command)
    logOut(player)
    -- return outputChatBox('Successfully logged out!', player, 100, 255, 100)

end)