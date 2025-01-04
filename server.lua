RegisterNetEvent("createBurger")
AddEventHandler("createBurger", function(firstname, lastname, dateofbirth, sex, height)
    local _source = source
    local identifier = GetPlayerIdentifier(_source)

    local fullname = firstname .. ' ' .. lastname

    -- Query om een nieuwe gebruiker toe te voegen
    exports.oxmysql:execute("INSERT INTO users (fullname, firstname, lastname, dateofbirth, sex, height) VALUES (?, ?, ?, ?, ?, ?)", {
        fullname,
        firstname,
        lastname,
        dateofbirth,
        sex,
        height
    })
end)

RegisterNetEvent('createVoertuig')
AddEventHandler('createVoertuig', function(owner, vehiclePlate, vehicleModel)
    exports.oxmysql:single('SELECT identifier FROM users WHERE fullname = @owner',
    { ['@owner'] = owner},
    function(result)
        if result then
            local identifier = result.identifier
            print(identifier)
            exports.oxmysql:execute("INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?)", {
                identifier,
                vehiclePlate,
                '{"model":' .. vehicleModel .. ',"plate":"' .. vehiclePlate .. '"}'
            })
        else
            print("Geen resultaten gevonden voor fullname: ".. fullname)
            callback(nil)
        end
    end)
end)