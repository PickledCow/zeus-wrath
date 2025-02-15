-- items.lua

local player_excluded_layers = {
    is_lower_object = true,
    is_object = true,
    ground_tile = true,
    water_tile = true,
    resource = true,
    doodad = true,
    floor = true,
    rail = true,
    transport_belt = true,
    item = true,
    ghost = true,
    object = true,
    -- player = true,
    -- car = true,
    train = true,
    elevated_rail = true,
    elevated_train = true,
    empty_space = true,
    lava_tile = true,
    meltable = true,
    rail_support = true,
    trigger_target = true,
    cliff = true

}

local zeus_ammo = table.deepcopy(data.raw["ammo"]["rocket"])
zeus_ammo.order = "e[railgun-ammo]-a[basic]-a[zeus]"
zeus_ammo.name = "zeus-wrath-lightning-ammo"
zeus_ammo.icon = "__zeus-wrath__/graphics/lightning-bottle.png"
-- zeus_ammo.inventory_move_sound = data.raw["item"]["accumulator"].inventory_move_sound
-- zeus_ammo.drop_sound = data.raw["item"]["accumulator"].drop_sound
zeus_ammo.pick_sound = data.raw["tool"]["automation-science-pack"].pick_sound
zeus_ammo.drop_sound = data.raw["tool"]["automation-science-pack"].drop_sound
zeus_ammo.inventory_move_sound = data.raw["tool"]["automation-science-pack"].inventory_move_sound

zeus_ammo.ammo_category = "tesla"
zeus_ammo.ammo_type = {
    action = {
        type = "direct",
        action_delivery = {
            -- Flash effect
            data.raw["lightning"]["lightning"].created_effect.action_delivery,

            -- Lightning Strike and damage
            {
                type = "instant",
                target_effects = {
                    -- Lightning Strike
                    {
                        type = "create-entity",
                        entity_name = "zeus-wrath-lightning",
                        offsets = { {0, -25} }
                    },
                    -- Damage
                    {
                        type = "nested-result",
                        action = {
                            -- Inner radius
                            {
                                type = "area",
                                radius = 0.5,
                                action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                        {
                                            type = "damage",
                                            damage = {
                                                amount = 500,
                                                type = "electric"
                                            }
                                        }
                                    }
                                },
                                trigger_from_target = true, -- Arc from first target
                                collision_mask = {
                                    layers = player_excluded_layers
                                }
                            },
                            -- Outer radius
                            {
                                type = "area",
                                radius = 5,
                                action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                        {
                                            type = "damage",
                                            damage = {
                                                amount = 100,
                                                type = "electric"
                                            },
                                        },
                                        {
                                            type = "create-sticker",
                                            sticker = "tesla-turret-stun"
                                        }
                                    }
                                },
                                collision_mask = {
                                    layers = player_excluded_layers
                                }
                            },
                        }
                    }
                }
            
            }
            }
    },
    clamp_position = true,
    target_type = "position"
}


local zeus_gun = table.deepcopy(data.raw["gun"]["teslagun"])
zeus_gun.name = "zeus-wrath-zeus-gun"
zeus_gun.order = "a[basic-clips]-h[zeus-gun]"
zeus_gun.icon = "__zeus-wrath__/graphics/zeus-gun.png"
zeus_gun.attack_parameters.range = 36
zeus_gun.attack_parameters.cooldown = 24
zeus_gun.attack_parameters.movement_slow_down_factor = 0.1


local zeus_turret = table.deepcopy(data.raw["item"]["tesla-turret"])
zeus_turret.icon = "__zeus-wrath__/graphics/zeus-turret.png"
zeus_turret.name = "zeus-wrath-zeus-turret"
zeus_turret.place_result = "zeus-wrath-zeus-turret"
zeus_turret.order = "b[turret]-f[tesla-turret]-a[zeus-turret]"
zeus_turret.stack_size = 5
zeus_turret.weight = 200000 -- 1 rocket capacity

data:extend({zeus_ammo, zeus_gun, zeus_turret})
