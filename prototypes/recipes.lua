
local lightning_ammo = {
    type = "recipe",
    name = "zeus-wrath-lightning-ammo",
    icon = "__zeus-wrath__/graphics/lightning-bottle.png",
    enabled = false,
    category = "electromagnetics",
    subgroup = "ammo",
    order = "e[railgun-ammo]-a[basic]-a[zeus]",
    energy_required = 180,
    ingredients = {
        {type = "fluid", name = "electrolyte", amount = 50},
        {type = "item", name = "supercapacitor", amount = 5},
        {type = "item", name = "accumulator", amount = 1},
        {type = "item", name = "lightning-rod", amount = 1}
    },
    results = {{type = "item", name = "zeus-wrath-lightning-ammo", amount = 1}}
}

local zeus_gun = {
    type = "recipe",
    name = "zeus-wrath-zeus-gun",
    icon = "__zeus-wrath__/graphics/zeus-gun.png",
    enabled = false,
    category = "electromagnetics",
    subgroup = "gun",
    order = "a[basic-clips]-h[zeus-gun]",
    energy_required = 120,
    ingredients = {
        {type = "fluid", name = "electrolyte", amount = 1000},
        {type = "item", name = "supercapacitor", amount = 20},
        {type = "item", name = "superconductor", amount = 50},
        {type = "item", name = "holmium-plate", amount = 50},
        {type = "item", name = "processing-unit", amount = 50},
        {type = "item", name = "lightning-collector", amount = 1},
        {type = "item", name = "teslagun", amount = 1},
    },
    results = {{type = "item", name = "zeus-wrath-zeus-gun", amount = 1}}
}


local zeus_turret = {
    type = "recipe",
    name = "zeus-wrath-zeus-turret",
    icon = "__zeus-wrath__/graphics/zeus-turret.png",
    enabled = false,
    category = "electromagnetics",
    order = "b[turret]-f[tesla-turret]-a[zeus-turret]",
    energy_required = 120,
    ingredients = {
        {type = "fluid", name = "electrolyte", amount = 2000},
        {type = "item", name = "supercapacitor", amount = 100},
        {type = "item", name = "superconductor", amount = 200},
        {type = "item", name = "holmium-plate", amount = 200},
        {type = "item", name = "accumulator", amount = 100},
        {type = "item", name = "processing-unit", amount = 200},
        {type = "item", name = "electric-engine-unit", amount = 200},
        {type = "item", name = "lightning-collector", amount = 1},
        {type = "item", name = "beacon", amount = 10},
        {type = "item", name = "zeus-wrath-zeus-gun", amount = 1},
    },
    results = {{type = "item", name = "zeus-wrath-zeus-turret", amount = 1}}
}


data:extend({lightning_ammo, zeus_gun, zeus_turret})
