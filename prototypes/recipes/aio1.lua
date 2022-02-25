local recipe = table.deepcopy(data.raw.recipe["assembling-machine-1"])
recipe.enabled = true
recipe.name = "aio-assembly-1"
recipe.ingredients = {
    {"inserter", 20},
    {"transport-belt", 25},
    {"iron-chest", 4},
    {"assembling-machine-1", 7},
    {"medium-electric-pole", 4}
}
recipe.result = "aio-assembly-1"
recipe.enabled = false

data:extend({recipe})