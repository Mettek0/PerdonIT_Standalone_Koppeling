RegisterCommand("maakburger", function()
    -- Vraag de speler om gegevens in te vullen via ox_lib input
    local input = lib.inputDialog('Gegevens Invoeren', {
        {type = 'input', label = 'Voornaam', description = 'Geef je voornaam in', required = true, min = 2, max = 30},
        {type = 'input', label = 'Achternaam', description = 'Geef je achternaam in', required = true, min = 2, max = 30},
        {type = 'input', label = 'Geboortedatum', description = 'Geef je geboortedatum in (YYYY-MM-DD)', required = true},
        {type = 'select', label = 'Geslacht', options = {
            { value = 'm', label = 'Man' },
            { value = 'f', label = 'Vrouw' },
        }, description = 'Geef je geslacht in (M/V)', required = true},
        {type = 'number', label = 'Lengte', description = 'Geef je lengte in (bijv. 180)', required = true},
        {type = 'checkbox', label = 'Voertuig', description = 'Wil je een voertuig toevoegen?', checked = false}
    })
    Citizen.Wait(50)
    -- Controleer of alle gegevens ingevuld zijn
    if input then
        local firstname = input[1]  -- Voornaam
        local lastname = input[2]   -- Achternaam
        local dateofbirth = input[3] -- Geboortedatum
        local sex = input[4]        -- Geslacht
        local height = input[5]     -- Lengte
        local auto = input[6]       -- Auto

        TriggerServerEvent("createBurger", firstname, lastname, dateofbirth, sex, height)

        if auto then
            MaakVoertuig()
        end
    end
end, false)

RegisterCommand('maakvoertuig', function()
    MaakVoertuig()
end)


function MaakVoertuig()
    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
        lib.notify({
            id = 'nworking',
            title = 'Error',
            description = 'Je moet in een voertuig zitten hiervoor!',
            showduration = true,
            position = top,
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'ban',
            iconColor = '#C53030'
        })
    else
        print('hallo')
        Citizen.Wait(50)

        local input2 = lib.inputDialog('Voertuig Gegevens Invoeren', {
            {type = 'input', label = 'Eigenaar', description = 'Volledige naam van de eigenaar.', required = true},
        })

        Citizen.Wait(50)

        local owner = input2[1]
        local vehicleModel = GetVehiclePedIsIn(PlayerPedId(), false)
        local vehiclePlate = GetVehicleNumberPlateText(vehicleModel)
        print(vehiclePlate)

        TriggerServerEvent('createVoertuig', owner, vehiclePlate, vehicleModel)
    end
end