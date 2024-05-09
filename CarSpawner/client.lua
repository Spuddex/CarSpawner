local cars = {
    {model = "sultan", location = vector4(573.75, -405.99, -70.07, 139.71), entity = nil},
    {model = "sultanrs", location = vector4(567.78, -405.93, -69.97, 226.64), entity = nil},
}

Citizen.CreateThread(function()
    while true do
        for i, car in ipairs(cars) do
            if not car.entity or not DoesEntityExist(car.entity) then
                if not IsAnyVehicleNearPoint(car.location.x, car.location.y, car.location.z, 0.1) then
                    local modelHash = GetHashKey(car.model)

                    RequestModel(modelHash)
                    while not HasModelLoaded(modelHash) do
                        Wait(1)
                    end

                    car.entity = CreateVehicle(modelHash, car.location.x, car.location.y, car.location.z, car.location.w, true, false)

                    SetEntityAsMissionEntity(car.entity, true, true)
                end
            end
        end

        Wait(10000)
    end
end)