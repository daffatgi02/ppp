local FF_Peds = {}

NPCS = {
    {
        coords = vec4(913.101, -287.04, 66.2781, 183.03),
        model = `s_m_y_ammucity_01`
    },
    {
        coords = vec4(908.390, -299.83, 66.2781, 318.61),
        model = `s_m_y_ammucity_01`
    },
	--Ballas
	{
        coords = vec4(103.664, -1948.7, 21.3596, 346.0),
        model = `s_m_y_ammucity_01`
    },
	{
        coords = vec4(112.814, -1938.2, 21.3596, 124.04),
        model = `s_m_y_ammucity_01`
    },
	--vp
	{
        coords = vec4(-826.86, -933.23, 17.1963, 345.63),
        model = `s_m_y_ammucity_01`
    },
	{
        coords = vec4(-818.50, -922.09, 17.1963, 133.62),
        model = `s_m_y_ammucity_01`
    },
	--dag
	{
        coords = vec4(2101.14, 2321.87, 94.9196, 20.07),
        model = `s_m_y_ammucity_01`
    },
	{
        coords = vec4(2101.23, 2335.84, 94.9195, 160.61),
        model = `s_m_y_ammucity_01`
    },
	--fadil
	{
        coords = vec4(1263.76, 1830.36, 82.9353, 104.0),
        model = `s_m_y_ammucity_01`
    },
	{
        coords = vec4(1252.85, 1821.32, 82.0788, 334.0),
        model = `s_m_y_ammucity_01`
    },
	--ortakasaba
	{
        coords = vec4(1978.42, 3706.29, 32.8476, 98.48),
        model = `s_m_y_ammucity_01`
    },
	{
        coords = vec4(1966.23, 3700.13, 33.0028, 313.84),
        model = `s_m_y_ammucity_01`
    },
	--ustkasaba
	{
        coords = vec4(-65.813, 6278.81, 31.9797, 292.01),
        model = `s_m_y_ammucity_01`
    },
	{
        coords = vec4(-52.170, 6278.60, 31.9797, 68.25),
        model = `s_m_y_ammucity_01`
    },
}

RegisterNetEvent("ta-base:farm_fight:npc", function(action)
    if action == "spawn" then
        for i = 1, #NPCS do
            local v = NPCS[i]
            CreateNPC(v)
        end
    elseif action == "delete" then
        for _, ped in pairs(FF_Peds) do
            DeletePed(ped)
        end
    end
end)

function CreateNPC(v)
    RequestModel(v.model)
    while not HasModelLoaded(v.model) do
        Citizen.Wait(1)
    end
    
    local ped = CreatePed(1, v.model, v.coords.x, v.coords.y, v.coords.z - 0.98, v.coords.w, false, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedDiesWhenInjured(ped, false)
    SetPedCanPlayAmbientAnims(ped, true) 
    SetPedCanRagdollFromPlayerImpact(ped, false) 
    SetEntityInvincible(ped, true)	
    FreezeEntityPosition(ped, true)
	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GUARD_STAND", 0, true);
    table.insert(FF_Peds, ped)
end