data:extend({
    {
        type = "technology",
        name = "compressed-logistics",
        icon_size = 256,
        icon_mipmaps = 4,
        icon = "__base__/graphics/technology/automation-1.png",
        effects = {
            {
                type = "unlock-recipe",
                recipe = "aio-assembly-1"
            }
        },
        unit = {
            count = 40,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1}
            },
            time = 60
        },
        prerequisites = {
            "automation-2",
            "electric-energy-distribution-1",
            "steel-processing"
        },
        order = "c-a"
    }
})