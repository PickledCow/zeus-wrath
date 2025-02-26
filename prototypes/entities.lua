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

-- Backwards lightning 
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

-- Remove Fulgora rock explosions, keeping non-particle effect
reverse_lightning.strike_effect.action_delivery.target_effects = {reverse_lightning.strike_effect.action_delivery.target_effects[5]}

-- Move the cloud to the sky up 20 tiles
reverse_lightning.graphics_set.cloud_background.shift[2] = reverse_lightning.graphics_set.cloud_background.shift[2] - 20

-- Remove ground strike effects
reverse_lightning.graphics_set.explosion = nil
reverse_lightning.graphics_set.ground_streamers = nil




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
    {property = "gravity", min = 1}
}
zeus_turret.prepare_range = 60
zeus_turret.rotation_speed = 0.02
zeus_turret.attack_parameters.cooldown = 30
zeus_turret.attack_parameters.range = 45
zeus_turret.attack_parameters.min_range = 8.75
-- Copy over lightning strike from the gun
zeus_turret.attack_parameters.ammo_type = table.deepcopy(data.raw["ammo"]["zeus-wrath-lightning-ammo"].ammo_type)

local force = "not-friend"
if settings.startup["zeus-wrath-friendly-fire"].value then
    force = "all"
end

-- Update friendly fire data
for i=1,#zeus_turret.attack_parameters.ammo_type.action.action_delivery[2].target_effects[2].action,1 do
    zeus_turret.attack_parameters.ammo_type.action.action_delivery[2].target_effects[2].action[i].force = force
end



-- Add self strike effect
zeus_turret.attack_parameters.ammo_type.action.action_delivery[3] = {
    type = "instant",
    source_effects = {
        {
            type = "script",
            effect_id = "zeus-wrath-self-strike"
        }
    }
}


zeus_turret.minable = {
    mining_time = 0.5,
    result = "zeus-wrath-zeus-turret"
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
zeus_turret.collision_box = {{-2.3, -2.3}, {2.3, 2.3}}
zeus_turret.selection_box = {{-2.5, -2.5}, {2.5, 2.5}}
zeus_turret.corpse = "zeus-wrath-zeus-turret-remnants"
zeus_turret.resistances = {
    { type = "electric", percent = 100 }
}

zeus_turret.drawing_box_vertical_extension = 3

--- Base graphics
zeus_turret.graphics_set = {
    base_visualisation = {
        -- Base
        {
            animation = {
                layers = {
                    {
                        layers = {
                            {
                                filename = "__zeus-wrath__/graphics/turret/hr_alt_beacon_base.png",
                                width = 198,
                                height = 340,
                                scale = 0.5 * 1.5,
                                line_length = 1,
                                frame_count = 1,
                                shift = {0, -1.1 * 1.5}
                            }
                        },
                    }
                }
            },
            render_layer = "lower-object-above-shadow"
        },
        -- Antenna and top
        {
            animation = {
                layers = {
                    {
                        filename = "__zeus-wrath__/graphics/turret/hr_alt_beacon_antenna.png",
                        width = 198,
                        height = 340,
                        scale = 0.5 * 1.5,
                        line_length = 1,
                        frame_count = 1,
                        shift = {0, -1.1 * 1.5}
                    },
                    {
                        filename = "__zeus-wrath__/graphics/turret/hr_alt_beacon_body.png",
                        width = 198,
                        height = 340,
                        scale = 0.5 * 1.5,
                        line_length = 1,
                        frame_count = 1,
                        shift = {0, -1.1 * 1.5},
                    },
                    -- Mask ver to tint 
                    {
                        filename = "__zeus-wrath__/graphics/turret/hr_alt_beacon_body.png",
                        width = 198,
                        height = 340,
                        scale = 0.5 * 1.5,
                        line_length = 1,
                        frame_count = 1,
                        shift = {0, -1.1 * 1.5},
                        apply_runtime_tint = true
                    },
                    {
                        filename = "__zeus-wrath__/graphics/turret/hr_alt_beacon_body_above.png",
                        width = 198,
                        height = 340,
                        scale = 0.5 * 1.5,
                        line_length = 1,
                        frame_count = 1,
                        shift = {0, -1.1 * 1.5}
                    }
                }
            },
            render_layer = "higher-object-under"
        },
        -- Shadow
        {
            animation = {
                layers = {
                    {
                        filename = "__zeus-wrath__/graphics/turret/hr_alt_beacon_shadow.png",
                        width = 366,
                        height = 204,
                        scale = 0.5 * 1.5,
                        line_length = 1,
                        frame_count = 1,
                        shift = {1.25 * 1.5, 0},
                        draw_as_shadow = true
                    }
                },
                draw_as_shadow = true
            }
        }
    }
}

local attack_animation = {
    layers = {
        {
            layers = {
                {
                    animation_speed = 0.5,
                    filename = "__zeus-wrath__/graphics/turret/hr_alt_beacon_base_animated.png",
                    line_length = 8,
                    frame_count = 32,
                    width = 198,
                    height = 340,
                    scale = 0.5 * 1.5,
                    shift = {0, -1.1 * 1.5},
                    draw_as_glow = true
                },
                {
                    animation_speed = 0.5,
                    filename = "__zeus-wrath__/graphics/turret/hr_alt_beacon_body_animated.png",
                    line_length = 8,
                    frame_count = 32,
                    width = 198,
                    height = 340,
                    scale = 0.5 * 1.5,
                    shift = {0, -1.1 * 1.5},
                    draw_as_glow = true,
                },
                -- Mask ver to tint 
                {
                    animation_speed = 0.5,
                    filename = "__zeus-wrath__/graphics/turret/hr_alt_beacon_body_animated.png",
                    line_length = 8,
                    frame_count = 32,
                    width = 198,
                    height = 340,
                    scale = 0.5 * 1.5,
                    shift = {0, -1.1 * 1.5},
                    draw_as_glow = true,
                    apply_runtime_tint = true
                },
                {
                    filename = "__zeus-wrath__/graphics/turret/hr_alt_beacon_body_above.png",
                    width = 198,
                    height = 340,
                    scale = 0.5 * 1.5,
                    line_length = 1,
                    frame_count = 1,
                    repeat_count = 32,
                    shift = {0, -1.1 * 1.5}
                }
            },
        },
        {
            layers = {
                {
                    animation_speed = 0.5,
                    filename = "__zeus-wrath__/graphics/turret/hr_alt_beacon_antenna_animated.png",
                    line_length = 8,
                    frame_count = 32,
                    width = 198,
                    height = 340,
                    scale = 0.5 * 1.5,
                    shift = {0, -1.1 * 1.5},
                    draw_as_glow = true
                }
            },
        }
    }
}


-- Remove unnecessary animations
zeus_turret.energy_glow_animation = nil
zeus_turret.preparing_animation = nil
zeus_turret.prepared_animation = nil
zeus_turret.folding_animation = nil
zeus_turret.prepared_alternative_animation = nil
zeus_turret.resource_indicator_animation = nil
zeus_turret.starting_attack_animation = attack_animation
zeus_turret.attacking_animation = attack_animation
zeus_turret.ending_attack_animation = attack_animation
-- Dirty hackjob to hide existing orb because I can't be bothered to remove it properly
zeus_turret.folded_animation.layers[1].scale = 0
zeus_turret.folded_animation.layers[2] = nil
zeus_turret.folded_animation.layers[3] = nil
zeus_turret.folded_animation.layers[4] = nil




data:extend({reverse_lightning, global_lightning, zeus_turret, turret_corpse})