function lighting_strike(event)
    if event.effect_id == "zeus-wrath-self-strike" then
        local surface = event.surface_index
        local source_position = event.source_entity.position
        source_position["y"] = source_position["y"] - 6 -- Move up by 6 tiles to originate from the tip
        
        local target_position = event.source_entity.position
        target_position["y"] = target_position["y"] - 6 - 20 -- Strikes 20 tiles in the sky

        -- Add some randomness to the sky strike position
        target_position["x"] = target_position["x"] + math.random(-5, 5)
        target_position["y"] = target_position["y"] + math.random(-1, 1)


        game.get_surface(surface).create_entity{
            name = "zeus-wrath-reverse-lightning",
            position = source_position,
            force = "player",
            target = target_position
        }
    end
end


script.on_event(defines.events.on_script_trigger_effect, lighting_strike)