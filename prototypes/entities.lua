----
--- Lightning

-- Lightning for all planets, replaces the fulgora particles with generic stone ones
local global_lightning = table.deepcopy(data.raw["lightning"]["lightning"])
global_lightning.name = "zeus-wrath-lightning"
global_lightning.damage = 0 -- The lightning itself does not do any damage
global_lightning.hidden = true
global_lightning.hidden_in_factoriopedia = true
global_lightning.energy = "500MJ"
global_lightning.strike_effect.action_delivery.target_effects[1].particle_name = "stone-particle-big"
global_lightning.strike_effect.action_delivery.target_effects[2].particle_name = "stone-particle-medium"
global_lightning.strike_effect.action_delivery.target_effects[3].particle_name = "stone-particle-small"
global_lightning.strike_effect.action_delivery.target_effects[4].particle_name = "stone-particle-tiny"
-- Better audibility for better feel
global_lightning.sound.aggregation.max_count = 20

-- Eventually I want to figure out how to make this go backwards but for now it's just a non-damaging lightning strike.
-- Lighting also currently hits the base of the turret, unsure how to change that 
local reverse_lightning = table.deepcopy(data.raw["lightning"]["lightning"])
reverse_lightning.name = "zeus-wrath-reverse-lightning"
-- Disable collision
reverse_lightning.strike_effect.collision_mask = {
    layers = {}
}
reverse_lightning.damage = 0
reverse_lightning.hidden = true
reverse_lightning.hidden_in_factoriopedia = true
reverse_lightning.energy = "500MJ"

reverse_lightning.sound.aggregation.max_count = 20

-- Remove Fulgora rock explosions
reverse_lightning.strike_effect.action_delivery.target_effects = {reverse_lightning.strike_effect.action_delivery.target_effects[5]}

-- Move strike point up by 5 to hit the point of the turret
reverse_lightning.graphics_set.attractor_hit_animation.shift = {
    0.015625,
    -5.109375
}
reverse_lightning.graphics_set.explosion[1].shift = {
    0.015625,
    -5.25
}
reverse_lightning.graphics_set.explosion[2].shift = {
    0.015625,
    -5.25
}
reverse_lightning.graphics_set.explosion[1].shift = {
    0.015625,
    -5.25
}
reverse_lightning.graphics_set.explosion[2].shift = {
    0.015625,
    -5.53125
}

---- 
--- Corpse

local turret_corpse = table.deepcopy(data.raw["corpse"]["beacon-remnants"])
turret_corpse.name = "zeus-wrath-zeus-turret-remnants"
turret_corpse.collision_box = {{-2.4, -2.4}, {2.4, 2.4}}
turret_corpse.selection_box = {{-1, -2}, {1, -2}}
turret_corpse.animation[1].scale = 1
turret_corpse.animation[2].scale = 1

----
--- Turret

local zeus_turret = table.deepcopy(data.raw["electric-turret"]["tesla-turret"])
zeus_turret.name = "zeus-wrath-zeus-turret"
zeus_turret.order = "z-b[turret]-f[tesla-turret]-a[zeus-turret]"
zeus_turret.surface_conditions = {
    {property = "gravity", min = 0.01}
}
zeus_turret.prepare_range = 60
zeus_turret.rotation_speed = 0.02
zeus_turret.attack_parameters.cooldown = 30
zeus_turret.attack_parameters.range = 45
zeus_turret.attack_parameters.min_range = 8.75
zeus_turret.attack_parameters.ammo_type = table.deepcopy(data.raw["ammo"]["zeus-wrath-lightning-ammo"].ammo_type)

-- Add self strike effect
zeus_turret.attack_parameters.ammo_type.action.action_delivery[3] = {
    type = "instant",
    source_effects = {
        {
            type = "create-entity",
            entity_name = "zeus-wrath-reverse-lightning",
            offsets = { {0, -25} }
        }
    }
}

zeus_turret.attack_parameters.ammo_type.energy_consumption = "500MJ"

zeus_turret.energy_source = {
    type = "electric",
    buffer_capacity = "20GJ",
    input_flow_limit = "200MW",
    drain = "50kW",
    usage_priority = "primary-input"

}

-- Make it smaller and the size of a beacon
zeus_turret.icon = "__zeus-wrath__/graphics/zeus-turret.png"
zeus_turret.collision_box = {{-2.4, -2.4}, {2.4, 2.4}}
zeus_turret.selection_box = {{-2.5, -2.5}, {2.5, 2.5}}
zeus_turret.corpse = "zeus-wrath-zeus-turret-remnants"

-- Set graphics to match beacon ones
zeus_turret.graphics_set = {
    base_visualisation = {
        {
            render_layer = "lower-object",
            animation = {
                layers = {
                    -- Base of turret
                    {
                        layers = {
                            {
                                filename = "__base__/graphics/entity/beacon/beacon-bottom.png",
                                height = 192,
                                width = 212,
                                scale = 0.9,
                                shift = {
                                0.015625,
                                0.03125
                                }
                            },
                            {
                                draw_as_shadow = true,
                                filename = "__base__/graphics/entity/beacon/beacon-shadow.png",
                                height = 176,
                                width = 244,
                                scale = 0.9,
                                shift = {
                                    0.390625,
                                    0.015625
                                }
                            }
                        },
                        render_layer = "floor-mechanics"
                    },
                    -- Beacon top
                    {
                        animation_speed = 1,
                        layers = {
                            {
                                filename = "__space-age__/graphics/entity/lightning-collector/lightning-collector.png",
                                height = 434,
                                width = 180,
                                scale = 0.5,
                                shift = {
                                  0.0,
                                  -2.25
                                }
                            }
                        },
                        render_layer = "object"
                    }
                }
            }
        }
    }
}

-- zeus_turret.energy_glow_animation.north = {
--     layers = {
--         {
--             animation_speed = 0.5,
--             blend_mode = "additive",
--             filename = "__base__/graphics/entity/beacon/beacon-light.png",
--             frame_count = 45,
--             height = 186,
--             line_length = 9,
--             scale = 1,
--             shift = {
--                 0.015625,
--                 -0.5625
--             },
--             width = 110,
--             apply_tint = true,
--             render_layer = "object"
--         }
--     }
-- }

-- Remove unnecessary animations
zeus_turret.preparing_animation = nil
zeus_turret.prepared_animation = nil
zeus_turret.prepared_alternative_animation = nil
zeus_turret.starting_attack_animation = nil
zeus_turret.attacking_animation = nil
zeus_turret.energy_glow_animation = nil
zeus_turret.starting_attack_animation = nil
zeus_turret.resource_indicator_animation = nil
zeus_turret.ending_attack_animation = nil
zeus_turret.folding_animation = nil
-- Dirty hackjob
zeus_turret.folded_animation.layers[1].scale = 0
zeus_turret.folded_animation.layers[2].scale = 0
zeus_turret.folded_animation.layers[3].scale = 0
zeus_turret.folded_animation.layers[4].scale = 0




data:extend({reverse_lightning, global_lightning, zeus_turret, turret_corpse})