Config = {}

-- Inventory system
Config.PedModel = `a_m_m_business_01` -- Ped model, if your unsure leave it as it is. If you wanna change it head too https://docs.fivem.net/docs/game-references/ped-models/
Config.InventorySystem = 'ox'  -- Inventory system - pockets. Can choose 'qb' or 'ox'
Config.NotificationSystem = 'qb'  -- Notify system. Can choose 'qb' or 'ox'
Config.Target = 'ox' -- Target system - third eye. Can choose 'qb' or 'ox' 
Config.PedLocation = vec4(-538.21, 5288.21, 75.36, 249.72) -- Where the peds location is


Config.Requirements = {
    items = {
        {name = 'metalscrap', count = 250}, -- The items the player needs to be granted the reward
        {name = 'plastic', count = 150},
        {name = 'rubber', count = 200},
    },
    money = 100000,  -- Money needed
}

Config.Reward = { 
    items = {
        {name = 'tactical_table', count = 1}, -- The item the player is gonna get
    },
    money = 0, -- Money you are giving back ( if anyone ask say it is cash back - i cant make it so you dont have to have money sorry!)
}
