-- technology.lua

data:extend({
    {
        type = "technology",
        name = "zeus-wrath-zeus-wrath",
        prerequisites = { "tesla-weapons", "lightning-collector", "effect-transmission" },
        icons = {
            {
                icon = "__zeus-wrath__/graphics/technology.png",
                icon_size = 256
            }
        },
        unit = {
            count = 5000,
            ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"military-science-pack", 1}, {"chemical-science-pack", 1}, {"production-science-pack", 1}, {"utility-science-pack", 1}, {"space-science-pack", 1}, {"electromagnetic-science-pack", 1}},
            time = 60
        },
        effects = {
            {type = "unlock-recipe", recipe = "zeus-wrath-lightning-ammo"},
            {type = "unlock-recipe", recipe = "zeus-wrath-zeus-gun"},
            {type = "unlock-recipe", recipe = "zeus-wrath-zeus-turret"}
        }
    }
})

